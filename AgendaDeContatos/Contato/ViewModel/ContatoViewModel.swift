//
//  ContatoViewModel.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation

struct ContatoView{
    
    var id: String = " "
    var nome: String = " "
    var foto: String = " "
    var email: String = " "
    var fone: String = " "
    
    var fotoUrl: URL? {
        return URL(string: self.foto)
    }
}

class ContatoViewModel{
    
    static func save(_ contato:Contato){
        
        try? uiRealm.write{
            uiRealm.add(contato,update: .modified)
        }
    }
    
    static func save(_ contatos:[Contato]){
        self.removeContatos()
        
        try? uiRealm.write{
            uiRealm.add(contatos,update: .modified)
        }
    }
    
    static func removeContatos() {
        let objects = uiRealm.objects(Contato.self)
        
        try? uiRealm.write{
            uiRealm.delete(objects)
        }
    }
    
    static func getAsModel(_ contatoView: ContatoView) -> Contato {
        
        let contato = Contato()
        
        contato.id = contatoView.id.isEmpty ? nil : contatoView.id
        contato.nome = contatoView.nome
        contato.foto = contatoView.foto
        contato.email = contatoView.email
        contato.fone = contatoView.fone
        
        return contato
    }
    
    static func getAsView(_ contato:Contato?) -> ContatoView {
        guard let contato = contato else { return ContatoView() }
        
        var contatoView = ContatoView()
        
        contatoView.id = contato.id ?? " "
        contatoView.nome = contato.nome ?? " "
        contatoView.foto = contato.foto ?? " "
        contatoView.email = contato.email ?? " "
        contatoView.fone = contato.fone ?? " "
        
        return contatoView
    }
    
    static func getAsView(sequence: [Contato]) -> [ContatoView] {
        
        var contatos: [ContatoView] = []
        
        sequence.forEach{ (contato) in
            contatos.append(self.getAsView(contato))
        }
        
        return contatos
    }
    
    static func get() -> [Contato] {
        let results = uiRealm.objects(Contato.self)
        
        var contatos: [Contato] = []
        contatos.append(contentsOf: results)
        
        return contatos
    }
    
    static func get(by id: String) -> ContatoView {
        
        let result = uiRealm.object(ofType: Contato.self, forPrimaryKey:id)
        
        return self.getAsView(result)
    }
    
    
    static func getViews() -> [ContatoView] {
        
        return self.getAsView(sequence: self.get())
    }
    
    static func getContato() -> Contato? {
        
        return uiRealm.objects(Contato.self).first
    }
    
    static func getContatoView() -> ContatoView {
        
        return self.getAsView(self.getContato())
    }
    
    
    static func getAsMatrizFilter(by filtro:String) -> [[ContatoView]] {
        //let contatos = self.getViews().sorted(by: { return $0.nome == filtro})
        
        if filtro.isEmpty {
            return self.getAsMatriz()
        }
        
        let contatos = self.getViews().filter { (contato) -> Bool in
            contato.nome.uppercased().contains(filtro.uppercased())
        }
        
        return self.getAsMatriz(array: contatos)
    }
    
    
    static func getAsMatriz(array: [ContatoView]? = nil) -> [[ContatoView]] {
        
        var matriz: [[ContatoView]] = []
        var contatos: [ContatoView] = []
        if array == nil {
            contatos = self.getViews().map({ (contato) -> ContatoView in
                var contact = contato
                contact.nome = contact.nome.uppercased()
                
                return contact
                
            }).sorted(by: { return $0.nome < $1.nome})
        } else {
            contatos = array ?? []
        }
        
        var letra: Character = Character(" ")
        var j = -1
        for i in 0..<contatos.count {
            if letra != contatos[i].nome.first {
                
                j += 1
                matriz.append([])
                
                letra = contatos[i].nome.first ?? Character(" ")
                
                matriz[j].append(contatos[i])
            } else {
                matriz[j].append(contatos[i])
            }
        }
        
        return matriz
    }
}


