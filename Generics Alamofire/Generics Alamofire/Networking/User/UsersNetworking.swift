//
//  UsersNetworking.swift
//  Generics Alamofire
//
//  Created by Macmini on 11/08/2023.
//

import Foundation
import Alamofire

enum UsersNetworking {
    case getUsers
    case createUser(name: String, job: String)
    case getUserInfo(id: String)
    case deleteUser(id: Int)
    case updateUser(id: Int, name: String, job: String)
}

extension UsersNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .deleteUser:
            return "https://jsonplaceholder.typicode.com"
        default:
            return "https://reqres.in/api"
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createUser:
            return "/users"
        case .getUserInfo(let id):
            return "/users/\(id)"
        case .deleteUser(let id):
            return "/posts/\(id)"
        case .updateUser(let id, _, _):
            return "/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .createUser:
            return .post
        case .getUserInfo:
            return .get
        case .deleteUser:
            return .delete
        case .updateUser:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .createUser(let name, let job):
            return .requestParameters(parameter: ["name": name, "job": job], encoding: JSONEncoding.default)
        case .getUserInfo:
            return .requestPlain
        case.deleteUser:
            return .requestPlain
        case .updateUser(_, let name, let job):
            return .requestParameters(parameter: ["name" : name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default :
            return [:]
        }
    }
}
