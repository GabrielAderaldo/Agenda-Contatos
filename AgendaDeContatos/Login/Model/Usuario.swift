//
//  Usuario.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class Usuario: Object, Mappable {
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var photo: String?
    @objc dynamic var email: String?
    @objc dynamic var token: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String?{
        return "id"
    }
    
    
    func mapping(map: Map){
        self.id <- map["user._id"]
        self.name <- map["user.name"]
        self.photo <- map["user.photo"]
        self.email <- map["user.email"]
        self.token <- map["token"]
    }
}
