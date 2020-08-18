//
//  ViewControllerCadastroContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class ViewControllerCadastroContato: UIViewController, ServiceDelegate {
    
    var auth: ContatoService!
    
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var telefoneTxt: UITextField!
    @IBOutlet weak var fotoTxt: UITextField!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
        
        
    }
    
    @IBAction func bntDoisCadastroVoltar(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func bntSalvarContato(_ sender: Any) {
        
        if let localNome = self.nomeTxt.text, let localEmail = self.emailTxt.text,
            let localTelefone = self.telefoneTxt.text, let localFoto = self.fotoTxt.text{
            
            self.auth.cadastroContato(nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone)
            
        }
        
    }
    
    
    
    
    
    @IBAction func bntVoltarContatoCadastro(_ sender: Any) {}
    
    
    
    func success(type: ResponsetYPE) {
        let telaAvisoSucessoContato = UIAlertController(title: "Sucesso!", message: "Seu contato foi cadastrado com sucesso!", preferredStyle: .alert)
        telaAvisoSucessoContato.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(telaAvisoSucessoContato, animated: true)
        
        //FIXME: Você pode usar o dismiss pra fechar a tela logo após o usuário apertar no botão ok. Para isso vocÊ pode utilizar o handler do UIAlertAction.
    }
    
    
    func failure(type: ResponsetYPE, error: String) {
        let telaAvisoFalhaContato = UIAlertController(title: "Falha", message: "Infelismente ocorreu um erro na execucao, tente novamente", preferredStyle: .alert)
        telaAvisoFalhaContato.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(telaAvisoFalhaContato, animated: true)
    }
    
    
}
