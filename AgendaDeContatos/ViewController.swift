//
//  ViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bntEntrar: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func bntCadastrar(_ sender: Any) {
    
        let cadastroStance = StoryboardScene.Cadastro.viewControllerCadastro.instantiate()
        
        cadastroStance.modalPresentationStyle = .fullScreen
        self.present(cadastroStance, animated: true)
        
           
    
    }
    
    
    @IBAction func bntEntrar(_ sender: Any) {
        
        let loginStance = StoryboardScene.Login.viewControllerLogin.instantiate()
        loginStance.modalPresentationStyle = .fullScreen
        self.present(loginStance, animated: true)
        
    }
    
}

