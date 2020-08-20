//
//  AuthenticationService.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 10/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class AuthenticationService {
    
    var loginRequest: Request?
    var contactRequest: Request?
    
    var delegate: ServiceDelegate?
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    func login(email:String,senha:String) {
        
        self.loginRequest?.cancel()//Resposta caso exista multiplas conecxoes...
        
        self.loginRequest = AuthenticationRequestFactory.login(email: email, senha: senha).validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
            
            switch response.result {
            case .success:
                
                if let usuario = response.value {
                    
                    UsuarioViewModel.save(usuario)

                    SessionControll.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .login)
                
            case . failure:
                
                self.delegate?.failure(type: .login, error: "")
            }
        })
    }
    
    func logout() {
        
        self.contactRequest?.cancel()
        self.contactRequest = AuthenticationRequestFactory.logout().validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
            
            switch response.result{
            case .success:
                
                if let _ = response.value{
                    
                    UsuarioViewModel.removeAll()
                    
                    SessionControll.shared.setupInvalidheader()
                }
                
                self.delegate?.success(type: .logout)
                
            case .failure:
                
                UsuarioViewModel.removeAll()
                
                self.delegate?.failure(type: .logout, error: "erro")
            }
        })
        
    }
    
    func cadastro(nome:String,foto:String,email:String,senha:String){
         
         
         self.loginRequest?.cancel()
         
         self.loginRequest = AuthenticationRequestFactory.cadastro(nome: nome, foto: foto, email: email, senha: senha).validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
             print("A coneccao foi um sucesso")
             
             switch response.result {
             case .success:
                 
                 if let usuario = response.value {
                     
                     UsuarioViewModel.save(usuario)
                     
                     SessionControll.shared.setupHeaders()
                 }
                 
                 self.delegate?.success(type: .cadastro)
                 
             case .failure(let error):
                 
                 self.delegate?.failure(type: .cadastro, error: error.localizedDescription)
             }
         })
         
         
         
     }
    
    
}



