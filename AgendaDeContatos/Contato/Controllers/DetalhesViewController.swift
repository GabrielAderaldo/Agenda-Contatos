//
//  DetalhesViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 14/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
 

import UIKit
 import Kingfisher

class DetalhesViewController: UIViewController, ServiceDelegate{
    
    @IBOutlet weak var lbNome: UILabel!
    
    @IBOutlet weak var lbEmail: UILabel!
    
    @IBOutlet weak var lbTelefone: UILabel!
    
    @IBOutlet weak var imagemDetalhes: UIImageView!
    
    @IBOutlet weak var txtNome: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtTelefone: UITextField!
    
    @IBOutlet weak var txtFoto: UITextField!
    
    
    
    var auth:  ContatoService!
    var contact: ContatoView?
    
    
    /*
     criando as telas de aviso...
     */
    
    
    //Tela de confimacao de delete...
    func avisoDeletar(){
       let telaAvisoDelte = UIAlertController(title: "AVISO!", message: "Deseja realmente deletar esse contato?", preferredStyle: .alert)
        telaAvisoDelte.addAction(UIAlertAction(title: "Sim", style: .default))
        telaAvisoDelte.addAction(UIAlertAction(title: "Nao", style: .cancel))
        present(telaAvisoDelte, animated: true, completion: sucessoDelete)
        
    }
    
    
    func sucessoDelete(){
        let telaSucesso = UIAlertController(title: "Sucesso", message: "O usuario foi deltado com sucesso", preferredStyle: .alert)
        telaSucesso.addAction(UIAlertAction(title: "OK", style: .default))
        present(telaSucesso, animated: true)
    }

    
    @IBOutlet weak var tabelaDetalhes: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.auth = ContatoService(delegate: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            
        imagemDetalhes.kf.setImage(with: contact?.fotoUrl)
        
        
        
        
        
        super.viewWillAppear(true)
        self.auth.listarContato()
        
        
        lbNome.text = contact?.nome
        lbEmail.text = contact?.email
        lbTelefone.text = contact?.fone
        
        
        
        
           
    }
    
    
    
    
    
    
    //Botoes ficam aquii
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func bntAtualizar(_ sender: Any) {
        if let localNome = self.txtNome.text, let localEmail = self.txtEmail.text, let localTelefone = self.txtTelefone.text,let localFoto = self.txtFoto.text, let localId = contact?.id{
            self.auth.atualizarContato(nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone, id:localId)
        }
    }
    
    
    
    @IBAction func bntDelete(_ sender: Any) {
      //  avisoDeletar()
        
        if let localId = contact?.id{
            self.auth.deletarContato(id: localId)
        }
        
        
        
       
    }
    
    
    
        
    func success(type: ResponsetYPE) {
       
        switch type {
        case .deleteContato:
            let Tela = StoryboardScene.Detalhes.detalhesViewController.instantiate()
            
               let telaAvisoSucesso = UIAlertController(title: "SUCESSO!", message: "Os dados foram deletados com sucesso!", preferredStyle: .alert)
                    
                    telaAvisoSucesso.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(telaAvisoSucesso, animated: true)
              
            print("Contato deletado com sucesso!")
        case .atualizarContato:
            
            
            
            
            let telaAvisoSucesso = UIAlertController(title: "SUCESSO!", message: "Os dados foram atualizados com sucesso!", preferredStyle: .alert)
            
            telaAvisoSucesso.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(telaAvisoSucesso, animated: true, completion: nil)
                
            
            
            
            
        default:

            print("Algo aconteceu...")
        }
        
        
     }
     
     func failure(type: ResponsetYPE, error: String) {
        switch type{
        case .deleteContato:
            
            let telaAviso  = UIAlertController(title: "FALHA!", message: "Ocorreu uma falha ao deletar o contato... tente novamente mais tarde", preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(telaAviso, animated: true)
            
            print("Ocorreu um erro ao deletar o Contato")
        case .atualizarContato:
            
            let telaAviso  = UIAlertController(title: "FALHA!", message: "Ocorreu uma falha ao Atualizar o contato... tente novamente mais tarde", preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(telaAviso, animated: true)
            
            print("Ocorreu um erro ao atualizar o Contato")
        case .listagemContato:
            
            let telaAviso  = UIAlertController(title: "FALHA!", message: "Ocorreu uma falha ao listar os contato... tente novamente mais tarde", preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(telaAviso, animated: true)
            
            
            print("A listagem falhou...")
        default:
            print("Algo deu errado...")
        }
     }
     


}
