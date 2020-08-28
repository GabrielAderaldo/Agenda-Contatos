//
//  ViewControllerLogin.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 10/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController, ServiceDelegate{

    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    var auth: AuthenticationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = AuthenticationService(delegate: self)
    }
    
    @IBAction func bntLogarValidacao(_ sender: Any) {
        
        if let localLogin = self.txtLogin.text, let localSenha = self.txtSenha.text {
            
            self.auth.login(email: localLogin, senha: localSenha)
        }
    }
    
    @IBAction func bntCadastro(_ sender: Any) {
        let telaCadastro = StoryboardScene.Login.viewControllerCadastro.instantiate()
        present(telaCadastro, animated: true)
    }

    func success(type: ResponseType) {
        
        ScreenManager.setupInitialViewController()
    }
    
    func failure(type: ResponseType, error: String) {
 
        let erroLogin = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.login, preferredStyle: .alert)
        
        erroLogin.addAction(UIAlertAction(title: L10n.f, style: .default, handler: nil))
        
        self.present(erroLogin, animated: true)
    
    }
}
