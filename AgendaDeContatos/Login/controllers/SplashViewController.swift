//
//  SplashViewController.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 02/09/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imagemLoading: UIImageView!
    
    //criando os atributos base
    let  xPRIMEIRO = 20.0
    let  yPRIMERIO = 44.0
    //
    let  xSEGUNDO = 280.0
    let  ySEGUNDO = 44.0
    //
    let  xTERCEIRO = 280
    let  yTERCEIRO = 150
    //
    let  xQUARTO = 20
    let  yQUARTO = 150
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagemLoading.layer.cornerRadius = 50
        imagemLoading.clipsToBounds = true
        
        anima1()
        
    }
    
    func anima1(){
        UIView.animate(withDuration: 1/2, animations: {
            self.imagemLoading.frame = CGRect(x: self.xPRIMEIRO, y: self.yPRIMERIO, width: 50, height: 50)
        }) { (_) in
            self.anima2()
        }
    }
    func anima2(){
        UIView.animate(withDuration: 1/2, animations: {
            self.imagemLoading.frame = CGRect(x: self.xSEGUNDO, y: self.ySEGUNDO, width: 50, height: 50)
        }) { (_) in
            self.anima3()
        }
    }
    func anima3(){
        UIView.animate(withDuration: 1/2, animations: {
            self.imagemLoading.frame = CGRect(x: self.xTERCEIRO, y: self.yTERCEIRO, width: 50, height: 50)
        }) { (_) in
            self.anima4()
        }
    }
    func anima4(){
        UIView.animate(withDuration: 1/2, animations: {
            self.imagemLoading.frame = CGRect(x: self.xQUARTO, y: self.yQUARTO, width: 50, height: 50)
        }) { (_) in
            self.anima1()
        }
    }
    

    //Fim da classe
}
