//
//  ViewControllerCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
//DFIXME: Lembrar de remover excesso de espaços em branco, tentar deixar no maximo 1 linha de espaço entre as linhas de codigo.
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
    
    
    @IBAction func bntCadastrar(_ sender: Any) {
      let avisoValidacaoEmail = UIAlertController(title: "Verificar dados...", message: "Confira o Email digitado", preferredStyle: .alert)
      
      
      
       let avisoCadastroSucesso = UIAlertController(title: "Sucesso!", message: "Seu cadastro foi efetuado com Sucesso!", preferredStyle: .alert)
      
        
        
        var senhaValida:Bool!
        var emailValida:Bool!
        
        //Fazendo as validacoes, do front...
    /*
        var localNome:String? = ""
        var localEmail:String? = ""
        var confirmaEmailLocal:String? = ""
        var localSenha:String? = ""
        var confirmaSenhaLocal:String? = ""
        
      */
        
        
        if let localNome = self.nomeTxt.text,
           let localEmail = self.emailTxt.text,
           let confirmaEmailLocal = self.confirmacaoEmailTxt.text,
           let localSenha = self.senhaTxt.text,
           let confirmaSenhaLocal = self.confirmacaoSenhaTxt.text,
            let localfotoUrl = imgCadastro.text{
            
            
            
            //Fazendo as validacoes...
            //Validacao email...
            var resultadoEmail = localEmail.contains("@")
            var resultadoEmail2 = localEmail.contains(".")
            var controleValidaEmail:String = "defalt"
            //validacao da senha
            var resultadoSenhaArroba = localSenha.contains("@")
            var resultadoSenhaEsclama = localSenha.contains("!")
            var resultadoSenhaJogo = localSenha.contains("#")
            var resultadoSenhaSif = localSenha.contains("$")
            var resultadoSenhaPor = localSenha.contains("%")
            var resultadoSenhaElev = localSenha.contains("ˆ")
            var resultadoSenhaEcome = localSenha.contains("&")
            var resultadoSenhaCoisinha = localSenha.contains("*")
            var controleValidaSenha:String = "defaut"
            var controleNumero = localEmail.count

            
            if resultadoSenhaCoisinha || resultadoSenhaPor || resultadoSenhaEcome || resultadoSenhaSif || resultadoSenhaJogo || resultadoSenhaArroba || resultadoSenhaEsclama || resultadoSenhaElev == true{
                controleValidaSenha = "true"
            }else{
                controleValidaSenha = "false"
            }
            
           
            if resultadoEmail && resultadoEmail2 == true{
                controleValidaEmail = "true"
            }else{
                controleValidaEmail = "false"
            }
            
            //criando as variaveis para fazer as verificacoes...
            
            
            //DFIXME: Sugestões:
            //emailValida = localEmail == confirmaEmailLocal
            //senhaValida = localSenha == confirmaSenhaLocal
            // if emailValida && senhaValida {
            //     self.auth.cadastro...
            // }
            print(controleNumero)
            if localEmail != confirmaEmailLocal {
                emailValida = false
                
            }else if localSenha != confirmaSenhaLocal{
                senhaValida = false
            }else if controleValidaEmail != "true"{
                let telaAvisoEmailvalidacao = UIAlertController(title: "Aviso", message: "seu email, não é um email Valido: EX: chocolate@xxxx.com", preferredStyle: .alert)
                telaAvisoEmailvalidacao.addAction(UIAlertAction(title: "Ok", style: .default))
                present(telaAvisoEmailvalidacao, animated: true)
                
            }else if controleValidaSenha != "true" /*&&  controleNumero  > 5*/{
                let telaAvisoEmailvalidacao = UIAlertController(title: "Aviso", message: "Sua senha não é forte o bastante,Use uma senha forte... EX: Gabriel@987", preferredStyle: .alert)
                               telaAvisoEmailvalidacao.addAction(UIAlertAction(title: "Ok", style: .default))
                               present(telaAvisoEmailvalidacao, animated: true)
                               
                
                
                }else{
                self.auth.cadastro(nome: localNome, foto:localfotoUrl , email: localEmail, senha: localSenha)
            }
            
        }
        
    
        
        
        /*
        localNome = nomeTxt.text
        localEmail = emailTxt.text
        confirmaEmailLocal = confirmacaoEmailTxt.text
        localSenha = senhaTxt.text
        confirmaSenhaLocal = confirmacaoSenhaTxt.text
        */
        
        
        
        
        
     
        
        
    }
    
    
    
    

    @IBAction func bntVoltarCadastro(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func success(type: ResponseType) {
       
       /*
            Comentei aqui por que, se der erro que vou notificar ao usuario... a mensagem de sucesso vai ser logar...
        avisoCadastroSucesso.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))
        self.present(avisoCadastroSucesso,animated: true)
        
        */
        let telaContato = StoryboardScene.Contato.viewControllerContato.instantiate()
        telaContato.modalPresentationStyle = .fullScreen
        present(telaContato, animated: true)
    }
    
    func failure(type: ResponseType, error: String) {
        
        let avisoValidacaoSenha = UIAlertController(title: "Verificar dados...", message: "Confira a Senha digitada", preferredStyle: .alert)
        
        avisoValidacaoSenha.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        self.present(avisoValidacaoSenha,animated: true)
            
    }
        

    }
