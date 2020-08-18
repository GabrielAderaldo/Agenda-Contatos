//
//  AuthenticationRequestFactory.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire

//FIXME: Passar o request de Cadastro para essa classe

class AuthenticationRequestFactory{
    
    static func login(email: String, senha:String) -> DataRequest {
        
        let parameters: Parameters = ["email":email,"password":senha];
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/login",
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default)
    }
    
    //FIXME: O logout está funcionando? Acho que ta faltando os headers.
    static func logout() -> DataRequest {
        return Alamofire.request("http://contatosapi.herokuapp.com/api/logout",
                                 method: .delete,
                                 encoding: JSONEncoding.default)
    }
    
    //fim da classe
}
