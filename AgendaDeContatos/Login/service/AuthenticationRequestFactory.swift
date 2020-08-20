//
//  AuthenticationRequestFactory.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire


class AuthenticationRequestFactory{
    
    static func login(email: String, senha:String) -> DataRequest {
        
        let parameters: Parameters = ["email":email,"password":senha]
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/login",
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default)
    }
    
    
    static func cadastro(nome: String, foto: String, email: String, senha: String) -> DataRequest {
        
        let params:Parameters = ["name": nome,
                                 "photo": foto,
                                 "email": email,
                                 "password": senha]
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/signup",
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default)
    }
    
    static func logout() -> DataRequest {
        return Alamofire.request("http://contatosapi.herokuapp.com/api/logout",
                                 method: .delete,
                                 encoding: JSONEncoding.default,
                                 headers: SessionControll.shared.headers)
    }
}
