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

//FIXME: Criar um arquivo exclusivo para a classe SessionControl na pasta Application.

class SessionControll {
    
    static var shared = SessionControll()
    
    var headers: HTTPHeaders = ["token":""]
    
    var usuario: UsuarioView{
        return UsuarioViewModel.getUsuarioView()
    }
    
    var estaAtivo: Bool {
        return UsuarioViewModel.getUsuario() != nil
    }
    
    init(){}
    
    func setupInvalidheader() {
        self.headers["token"] = "hghdhjdhjgdjghs"
    }
    
    func setupHeaders() {
        self.headers["token"] = self.usuario.token
    }
}


class AuthenticationService {
    
    var loginRequest: Request?
    var contactRequest: Request?
    
    var delegate: ServiceDelegate?
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate
    }
    
    //FIXME: Colocar o codigo "self.loginRequest?.cancel()" em outra linha para manter o codigo mais legivel.
    func login(email:String,senha:String) {self.loginRequest?.cancel()//Resposta caso exista multiplas conecxoes...
        
        self.loginRequest = AuthenticationRequestFactory.login(email: email, senha: senha).validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
            //FIXME: Após terminar de desenvolver a funcionalidade remover a os prints de teste.
            print("A coneccao foi um sucesso") 
            
            switch response.result {
            case .success:
                
                if let usuario = response.value {
                    
                    UsuarioViewModel.save(usuario)
                    
                    SessionControll.shared.setupHeaders()
                }
                //FIXME: O comentário abaixo serve para trocar a tela após o login.
                //Sugestão: Criar uma classe ScreenManager para fazer esses tratamentos de tela.
                //                UIApplication.shared.windows.first?.rootViewController = ViewController()
                
                self.delegate?.success(type: .login)
                
            case . failure:
                
                self.delegate?.failure(type: .login, error: "")
            }
        })
    }
    
    func logout() {
        
        self.contactRequest?.cancel()
        self.contactRequest = AuthenticationRequestFactory.logout().validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
            
            //FIXME: Após terminar de desenvolver a funcionalidade remover a os prints de teste.
            print("Conectado com sucesso! esse é para o logout")
            
            switch response.result{
            case .success:
                
                if let usuario = response.value{
                    
                    UsuarioViewModel.save(usuario)
                    
                    SessionControll.shared.setupHeaders()
                }
                
                self.delegate?.success(type: .logout)
                
            case .failure:
                
                self.delegate?.failure(type: .logout, error: "erro")
            }
        })
        
    }
}



