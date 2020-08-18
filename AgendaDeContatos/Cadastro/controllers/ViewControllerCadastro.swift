//
//  ViewControllerCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
//FIXME: Migrar esta tela
//FIXME: Lembrar de remover excesso de espaços em branco, tentar deixar no maximo 1 linha de espaço entre as linhas de codigo.
class ViewControllerCadastro: UIViewController ,ServiceDelegate{
    
    //FIXME: Os Alertas podem ser utilizados como variáveis locais da função onde são chamados. Geralmente utiliza-se como atributo da classe apenas as variáveis que serão reutilizadas em varios métodos da classe.
    let avisoValidacaoEmail = UIAlertController(title: "Verificar dados...", message: "Confira o Email digitado", preferredStyle: .alert)
    
    let avisoValidacaoSenha = UIAlertController(title: "Verificar dados...", message: "Confira a Senha digitada", preferredStyle: .alert)
    
     let avisoCadastroSucesso = UIAlertController(title: "Sucesso!", message: "Seu cadastro foi efetuado com Sucesso!", preferredStyle: .alert)
    
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confirmacaoEmailTxt: UITextField!
    @IBOutlet weak var senhaTxt: UITextField!
    @IBOutlet weak var confirmacaoSenhaTxt: UITextField!
    
    //FIXME: Se essas duas variaveis forem ser utilizadas apenas dentro da funcao "bntCadastrar", você pode intanciá-las apenas la dentro da função.
    var senhaValida:Bool!
    var emailValida:Bool!
    
    var auth: AuthenticationServiceCadastro!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = AuthenticationServiceCadastro(delegate: self)
    }
    
    
    @IBAction func bntCadastrar(_ sender: Any) {
        
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
           let confirmaSenhaLocal = self.confirmacaoSenhaTxt.text {
            
            //Fazendo as validacoes...
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
            }else{
                self.auth.cadastro(nome: localNome, foto: "padrao", email: localEmail, senha: localSenha)
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
    
    func success(type: ResponsetYPE) {
        avisoCadastroSucesso.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))
        self.present(avisoCadastroSucesso,animated: true)
        
        //FIXME: O serviço de cadastro já retorna um usuario com troken valido. Então, você pode trocar para a tela de contatos logo após o sucesso do request de cadastrar.
    }
    
    func failure(type: ResponsetYPE, error: String) {
        
        print(error)
        avisoValidacaoSenha.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
        self.present(avisoValidacaoSenha,animated: true)
            
    }
        

    }
