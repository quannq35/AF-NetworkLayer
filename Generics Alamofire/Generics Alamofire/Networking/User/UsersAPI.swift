//
//  UsersAPI.swift
//  Generics Alamofire
//
//  Created by Macmini on 11/08/2023.
//

import Foundation
class UserAPI: BaseAPI<UsersNetworking> {
    static let shared = UserAPI()
    
    func getUsers(completetion: @escaping (Result<BaseResponse<[UserModel]>?, NSError>) -> ()) {
        self.fetchData(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { result in
            completetion(result)
        }
    }
    
    func createUser(name: String, job: String, completetion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.fetchData(target: .createUser(name: name, job: job), responseClass: BaseResponse<UserModel>.self) { result in
            completetion(result)
        }
    }
    
    func getUserInfo(id: String, completion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.fetchData(target: .getUserInfo(id: id), responseClass: BaseResponse<UserModel>.self) { result in
            completion(result)
        }
    }
    
    func deleteUser(id: Int, completion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.fetchData(target: .deleteUser(id: id), responseClass: BaseResponse<UserModel>.self) { result in
            completion(result)
        }
    }
    
    func updateUser(id: Int, name: String, job: String, completion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.fetchData(target: .updateUser(id: id, name: name, job: job), responseClass: BaseResponse<UserModel>.self) { result in
            completion(result)
        }
    }
}
