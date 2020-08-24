//
//  AppDelegate.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import RealmSwift


//TODO: Depois vou ensinar a utilizar NavigationController. utiliza esse recurso pode ajudar bastante.
//TODO: Depois que resolver todos os FIXME's me chamar para consertarmos as constraints das telas.

//Sugestões:
//FIXME: Sugestão de funcionalidade: Tentar separar contatos em uma matriz por Letra inicial e na tableView separa-los em sections.
//FIXME: Revisar as telas, tentar manter padrão em tamanho e cores de botões.

var uiRealm: Realm!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try? uiRealm = Realm()
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.path {
            
            print("\nDOCUMENTS >> \(url)")
        }
        
        SessionControll.shared.setupHeaders()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}


//FIXME: Buscar manter o padrão: <Nome>ViewController. Ex: LoginViewController.
// - OBS:
// - Fazer isso com as Controllers (
//    - ViewControllerCadastro
//    - ViewControllerContato
//    - ViewControllerCadastroContato
//    - ViewControllerAtualizar
//)
// - Como renomear uma classe ou variavel?
// 1. Segure o botão "command".
// 2. Clique no nome da classe ou variavel.
// 3. Selecione a opção "Rename".
// 4. Escreva o novo nome da classe ou variável.
// 5. Clique na opção "Rename".
//Feito...
