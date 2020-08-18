//
//  ViewControllerContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Kingfisher

//FIXME: É recomendado utilizar uma celular costumizada. Depois posso te ensinar isso tambem.
//FIXME: utilizar funções da tableView comoo heightForRow, heightForHeader, heightForFooter para costumiza-la melhor


class ViewControllerContato: UIViewController, ServiceDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewContato: UITableView!
    
    var auth:  ContatoService!
    var contact: [ContatoView] = []
    var usuario: UsuarioViewModel!
    var loginAuth: AuthenticationService!
    
    
    
    @IBOutlet weak var nomeHeaderContatos: UILabel!
    @IBOutlet weak var imagemContatos: UIImageView!
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: ""))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //imagemContatos.kf.setImage(with: )
        
        super.viewWillAppear(true)
        self.auth.listarContato()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { timer in
            super.viewWillAppear(true)
            self.auth.listarContato()
            
        })
        
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
        
        var id = contact[indexPath.row].id
        
        
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
        
    }
    
    func failure(type: ResponsetYPE, error: String) {
        
    }
    
}
