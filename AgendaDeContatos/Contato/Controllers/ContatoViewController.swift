//
//  ViewControllerContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Kingfisher

//DFIXME: É recomendado utilizar uma celular costumizada. Depois posso te ensinar isso tambem.
//DFIXME: utilizar funções da tableView comoo heightForRow, heightForHeader, heightForFooter para costumiza-la melhor


class ContatoViewController: UIViewController, ServiceDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lbNomeLogin: UILabel!
    @IBOutlet weak var imgFotoContato: UIImageView!
    @IBOutlet weak var nomeHeaderContatos: UILabel!
    @IBOutlet weak var imagemContatos: UIImageView!
    @IBOutlet weak var tableViewContatos: UITableView!
    
    var authContatos:  ContatoService! //DFIXME: Renomear essa variavel auth pois ela é referente ao service de contatos.
    var autorizacaoLogin: AuthenticationService!
    
    var contact: [[ContatoView]] = []
    var usuario: UsuarioViewModel! //DFIXME: remover variaveis que nao estao sendo utilizadas.
    
    let myRefreshControll: UIRefreshControl = {
        let refreshcontroll = UIRefreshControl()
        refreshcontroll.addTarget(self, action: #selector(ContatoViewController.refresh), for: .valueChanged)
        return refreshcontroll
    }()
    
    @objc private func refresh(){
        self.authContatos.listarContato()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autorizacaoLogin = AuthenticationService(delegate: self)
        self.authContatos = ContatoService(delegate: self)
        
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        
//FIXME: Sugestão - Voce pode criar uma função separada pra fazer a configuração abaixo e chamá-la aqui:
//      {
        imgFotoContato.layer.cornerRadius = 60
        imgFotoContato.clipsToBounds = true
        
        nomeHeaderContatos.text = SessionControll.shared.usuario.name
        imgFotoContato.kf.setImage(with: SessionControll.shared.usuario.photoUrl)
//      }
        
        self.tableViewContatos.refreshControl = myRefreshControll
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.authContatos.listarContato()
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "\(self.contact[section].first?.nome.first ?? Character(" "))"
        label.backgroundColor = UIColor.white
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contact[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: Fazer celular personalizada. Me chamar.
        let celulat = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        celulat.textLabel?.text = contact[indexPath.section][indexPath.row].nome
        celulat.imageView?.kf.setImage(with: contact[indexPath.section][indexPath.row].fotoUrl)
        return celulat
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let telaDetalhes = StoryboardScene.Contato.detalhesViewController.instantiate()
        telaDetalhes.modalPresentationStyle = .fullScreen
        telaDetalhes.contact = contact[indexPath.section][indexPath.row]
        
        self.present(telaDetalhes, animated: true)
    }
     
    @IBAction func bntLogout(_ sender: Any) {
        
        self.autorizacaoLogin.logout()
    }
    
    @IBAction func bntContatoCadastrar(_ sender: Any) {
        
        let telaCadastro = StoryboardScene.Contato.cadastroContatoViewController.instantiate()
        present(telaCadastro, animated: true)
        
    }
    
    func success(type: ResponseType) {
        
        switch type {
        case .logout:
            
            ScreenManager.setupInitialViewController()
            
        case .listagemContato:
            
            self.contact = ContatoViewModel.getAsMatriz()
            
            tableViewContatos.reloadData()
            
        default:
            break
        }
        
        self.myRefreshControll.endRefreshing()
    }
    
    func failure(type: ResponseType, error: String) {
        
        switch type {
        case .logout:
            
            ScreenManager.setupInitialViewController()
            
        default:
            break
        }
        
        self.myRefreshControll.endRefreshing()
    }
    
}