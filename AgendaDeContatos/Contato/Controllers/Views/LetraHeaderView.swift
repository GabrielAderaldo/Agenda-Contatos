//
//  LetraHeaderView.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 27/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Reusable
class LetraHeaderView: UIView, NibOwnerLoadable {

    @IBOutlet weak var letraLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.loadNibContent()
        self.awakeFromNib()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    func bind(letra: String){
        self.letraLb.text = letra.uppercased()
    }

}
