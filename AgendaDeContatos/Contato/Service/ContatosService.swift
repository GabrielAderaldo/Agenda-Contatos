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


class ContatoService {
    
    var contatoRequest: Request?
    
    var delegate: ServiceDelegate?
    
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    //FIMXE: Sugestão para evitar muitos parametros. Me chamar quando for fazer essa parte que eu ensino.
    func cadastroContato(contato: Contato){
        
        self.contatoRequest?.cancel()
        
        self.contatoRequest = AuthenticationRequestFactoryContatos.cadastro(contato: contato).validate().responseObject(completionHandler: { (response: DataResponse<Contato>) in
            
            print("A conecxao foi um sucesso! :) ")
            
            switch response.result {
                
            case .success:
                if let contato = response.value{
                    ContatoViewModel.save(contato)
                    
                    SessionControll.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .cadastroContato)
                
            case.failure(let error):
                self.delegate?.failure(type: .cadastroContato, error: error.localizedDescription)
            }
        })
    }
    
    //FIMXE: Sugestão para evitar muitos parametros. Me chamar quando for fazer essa parte que eu ensino.
    func listarContato() {
        
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
            }
        })
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
                    
                    SessionControll.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .atualizarContato)
                
            case.failure(let error):
                self.delegate?.failure(type: .atualizarContato, error: error.localizedDescription)
            }
        })
    }
    
    func deletarContato(id:String){
        
        self.contatoRequest?.cancel()
        
        self.contatoRequest = AuthenticationRequestFactoryContatos.delete(id: id).validate().responseObject(completionHandler: { (response: DataResponse<Contato>) in
                
            print("A conecxao foi um sucesso! :) ")
            
            switch response.result {
                
            case .success:
                if let contato = response.value{
                    ContatoViewModel.save(contato)
                    
                    SessionControll.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .deleteContato)
                
            case.failure(let error):
                self.delegate?.failure(type: .deleteContato, error: error.localizedDescription)
            }
        })
    }
}



