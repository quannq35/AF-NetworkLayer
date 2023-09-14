//
//  TargetType.swift
//  Generics Alamofire
//
//  Created by Macmini on 11/08/2023.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(parameter: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    
    var baseURL: String { get }
    
    var path: String{ get }
    
    var method: HTTPMethod { get }
    
    var task: Task { get }
    
    var headers: [String: String]? { get }
}
