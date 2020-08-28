//
//  ViewControllerCadastroContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class CadastroContatoViewController: UIViewController, ServiceDelegate {
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var telefoneTxt: UITextField!
    @IBOutlet weak var fotoTxt: UITextField!
    
    var  authContatos: ContatoService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authContatos = ContatoService(delegate: self)
    }
    
    @IBAction func bntVoltar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func bntSalvarContato(_ sender: Any) {
        
        if let localNome = self.nomeTxt.text,
           let localEmail = self.emailTxt.text,
           let localTelefone = self.telefoneTxt.text,
           let localFoto = self.fotoTxt.text{
            
            let newContato = ContatoView(id: "",
                                         nome: localNome,
                                         foto: localFoto,
                                         email: localEmail,
                                         fone: localTelefone)
            
            self.authContatos.cadastroContato(contato: ContatoViewModel.getAsModel(newContato))
        }
    }
    
   
    
    func success(type: ResponseType) {
       
        let telaAvisoSucessoContato = UIAlertController(title: L10n.Msg.sucesso, message: L10n.Msg.Sucesso.Contato.cadastro, preferredStyle: .alert)
        telaAvisoSucessoContato.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
            
            self.dismiss(animated: true)
        }))
        
        present(telaAvisoSucessoContato, animated: true)
    }
    
    
    func failure(type: ResponseType, error: String) {
        
        let telaAvisoFalhaContato = UIAlertController(title: L10n.Msg.Fracasso.cadastro , message: L10n.Msg.Fracasso.Contato.cadastro, preferredStyle: .alert)
        telaAvisoFalhaContato.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
        present(telaAvisoFalhaContato, animated: true)
    }
}

