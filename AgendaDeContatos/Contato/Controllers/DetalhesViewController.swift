//
//  DetalhesViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 14/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.


import UIKit
import Kingfisher


class DetalhesViewController: UIViewController, ServiceDelegate{
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbTelefone: UILabel!
    @IBOutlet weak var imagemDetalhes: UIImageView!
    
    //FIXME: Remover variaveis nao utilizadas.
    @IBOutlet weak var tabelaDetalhes: UITableView!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtFoto: UITextField!
    
    var auth:  ContatoService! //FIXME: Renomear essa variavel auth pois ela é referente ao service de contatos.
    var contact: ContatoView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //FIXME: Atualizar tela com as informacoes atualizadas.
        
        imagemDetalhes.kf.setImage(with: contact?.fotoUrl)
        
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
    
    @IBAction func bntAtualizar(_ sender: Any) {
        let telaAtualizar = StoryboardScene.Contato.atualizarViewController.instantiate()
        telaAtualizar.contact = contact
        present(telaAtualizar, animated: true)
        
    }
    
    
    
    @IBAction func bntDelete(_ sender: Any) {
        
        if let localId = contact?.id {
            self.auth.deletarContato(id: localId)
        }
    }
    
    func success(type: ResponseType) {
        
        switch type {
        case .deleteContato:
           
            let telaAvisoSucesso = UIAlertController(title: L10n.Msg.sucesso, message: L10n.Msg.Sucesso.Contato.deletar, preferredStyle: .alert)
            
            telaAvisoSucesso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
                self.dismiss(animated: true)
            }))
            present(telaAvisoSucesso, animated: true)
            default:
            
            print("Algo aconteceu...")
        }
        
        
    }
    
    func failure(type: ResponseType, error: String) {
        switch type{
        case .deleteContato:
            
            let telaAviso  = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.deletar, preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
            present(telaAviso, animated: true)
            
        default:
            print("Algo deu errado...")
        }
    }
    
    
    
}
