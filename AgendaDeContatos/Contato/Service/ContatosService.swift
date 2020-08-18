//
//  AuthenticationServiceCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class SessionControllContato{
    
    static var shared = SessionControllContato()
    
    var headers: HTTPHeaders = ["token":""]
    
    var contato: ContatoView{
        return ContatoViewModel.getContatoView()
    }
    
    
    var estaticoAtivo: Bool{
        return ContatoViewModel.getContato() != nil
    }
    
    
    init() {}
    
    
    
    
    func setupHeaders(){self.headers["token"] = self.contato.token}
    
    func setupHeadersInvalid(){self.headers["token"] = ""}
    
}



class ContatoService {
    
    var contatoRequest: Request?
    
    var delegate: ServiceDelegate?
    
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    
    //funcao de cadastro...
    func cadastroContato(nome:String,foto:String,email:String,fone:String){
        
        self.contatoRequest?.cancel()
        
        self.contatoRequest = AuthenticationRequestFactoryContatos.cadastro(nome: nome, foto: foto, email: email, fone: fone).validate().responseObject(completionHandler: { (response: DataResponse<Contato>) in
            
            print("A conecxao foi um sucesso! :) ")
            
            switch response.result {
             
            case .success:
                if let contato = response.value{
                    ContatoViewModel.save(contato)
                    
                    SessionControllContato.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .cadastroContato)
                
            case.failure(let error):
                self.delegate?.failure(type: .cadastroContato, error: error.localizedDescription)
                
                //final do case
            }
        })
}
  
    //criando a funcao listar...
      func listarContato(){
          
          self.contatoRequest?.cancel()
                 
                 self.contatoRequest = AuthenticationRequestFactoryContatos.listar().validate().responseArray(completionHandler: { (response: DataResponse<[Contato]>) in
                     
                     print("A conecxao foi um sucesso! :) ")
                     
                     switch response.result {
                      
                     case .success:
                         
                        if let contato = response.value{
                            
                             ContatoViewModel.save(contato)
                         }
                         
                         self.delegate?.success(type: .listagemContato)
                         
                     case.failure(let error):
                         self.delegate?.failure(type: .listagemContato, error: error.localizedDescription)
                         
                         //final do case
                     }
                 })
          
          
          //final da funcao
      }
    
    
    //criando a funcao atualizar...
    func atualizarContato(nome:String,foto:String,email:String,fone:String,id:String){
            
            self.contatoRequest?.cancel()
            
        self.contatoRequest = AuthenticationRequestFactoryContatos.atualizar(nome: nome, foto: foto, email: email, fone: fone, id:id).validate().responseObject(completionHandler: { (response: DataResponse<Contato>) in
                
                print("A conecxao foi um sucesso! :) ")
                
                switch response.result {
                 
                case .success:
                    if let contato = response.value{
                        ContatoViewModel.save(contato)
                        
                        SessionControllContato.shared.setupHeaders()
                    }
                    
                    self.delegate?.success(type: .atualizarContato)
                    
                case.failure(let error):
                    self.delegate?.failure(type: .atualizarContato, error: error.localizedDescription)
                    
                    //final do case
                }
            })
        //final da funcao
    }
    
    
    
    
    
    func deletarContato(id:String){
        self.contatoRequest?.cancel()
        
        
        
        self.contatoRequest =
            AuthenticationRequestFactoryContatos.delete(id: id).validate().responseObject(completionHandler: { (response: DataResponse<Contato>) in
                
                print("A conecxao foi um sucesso! :) ")
                
                switch response.result {
                 
                case .success:
                    if let contato = response.value{
                        ContatoViewModel.save(contato)
                        
                        SessionControllContato.shared.setupHeaders()
                    }
                    
                    self.delegate?.success(type: .deleteContato)
                    
                case.failure(let error):
                    self.delegate?.failure(type: .deleteContato, error: error.localizedDescription)
                    
                    //final do case
                }
            })
    }


    func logout(){
        self.contatoRequest?.cancel()
        
        self.contatoRequest = AuthenticationRequestFactoryContatos.logout().validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
            print("A coneccao do logout deu bom")
            
            switch response.result{
            case .success:
                if let _ = response.value {
                    UsuarioViewModel.removeAll()
                    SessionControllContato.shared.setupHeadersInvalid()
                }
                self.delegate?.success(type: .logout)
                
            case .failure(let error):
                self.delegate?.failure(type: .logout, error: error.localizedDescription)
            }
        })
        
    }
        //Final da classe

    }



