//
//  ViewControllerCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController ,ServiceDelegate{
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confirmacaoEmailTxt: UITextField!
    @IBOutlet weak var senhaTxt: UITextField!
    @IBOutlet weak var confirmacaoSenhaTxt: UITextField!
    
    @IBOutlet weak var imgCadastro: UITextField!
    
    var auth: AuthenticationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = AuthenticationService(delegate: self)
    }
      //vericando se o email é igual...
    func emailIgual(email:String,novoEmail:String) -> Bool{
        if email != novoEmail {return false}
        else{return true}
    }
    //verificando se a senha é igual...
    func senhaIgual(senha:String,senhaNova:String) -> Bool{
                   if senha != senhaNova {return false}
                   else{return true}
               }
    
    @IBAction func bntCadastrar(_ sender: Any) {

            //Basicamente estou re-formulando toda a tela, deixando mais legivel e simples...
        
            //chamando as variaveis
        if  let localNome = nomeTxt.text,
            let localEmail = emailTxt.text,
            let localEmailConfirmado = confirmacaoEmailTxt.text,
            let localSenha = senhaTxt.text,
            let localSenhaConfirma = confirmacaoSenhaTxt.text,
            let localImagem = imgCadastro.text{
             
            //criando as validacoes: Email.
            let strgEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let valiEmail = NSPredicate(format: "SELF MATCHES %@", strgEmail)
            let respostaValidacaoEmail = valiEmail.evaluate(with: localEmail)
            //criando as validacoes: Senha
            let strgSenha = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
            let valiSenha = NSPredicate(format: "SELF MATCHES %@", strgSenha)
            let respostaValidacaoSenha = valiSenha.evaluate(with: localSenha)
            
          
           
            
            
           
            
            //criar agora a maior parte...
            if emailIgual(email: localEmail, novoEmail: localEmailConfirmado) != true {
                //aviso de erro:
                let telaFalha = UIAlertController(title:L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Cadastro.email, preferredStyle: .alert)
                telaFalha.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default))
                present(telaFalha, animated: true)
                
            }else if senhaIgual(senha: localSenha, senhaNova: localSenhaConfirma) != true {
                let telaFalha = UIAlertController(title:L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Cadastro.senha, preferredStyle: .alert)
                telaFalha.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default))
                present(telaFalha, animated: true)
            }else if respostaValidacaoEmail != true {
                let telaFalha = UIAlertController(title:L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Cadastro.emailInvalido, preferredStyle: .alert)
                telaFalha.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default))
                present(telaFalha, animated: true)
            }else if respostaValidacaoSenha != true{
                let telaFalha = UIAlertController(title:L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Cadastro.senhaInvalido, preferredStyle: .alert)
                telaFalha.addAction(UIAlertAction(title:L10n.Msg.ok, style: .default))
                present(telaFalha, animated: true)
                
            }else{
               
                //A confirmacao para o login é passar para a proxima tela...
                auth.cadastro(nome: localNome, foto: localImagem, email: localEmail, senha: localSenha)
             
            }
        }
    }
    
    @IBAction func bntVoltarCadastro(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func success(type: ResponseType) {
        
        let telaContato = StoryboardScene.Contato.contatoViewController.instantiate()
        present(telaContato, animated: true)
    }
    
    func failure(type: ResponseType, error: String) {
        
        let avisoValidacaoSenha = UIAlertController(title: "Verificar dados...", message: "Confira a Senha digitada", preferredStyle: .alert)
        
        avisoValidacaoSenha.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        self.present(avisoValidacaoSenha,animated: true)
    }
}
