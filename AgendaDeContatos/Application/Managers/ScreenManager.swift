//
//  ScreenManager.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 20/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
import UIKit

class ScreenManager {
    
    static func setupInitialViewController() {
        
        if SessionControll.shared.estaAtivo {
            UIApplication.shared.windows.first?.rootViewController = StoryboardScene.Contato.contatoViewController.instantiate()
        } else {
            UIApplication.shared.windows.first?.rootViewController = StoryboardScene.Login.viewControllerLogin.instantiate()
        }
    }
}
