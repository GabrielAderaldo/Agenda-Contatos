//
//  ContatoTableViewCell.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 26/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Reusable

class ContatoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var contatoNomeLabel: UILabel!
    @IBOutlet weak var contatoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contatoImage.layer.cornerRadius = self.contatoImage.frame.height/2
        self.contatoImage.clipsToBounds = true
    } 
    
    func bind(contato: ContatoView) {
        self.contatoNomeLabel.text = contato.nome.capitalized
        self.contatoImage.kf.setImage(with: contato.fotoUrl, placeholder: Asset.placeHolder.image)
    }
}
