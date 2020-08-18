//
//  ViewControllerAtualizar.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 13/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

//FIXME: Voltar a utilizar essa tela.
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
    var contact: ContatoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = ContatoService(delegate: self)
        
    }
    

    
    
    
    
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    
    
    
    
    
    @IBAction func bntAtualizar(_ sender: Any) {
      
       if let localNome = self.idNome.text, let localEmail = self.idEmail.text, let localTelefone = self.idTelefone.text,let localFoto = self.idFoto.text, let localId = contact?.id{
                  self.auth.atualizarContato(nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone, id:localId)
        }
        self.dismiss(animated: true)
        
    }
    
    
    
    
    
    func success(type: ResponseType) {
        telaSucesso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(telaSucesso, animated: true)
       
        
    }
    
    func failure(type: ResponseType, error: String) {
        telaFracasso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    }
    
    
    
   //final da classe...
    
}
