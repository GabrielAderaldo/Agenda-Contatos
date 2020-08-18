//
//  ViewControllerLogin.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 10/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController, ServiceDelegate{

    var auth: AuthenticationService!
    var passarFoto: [UsuarioViewModel] = []
    
    
    
    
    
    @IBOutlet weak var txtLogin: UITextField!
    
    @IBOutlet weak var txtSenha: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
//        self.dismiss(animated: true)
        
        self.auth = AuthenticationService(delegate: self)
    }
    
    
    @IBAction func bntLogarValidacao(_ sender: Any) {
        if let localLogin = self.txtLogin.text, let localSenha = self.txtSenha.text {
            self.auth.login(email: localLogin, senha: localSenha)
        }
        
        let telaContatos = StoryboardScene.Contato.viewControllerContato.instantiate()
        
        
        
        
        
    }
    
    
    
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func success(type: ResponsetYPE) {

        let telaContato = StoryboardScene.Contato.viewControllerContato.instantiate()
        telaContato.modalPresentationStyle = .fullScreen
        present(telaContato, animated: true)
    }
    
    func failure(type: ResponsetYPE, error: String) {
        //Criar um alerta de erro
        let erroLogin = UIAlertController(title: "Erro ao logar", message: "Verifique seu Email e sua senha...", preferredStyle: .alert)
        
        erroLogin.addAction(UIAlertAction(title: "fechar", style: .default, handler: nil))
        
        
        self.present(erroLogin, animated: true)
    }
    
}
