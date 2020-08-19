//
//  ViewControllerCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
//DFIXME: Migrar esta tela
//DFIXME: Lembrar de remover excesso de espaços em branco, tentar deixar no maximo 1 linha de espaço entre as linhas de codigo.
class CadastroViewController: UIViewController ,ServiceDelegate{
    
    //DFIXME: Os Alertas podem ser utilizados como variáveis locais da função onde são chamados. Geralmente utiliza-se como atributo da classe apenas as variáveis que serão reutilizadas em varios métodos da classe.
    
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confirmacaoEmailTxt: UITextField!
    @IBOutlet weak var senhaTxt: UITextField!
    @IBOutlet weak var confirmacaoSenhaTxt: UITextField!
    
    @IBOutlet weak var imgCadastro: UITextField!
    //DFIXME: Se essas duas variaveis forem ser utilizadas apenas dentro da funcao "bntCadastrar", você pode intanciá-las apenas la dentro da função.

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
            
            let validacaoArroba = localEmail.hasPrefix("@")
            
            
            //FIXME: Sugestões:
            //emailValida = localEmail == confirmaEmailLocal
            //senhaValida = localSenha == confirmaSenhaLocal
            // if emailValida && senhaValida {
            //     self.auth.cadastro...
            // }
            
            if localEmail != confirmaEmailLocal {
                emailValida = false
                
            }else if localSenha != confirmaSenhaLocal{
                senhaValida = false
            }else/* if validacaoArroba != true{
                let telaAvisoEmailvalidacao = UIAlertController(title: "Aviso", message: "seu email, não é um email Valido: EX: chocolate@xxxx.com", preferredStyle: .alert)
                telaAvisoEmailvalidacao.addAction(UIAlertAction(title: "Ok", style: .default))
                present(telaAvisoEmailvalidacao, animated: true)
                
                
            }else/* if validacaoSenhaArroba != true {
                let telaAvisoEmailvalidacao = UIAlertController(title: "Aviso", message: "Sua senha não é forte o bastante,Use uma senha forte... EX: Gabriel@987", preferredStyle: .alert)
                               telaAvisoEmailvalidacao.addAction(UIAlertAction(title: "Ok", style: .default))
                               present(telaAvisoEmailvalidacao, animated: true)
                               
                
                
                }else*/*/{
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
        
        
        //DFIXME: O serviço de cadastro já retorna um usuario com troken valido. Então, você pode trocar para a tela de contatos logo após o sucesso do request de cadastrar.
    }
    
    func failure(type: ResponseType, error: String) {
        
        let avisoValidacaoSenha = UIAlertController(title: "Verificar dados...", message: "Confira a Senha digitada", preferredStyle: .alert)
        
        avisoValidacaoSenha.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        self.present(avisoValidacaoSenha,animated: true)
            
    }
        

    }
