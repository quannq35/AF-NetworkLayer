//
//  TestModel.swift
//  Generics Alamofire
//
//  Created by Macmini on 17/08/2023.
//

import Foundation
class TestModel: Codable {
    var ida: Int?
    var namea: String?
    var emaila: String?
    
    enum CodingKeys: String, CodingKey {
        case ida
        case namea
        case emaila
    }
}
