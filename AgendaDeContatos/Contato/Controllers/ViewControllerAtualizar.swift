//
//  ViewControllerAtualizar.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 13/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class ViewControllerAtualizar: UIViewController,ServiceDelegate {
    
    @IBOutlet weak var idTxt: UITextField! //FIXME: Remover variaveis que nao estao sendo utilizadas.
    
    @IBOutlet weak var idNome: UITextField!
    @IBOutlet weak var idEmail: UITextField!
    @IBOutlet weak var idTelefone: UITextField!
    @IBOutlet weak var idFoto: UITextField!
    @IBOutlet weak var UIVimgHeader: UIImageView! //FIXME: Renomear variaveis, sempre iniciar variaveis e funcoes com letra minuscula.
    
    //FIXME: Esses alertas so são utilizados dentro de suas funcoes entao é melhor sempre cria-los dentro de suas funcoes
    //Dessa forma ele ficara com aquele problema de sempre adicionar um "Ok" a mais no alerta.
    let telaAvisoConfirmacao = UIAlertController(title: "Aviso", message: "Tem certeza que deseja deletar o contato?", preferredStyle: .alert)
    let telaSucesso = UIAlertController(title: "SUCESSO!", message: "Seus dados foram atualizados com sucesso!", preferredStyle: .alert)
    let telaFracasso = UIAlertController(title: "Fracasso", message: "Falha, tente novamente", preferredStyle: .alert)
    
    var auth: ContatoService! //FIXME: Renomear essa variavel auth pois ela é referente ao service de contatos.
    var contact: ContatoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.auth = ContatoService(delegate: self)
        UIVimgHeader.kf.setImage(with: contact.fotoUrl)
        
        
        
        //arrendondando a imagem...
        UIVimgHeader.layer.cornerRadius = 100
        UIVimgHeader.clipsToBounds = true
        
        //Iniciando já os valores anteriores...
        idNome.text = contact?.nome
        idTelefone.text = contact?.fone
        idEmail.text = contact?.email
        
        
    }
    
    @IBAction func bntVoltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bntAtualizar(_ sender: Any) {
        
        if let localNome = self.idNome.text,
           let localEmail = self.idEmail.text,
           let localTelefone = self.idTelefone.text,
           let localFoto = self.idFoto.text {
            
            self.auth.atualizarContato(nome: localNome, foto: localFoto, email: localEmail, fone: localTelefone, id: contact.id)
        }
        self.dismiss(animated: true)
        
    }
    
    func success(type: ResponseType) {
        telaSucesso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(telaSucesso, animated: true)
        
        //FIXME: Fechar tela após atualizar.
    }
    
    func failure(type: ResponseType, error: String) {
        telaFracasso.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    }
}
