//
//  DetalhesViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 14/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.


import UIKit
import Kingfisher
import MessageUI


class DetalhesViewController: UIViewController, ServiceDelegate, MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var bntTelefone: UIButton!
    @IBOutlet weak var bntDeletar: UIButton!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbTelefone: UILabel!
    @IBOutlet weak var imagemDetalhes: UIImageView!
   
    var authContatos:  ContatoService!
    var contact: ContatoView?

    //criando a funcao do menu bonitinho...
    func setupNavegationItens(){
        let bntAtualizar = UIBarButtonItem(title:"Atualizar", style: .done, target: self, action: #selector(self.bntAtualizar))
        let bntshare = UIBarButtonItem(image: Asset.bntShare.image, style: .plain, target: self, action: #selector(self.bntShare))
        self.navigationItem.rightBarButtonItems = [bntAtualizar,bntshare]
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.authContatos = ContatoService(delegate: self)
        self.setupNavegationItens()
        self.atualizar()
        bntDeletar.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.authContatos.listarAtualizado(id: contact?.id ?? "")
    }
    
    
    
    func atualizar(){
        
        imagemDetalhes.kf.setImage(with: contact?.fotoUrl,placeholder: Asset.placeHolder.image)
        
        imagemDetalhes.layer.cornerRadius = 100
        imagemDetalhes.clipsToBounds = true
        
        lbNome.text = contact?.nome
        lbEmail.text = contact?.email
        lbTelefone.text = contact?.fone
    }

    //Botoes ficam aquii
    @IBAction func bntVoltar(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @objc func bntAtualizar() {
        
        let telaAtualizar = StoryboardScene.Contato.atualizarViewController.instantiate()
        telaAtualizar.contact = contact
       
        self.navigationController?.pushViewController(telaAtualizar, animated: true)
    }
    
    
    
    @IBAction func bntSMSPhone(_ sender: Any) {
    
        let menu = menuTelefoneMensagem { (opcao) in
            
            switch opcao{
            case.sms:
                self.sendNewMensage("")
            case .phone:
                self.phoneCall()
            }
            
            
        }
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func bntDelete(_ sender: Any) {
        
        if let localId = contact?.id {
            self.authContatos.deletarContato(id: localId)
        }
    }
   
    @objc func bntShare(){
        
        let nomeShare = "Nome: \(contact?.nome ?? "")"
        let phoneShare = "Telefone: \(contact?.fone ?? "")"
        let emailShare = "Email: \(contact?.email ?? "")"
        let cabecalhoShare = "Compartilhar contato..."
        
        let linkToShare = [nomeShare,phoneShare,emailShare,cabecalhoShare]

        let activityController = UIActivityViewController(activityItems: linkToShare, applicationActivities: nil)

        self.present(activityController, animated: true, completion: nil)
        
        
    }
    
    
    func success(type: ResponseType) {
        
        switch type {
        case .buscaContato:
            self.contact = ContatoViewModel.get(by: contact?.id ?? "")
            
            self.atualizar()
            
        case .deleteContato:
           
            let telaAvisoSucesso = UIAlertController(title: L10n.Msg.sucesso, message: L10n.Msg.Sucesso.Contato.deletar, preferredStyle: .alert)
            
            telaAvisoSucesso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(telaAvisoSucesso, animated: true)
            
            default:
                break
        }
        
        
    }
    
    func failure(type: ResponseType, error: String) {
        switch type{
        case.buscaContato:
             let telaAviso  = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.atualizar, preferredStyle: .alert)
             telaAviso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
             present(telaAviso, animated: true)
        case .deleteContato:
            
            let telaAviso  = UIAlertController(title: L10n.Msg.fracasso, message: L10n.Msg.Fracasso.Contato.deletar, preferredStyle: .alert)
            telaAviso.addAction(UIAlertAction(title: L10n.Msg.ok, style: .default, handler: nil))
            present(telaAviso, animated: true)
            
        default:
            print("Algo deu errado...")
        }
    }
    
    /*O ideal é para ficar em uma extension, mas to com problema em chamar... entao jaja pergunto ao jbson como fazer*/
       enum  MenuActionSheetAluno {
             case sms
             case phone
         }
         
         
         func menuTelefoneMensagem(completion:@escaping(_ opcap: MenuActionSheetAluno)-> Void) -> UIAlertController{
             let menu = UIAlertController(title: "Escolha", message: "Deseja qual?", preferredStyle: .actionSheet)
             let sms = UIAlertAction(title: "Enviar SMS", style: .default) { (action) in
                 completion(.sms)
               
             }
           let phone = UIAlertAction(title: "Ligar", style: .default) { (action) in
               completion(.phone)
           }
             
             menu.addAction(sms)
           menu.addAction(phone)
               
           menu.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
           
             return menu
         }
    
    
    //MARK: Mensagem e Telefone
    @IBAction func sendNewMensage(_ sender:Any){
        let msgController = MFMessageComposeViewController()
        msgController.body = "digite algo aqui"
        msgController.recipients = [contact?.fone ?? ""]
        msgController.messageComposeDelegate = self
        self.present(msgController, animated: true, completion: nil)
    }
        
    
    func phoneCall(){
        let numero = contact?.fone ?? " "
        if let url = URL(string: "tel://\(numero)"), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
}



