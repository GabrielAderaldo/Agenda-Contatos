//
//  ViewControllerAtualizar.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 13/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class ViewControllerAtualizar: UIViewController,ServiceDelegate {
    
    

    @IBOutlet weak var idTxt: UITextField!
    
    @IBOutlet weak var idNome: UITextField!
    
    @IBOutlet weak var idEmail: UITextField!
    
    @IBOutlet weak var idTelefone: UITextField!
    
    @IBOutlet weak var idFoto: UITextField!
    
    
    @IBOutlet weak var imgHeader: UIImageView!
    
    let telaAvisoConfirmacao = UIAlertController(title: "Aviso", message: "Tem certeza que deseja deletar o contato?", preferredStyle: .alert)
    let telaSucesso = UIAlertController(title: "SUCESSO!", message: "Seus dados foram atualizados com sucesso!", preferredStyle: .alert)
    let telaFracasso = UIAlertController(title: "Fracasso", message: "Falha, tente novamente", preferredStyle: .alert)
    
    var auth: ContatoService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
        
    }
    

    
    
    
    
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    
    }
    
    

    
    
    
    
    
    
    @IBAction func bntAtualizar(_ sender: Any) {
        
        if let localIdtxt = self.idTxt.text, let localNome = self.idNome.text, let localEmail = self.idEmail.text, let localTelefone = self.idTelefone.text, let localFoto = self.idFoto.text{
            self.auth.atualizarContato(nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone, id: localIdtxt)
        }
        
        
    }
    
    
    @IBAction func bntDeletar(_ sender: Any) {
        
        if let localid = self.idTxt.text{
            self.auth.deletarContato(id: localid)
        }
        
    }
    
    
    
    func success(type: ResponsetYPE) {
        telaSucesso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(telaSucesso, animated: true)
    }
    
    func failure(type: ResponsetYPE, error: String) {
        telaFracasso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    }
    
    
    
   //final da classe...
    
}
