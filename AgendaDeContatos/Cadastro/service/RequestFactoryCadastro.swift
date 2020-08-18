//
//  AuthenticationRequestFactoryCadastro.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire


class AuthenticationRequestFactoryCadastro{
    static func cadastro(nome:String,foto:String,email:String,senha:String) -> DataRequest{
        
        let params:Parameters = ["name":nome,"photo":foto,"email":email,"password":senha];
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/signup",
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default)
    }
    //fim da classe...
}
