//
//  SessionControll.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 18/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SessionControll {
    
    static var shared = SessionControll()
    
    var headers: HTTPHeaders = ["token":""]
    
    var usuario: UsuarioView {
        return UsuarioViewModel.getUsuarioView()
    }
    
    var usuarioModel: Usuario? {
        return UsuarioViewModel.getUsuario()
    }
    
    var estaAtivo: Bool {
        return usuarioModel != nil
    }
    
    init(){}
    
    func setupInvalidheader() {
        self.headers["token"] = "hghdhjdhjgdjghs"
    }
    
    func setupHeaders() {
        if let token = self.usuarioModel?.token {
            self.headers["token"] = token
        }
    }
}
