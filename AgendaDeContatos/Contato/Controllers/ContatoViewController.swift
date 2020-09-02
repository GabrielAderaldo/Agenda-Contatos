//
//  ViewControllerContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Kingfisher

class ContatoViewController: UIViewController {
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    var authContatos:  ContatoService!
    var autorizacaoLogin: AuthenticationService!
    
    var contact: [[ContatoView]] = []
    
    let myRefreshControll: UIRefreshControl = {
        let refreshcontroll = UIRefreshControl()
        refreshcontroll.addTarget(self, action: #selector(ContatoViewController.refresh), for: .valueChanged)
        return refreshcontroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationController()
        self.setupTableView()
        
        self.autorizacaoLogin = AuthenticationService(delegate: self)
        self.authContatos = ContatoService(delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.authContatos.listarContato()
    }
    
    func setupNavigationController() {
        
        self.title = L10n.Contatos.title
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setupNavegationItens()
    }
    
    func setupNavegationItens(){
        
        let bntCadastro = UIBarButtonItem(image: Asset.bntAdicionar.image, style: .done, target: self, action: #selector(self.bntContatoCadastrar))
        let bntLogout = UIBarButtonItem(image:Asset.bntDeslogar.image, style: .plain, target: self, action: #selector(self.bntLogout))
        self.navigationItem.rightBarButtonItems = [bntCadastro, bntLogout]
    }
}

//MARK: Actions
extension ContatoViewController {
    
    @objc private func refresh(){
        self.authContatos.listarContato()
    }
    
    @objc func bntLogout() {
        
        self.autorizacaoLogin.logout()
    }
    
    @objc func bntContatoCadastrar() {
        
        let telaCadastro = StoryboardScene.Contato.cadastroContatoViewController.instantiate()
        telaCadastro.modalPresentationStyle = .fullScreen
        present(telaCadastro, animated: true)
    }
}

//MARK: TableView Functions
extension ContatoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        self.tableViewContatos.register(cellType: ContatoTableViewCell.self)
        
        let header = UserHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
        header.bind(user: SessionControll.shared.usuario)
        self.tableViewContatos.tableHeaderView = header
        
        //        self.tableViewContatos.refreshControl = myRefreshControll
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let telaDetalhes = StoryboardScene.Contato.detalhesViewController.instantiate()
        telaDetalhes.modalPresentationStyle = .fullScreen
        telaDetalhes.contact = contact[indexPath.section][indexPath.row]
        
        self.navigationController?.pushViewController(telaDetalhes, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: ServiceDelegate functions
extension ContatoViewController: ServiceDelegate {
    
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


