//
//  Contato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Contato: Object,Mappable{
    
    @objc dynamic var id: String?
    @objc dynamic var nome: String?
    @objc dynamic var foto: String?
    @objc dynamic var email: String?
    @objc dynamic var fone: String?
    
    required convenience init(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        
        self.id     <- map["_id"]
        self.nome   <- map["name"]
        self.foto   <- map["photo"]
        self.email  <- map["email"]
        self.fone   <- map["phone"]
    }
}


