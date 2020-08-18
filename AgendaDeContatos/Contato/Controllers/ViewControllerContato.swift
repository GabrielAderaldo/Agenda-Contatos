//
//  ViewControllerContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Kingfisher

class ViewControllerContato: UIViewController, ServiceDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lbNomeLogin: UILabel!
    
    
    @IBOutlet weak var imgFotoContato: UIImageView!
    
    
    var auth:  ContatoService!
    var contact: [ContatoView] = []
    var usuario: UsuarioViewModel!
    var loginAuth: AuthenticationService!
    
    
    @IBOutlet weak var nomeHeaderContatos: UILabel!
    @IBOutlet weak var imagemContatos: UIImageView!
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    
    //criando o carregamento de atualizacao...
    let myRefreshControll: UIRefreshControl = {
        let refreshcontroll = UIRefreshControl()
        refreshcontroll.addTarget(self, action: #selector(ViewControllerContato.refresh), for: .valueChanged)
        return refreshcontroll
    }()
    
    
    @objc private func refresh(){
        self.auth.listarContato()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        
        let imageView = UIImageView()
      //  imageView.kf.setImage(with: URL(string: ""))
        
        //lbNomeLogin.text = nomeFoto.name
        
//        self.tableViewContato.refreshControl = self.refreshControl
        
       
        /*Criando a parte do view do Header*/
        var nomeHeader = SessionControll.shared.usuario.name
        var fotoHeader = SessionControll.shared.usuario.photoUrl
        
        nomeHeaderContatos.text = nomeHeader
        imgFotoContato.kf.setImage(with:fotoHeader)
        
        
        self.tableViewContatos.refreshControl = myRefreshControll
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //imagemContatos.kf.setImage(with: )
        self.auth.listarContato()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contact.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulat = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        celulat.textLabel?.text = contact[indexPath.row].nome
        
        // print("Contato: \(contact[indexPath.row].fotoUrl)")
        celulat.imageView?.kf.setImage(with: contact[indexPath.row].fotoUrl)
        
        return celulat
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let telaDetalhes = StoryboardScene.Detalhes.detalhesViewController.instantiate()
        telaDetalhes.contact = contact[indexPath.row]
        present(telaDetalhes, animated: true)

    }
    
    
    
    
    @IBAction func bntContatoAtualizar(_ sender: Any) {
        self.auth.logout()
        let Main = StoryboardScene.Main.initialScene.instantiate()
        
        func deslogar(){
            Main.modalPresentationStyle = .fullScreen
            present(Main, animated: true)
        }
        
        let telacontato = StoryboardScene.Contato.viewControllerContato.instantiate()
        telacontato.dismiss(animated: true,completion: deslogar)
        
    }
    
    
    @IBAction func bntContatoCadastrar(_ sender: Any) {
        
        
        let TelaCadastroContato = StoryboardScene.CadastroContato.viewControllerCadastroContato.instantiate()
        
        present(TelaCadastroContato, animated: true)
        
    }
    
    func success(type: ResponsetYPE) {
        
        self.contact = ContatoViewModel.getViews()
        
        
        tableViewContatos.reloadData()
        
        self.myRefreshControll.endRefreshing()
    }
    
    func failure(type: ResponsetYPE, error: String) {
        self.myRefreshControll.endRefreshing()
    }
    
}
