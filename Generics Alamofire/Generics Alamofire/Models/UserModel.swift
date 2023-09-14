//
//  UserModel.swift
//  Generics Alamofire
//
//  Created by Macmini on 15/08/2023.
//

import Foundation

class UserModel: Codable {
    var id: Int?
    var name: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
    }
}
