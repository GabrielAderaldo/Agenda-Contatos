//
//  ViewControllerLogin.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 10/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

//FIXME: Buscar manter o padrão: <Nome>ViewController. Ex: LoginViewController.
// - OBS:
// - Fazer isso com as outras Controllers tambem. (ViewControllerCadastro, ViewControllerContato, ViewControllerCadastroContato, ViewControllerAtualizar)
// - Como renomear uma classe ou variavel?
// 1. Segure o botão "command".
// 2. Clique no nome da classe ou variavel.
// 3. Selecione a opção "Rename".
// 4. Escreva o novo nome da classe ou variável.
// 5. Clique na opção "Rename".

class ViewControllerLogin: UIViewController, ServiceDelegate{

    var auth: AuthenticationService!
    
    var passarFoto: [UsuarioViewModel] = [] //FIXME: Sempre tentar lembrar de apagar variáveis e funções que não estão sendo utilizadas.
    
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
        
        self.present(telaContato, animated: true)
    }
    
    func failure(type: ResponsetYPE, error: String) {
        //Criar um alerta de erro
        
        //FIXME: Melhoria -> Colocar essas Strings no arquivo de Strings no seguinte
        // "AgendaDeContatos/Application/Supporting Files/Generators/Localizable.strings"
        // - OBS:
        // - Como acessar?
        // - Ex: L10n.Common.ok
        // - O codigo do exemplo acima irá retornar a string que você colocar no valor
        let erroLogin = UIAlertController(title: "Erro ao logar", message: "Verifique seu Email e sua senha...", preferredStyle: .alert)
        
        erroLogin.addAction(UIAlertAction(title: "fechar", style: .default, handler: nil))
        
        self.present(erroLogin, animated: true)
        
    }
    
}
