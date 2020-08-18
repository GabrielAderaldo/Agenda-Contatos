//
//  UsuarioViewModel.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation


struct UsuarioView{
    
    var id: String = " "
    var name: String = " "
    var photo: String = " "
    var email: String = " "
    var token: String = " "

    var photoUrl: URL? {
        return URL(string: self.photo)
    }
}

//FIXME: Evitar muitos espaços dentro das funções ou entre elas.

class UsuarioViewModel {
    
    static func save(_ usuario: Usuario){
        
        self.removeUser()
        
        try? uiRealm.write {
            uiRealm.add(usuario,update: .modified)
        }
    }
    
    
    
    static func removeUser(){
        
        let objects = uiRealm.objects(Usuario.self)
        
        try? uiRealm.write {
            uiRealm.delete(objects)
        }
    }
    
    
    static func getAsView(_ usuario: Usuario?) -> UsuarioView{
        
        guard let usuario = usuario else{ return UsuarioView() }
        
        var usuarioView = UsuarioView()
        
        
        usuarioView.id = usuario.id ?? ""
        usuarioView.name = usuario.name ?? ""
        usuarioView.photo = usuario.photo ?? ""
        usuarioView.email = usuario.email ?? ""
        usuarioView.token = usuario.token ?? ""
        
        
        return usuarioView

    }
    
    
    static func getAsView(sequence: [Usuario]) ->[UsuarioView] {
        var usuarios: [UsuarioView] = []
        
        sequence.forEach{
            (usuario) in usuarios.append(self.getAsView(usuario))
        }
        return usuarios
    }
    
    static func get() -> [Usuario]{
        
        let results = uiRealm.objects(Usuario.self)
        
        var usuarios: [Usuario] = []
        
        usuarios.append(contentsOf: results)
        return usuarios
        
    }
    
    static func getView() -> [UsuarioView] {
        
        return self.getAsView(sequence: self.get())
    }
    
    //Mexido
    static func getUsuario() -> Usuario? {
        return uiRealm.objects(Usuario.self).first
    }
    
    //Mexido...
    static func getUsuarioView() -> UsuarioView {
        
        return self.getAsView(self.getUsuario())
    }
    
    static func removeAll() {
        
        try? uiRealm.write {
            uiRealm.deleteAll()
        }
    }
    
//Fim da classe...
}


