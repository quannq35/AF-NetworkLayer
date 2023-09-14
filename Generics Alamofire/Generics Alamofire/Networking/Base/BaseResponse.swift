//
//  BaseResponse.swift
//  Generics Alamofire
//
//  Created by Macmini on 15/08/2023.
//

import Foundation
class BaseResponse<T: Codable> : Codable {
    var status: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
