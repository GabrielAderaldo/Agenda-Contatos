//
//  DetalhesViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 14/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.


import UIKit
import Kingfisher


class DetalhesViewController: UIViewController, ServiceDelegate{
    
    @IBOutlet weak var bntDeletar: UIButton!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbTelefone: UILabel!
    @IBOutlet weak var imagemDetalhes: UIImageView!
   
    var authContatos:  ContatoService!
    var contact: ContatoView?

    //criando a funcao do menu bonitinho...
    func setupNavegationItens(){
        let bntAtualizar = UIBarButtonItem(title:"Atualizar", style: .done, target: self, action: #selector(self.bntAtualizar))
        self.navigationItem.rightBarButtonItems = [bntAtualizar]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authContatos = ContatoService(delegate: self)
        self.setupNavegationItens()
        self.atualizar()
        bntDeletar.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.authContatos.listarAtualizado(id: contact?.id ?? "")
    }
    
    func atualizar(){
        
        imagemDetalhes.kf.setImage(with: contact?.fotoUrl,placeholder: Asset.placeHolder.image)
        
        imagemDetalhes.layer.cornerRadius = 100
        imagemDetalhes.clipsToBounds = true
        
        lbNome.text = contact?.nome
        lbEmail.text = contact?.email
        lbTelefone.text = contact?.fone
    }

    //Botoes ficam aquii
    @IBAction func bntVoltar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @objc func bntAtualizar() {
        
        let telaAtualizar = StoryboardScene.Contato.atualizarViewController.instantiate()
        telaAtualizar.contact = contact
       
        self.navigationController?.pushViewController(telaAtualizar, animated: true)
    }

    @IBAction func bntDelete(_ sender: Any) {
        
        if let localId = contact?.id {
            self.authContatos.deletarContato(id: localId)
        }
    }
    
    func success(type: ResponseType) {
        
        switch type {
        case .buscaContato:
            self.contact = ContatoViewModel.get(by: contact?.id ?? "")
            
            self.atualizar()
            
        case .deleteContato:
           
            let telaAvisoSucesso = UIAlertController(title: L10n.Msg.sucesso, message: L10n.Msg.Sucesso.Contato.deletar, preferredStyle: .alert)
            
            telaAvisoSucesso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(telaAvisoSucesso, animated: true)
            
            default:
                break
        }
        
        
    }
    
    func failure(type: ResponseType, error: String) {
        switch type{
        case.buscaContato:
             let telaAviso  = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.atualizar, preferredStyle: .alert)
             telaAviso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
             present(telaAviso, animated: true)
        case .deleteContato:
            
            let telaAviso  = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.deletar, preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
            present(telaAviso, animated: true)
            
        default:
            print("Algo deu errado...")
        }
    }
    
    
    
}

