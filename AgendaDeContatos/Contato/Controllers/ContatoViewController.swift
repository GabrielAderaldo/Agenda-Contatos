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
        
        self.setupNavigationController()
        self.setupTableView()
        
        self.autorizacaoLogin = AuthenticationService(delegate: self)
        self.authContatos = ContatoService(delegate: self)
        
        
        
//FIXME: Sugestão - Voce pode criar uma função separada pra fazer a configuração abaixo e chamá-la aqui:
//      {
//      }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.authContatos.listarContato()
    }
    
    func setupNavigationController() {
        
        self.title = "Contatos"
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupNavegationItens()
    }

    func setupNavegationItens(){
        
        
        
        let bntCadastro = UIBarButtonItem(image: Asset.bntAdicionar.image, style: .done, target: self, action: #selector(self.bntContatoCadastrar))
        let bntLogout = UIBarButtonItem(image:Asset.bntDeslogar.image, style: .plain, target: self, action: #selector(self.bntLogout))
        self.navigationItem.rightBarButtonItems = [bntCadastro, bntLogout]
    }
    
    func setupTableView() {
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        self.tableViewContatos.register(cellType: ContatoTableViewCell.self)
        
        let header = UserHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        header.bind(user: SessionControll.shared.usuario)
        self.tableViewContatos.tableHeaderView = header
        
//        self.tableViewContatos.refreshControl = myRefreshControll
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /*
        let header = UserHeaderView(frame: .zero)
        header.bind(letra: "\(self.contact[section].first?.nome.first ?? Character(" "))")
        return header
        */
        
        let headerLetra = LetraHeaderView(frame: .zero)
        headerLetra.bind(letra: "\(self.contact[section].first?.nome.first ?? Character(" "))")
        return headerLetra
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contact[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(for: indexPath) as ContatoTableViewCell
        
        cell.bind(contato: contact[indexPath.section][indexPath.row])
        
        return cell
        
//        let celulat = UITableViewCell(style: .default, reuseIdentifier: nil)
//
//        celulat.textLabel?.text = contact[indexPath.section][indexPath.row].nome
//        celulat.imageView?.kf.setImage(with: contact[indexPath.section][indexPath.row].fotoUrl)
//        return celulat
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let telaDetalhes = StoryboardScene.Contato.detalhesViewController.instantiate()
        telaDetalhes.modalPresentationStyle = .fullScreen
        telaDetalhes.contact = contact[indexPath.section][indexPath.row]
        
//        self.present(telaDetalhes, animated: true)
        self.navigationController?.pushViewController(telaDetalhes, animated: true)
    }
     
    @objc func bntLogout() {
        
        self.autorizacaoLogin.logout()
    }
    
    @objc func bntContatoCadastrar() {
        
        let telaCadastro = StoryboardScene.Contato.cadastroContatoViewController.instantiate()
        telaCadastro.modalPresentationStyle = .fullScreen
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
