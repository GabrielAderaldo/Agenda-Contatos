//
//  UserHeaderView.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 26/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Reusable

class UserHeaderView: UIView, NibOwnerLoadable {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = 75
        self.userImage.clipsToBounds = true
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        self.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(user: UsuarioView) {
        self.userImage.kf.setImage(with: user.photoUrl)
        self.userNameLabel.text = user.name.capitalized
    }
}
