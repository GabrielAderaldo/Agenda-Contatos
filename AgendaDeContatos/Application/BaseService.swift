//
//  BaseService.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 07/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation
protocol ServiceDelegate{
    func success(type: ResponseType)
    func failure(type:ResponseType, error: String)
}


