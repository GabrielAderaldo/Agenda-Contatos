//
//  AuthenticationServiceCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class SessionControllCadastro{
    
    static var shared = SessionControllCadastro()
    
    
    var headers: HTTPHeaders = ["token":""]
    
    var usuario: UsuarioView{
        return UsuarioViewModel.getUsuarioView()
    }
    
    var estaticoAtivo: Bool{
        return UsuarioViewModel.getUsuario() != nil
    }
    
    
    init() {}
    
    func setupHeaders(){self.headers["token"] = self.usuario.token}
    
    
}



class AuthenticationServiceCadastro{
    
    var cadastroRequest: Request?
    
    var delegate: ServiceDelegate?
    
    
    
    init(delegate:ServiceDelegate) {
        self.delegate = delegate
    }
    
    
    func cadastro(nome:String,foto:String,email:String,senha:String){
        
        
        self.cadastroRequest?.cancel()
        
        self.cadastroRequest = AuthenticationRequestFactoryCadastro.cadastro(nome: nome, foto: foto, email: email, senha: senha).validate().responseObject(completionHandler: { (response: DataResponse<Usuario>) in
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
