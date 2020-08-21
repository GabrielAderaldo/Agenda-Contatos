//
//  AppDelegate.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import RealmSwift

//FIXME: Sugestões gerais para todo o projeto
// 1. Tentar evitar excesso de espaços vazios entre linhas de codigo. No maximo 1 linha de espaço vazio.
// 2. Remover prints após terminar de desenvolver a funcionalidade funcionalidade.
// 3. Não é necessário criar uma storyboard para cada tela. Basta uma para cada funcionalidade. (Ex: 1 storyboard para autenticacao (Login, Cadastro)/ 1 storyboard para os contatos (Create, Read, Detail, Updade, Delete))
// 4. Da uma olhada em como arredonadar uma imagem também.
// 5. Depois vou ensinar a utilizar NavigationController. utiliza esse recurso pode ajudar bastante.
// 6. Depois vou ensinar constraints também. Percebi que esqueci de colocar constraints na trilha de estudos.
// 7. Sugestão de funcionalidade: Tentar separar contatos em uma matriz por Letra inicial e na tableView separa-los em sections.

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
