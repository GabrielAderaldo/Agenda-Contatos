//
//  AuthenticationRequestFactoryContatos.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire

class AuthenticationRequestFactoryContatos{
    static func cadastro(contato: Contato) -> DataRequest{
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/contacts",
                                 method: .post,
                                 parameters: contato.toJSON(),
                                 encoding: JSONEncoding.default,
                                 headers: SessionControll.shared.headers)
    }
    
    static func listar() -> DataRequest{
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/contacts",
                                 method: .get,
                                 encoding: JSONEncoding.default,
                                 headers:SessionControll.shared.headers)
    }
    
    static func buscarId(id:String) -> DataRequest{
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/contacts/\(id)",
                                 method: .get,
                                 encoding: JSONEncoding.default,
                                 headers: SessionControll.shared.headers)
    }
    
    static func atualizar(contato: Contato) -> DataRequest{
        
      //  let parameters: Parameters = ["name":nome,"photo":foto,"email":email,"phone":fone];
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/contacts/\(contato.id ?? "")",
                                 method: .put,
                                 parameters: contato.toJSON(),
                                 encoding: JSONEncoding.default,headers:SessionControll.shared.headers)
    }
    
    static func delete(id:String) -> DataRequest{
        
        return Alamofire.request("http://contatosapi.herokuapp.com/api/contacts/\(id)",
                                 method: .delete,
                                 encoding: JSONEncoding.default,
                                 headers:SessionControll.shared.headers)
        
    }
}
