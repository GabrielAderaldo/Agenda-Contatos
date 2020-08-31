//
//  ViewControllerAtualizar.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 13/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class AtualizarViewController: UIViewController,ServiceDelegate {
    
    @IBOutlet weak var bntAtt: UIButton!
    @IBOutlet weak var idNome: UITextField!
    @IBOutlet weak var idEmail: UITextField!
    @IBOutlet weak var idTelefone: UITextField!
    @IBOutlet weak var idFoto: UITextField!
    @IBOutlet weak var uivImgFotoHeader: UIImageView!
    
    var authContatos: ContatoService!
    var contact: ContatoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authContatos = ContatoService(delegate: self)
       
        uivImgFotoHeader.kf.setImage(with: contact.fotoUrl,placeholder: Asset.placeHolder.image)
        
        
        //arrendondando a imagem...
        uivImgFotoHeader.layer.cornerRadius = 100
        uivImgFotoHeader.clipsToBounds = true
        
        //Iniciando já os valores anteriores...
        idNome.text = contact?.nome
        idTelefone.text = contact?.fone
        idEmail.text = contact?.email
        idFoto.text = contact?.foto
        
        bntAtt.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bntAtualizar(_ sender: Any) {
        
        if let localNome = self.idNome.text,
           let localEmail = self.idEmail.text,
           let localTelefone = self.idTelefone.text,
           let localFoto = self.idFoto.text {
            
            let newContato = ContatoView(id: contact.id, nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone)
            
            self.authContatos.atualizarContato(contato: ContatoViewModel.getAsModel(newContato))
        }
    }
    
    func success(type: ResponseType) {
        
        let avisoSucesso = UIAlertController(title: L10n.Msg.sucesso, message: L10n.Msg.Sucesso.Contato.atualizar, preferredStyle: .alert)
        avisoSucesso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(avisoSucesso, animated: true, completion: nil)
    }
    
    func failure(type: ResponseType, error: String) {
        let avisoFalha = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.atualizar, preferredStyle: .alert)
        avisoFalha.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(avisoFalha, animated: true)
    }
    
}
