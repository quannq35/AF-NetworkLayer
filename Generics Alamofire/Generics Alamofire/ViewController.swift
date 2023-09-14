//
//  ViewController.swift
//  Generics Alamofire
//
//  Created by Macmini on 11/08/2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callApiGetUserInfo()
    }
    
    func callApigetListUser() {
        UserAPI.shared.getUsers { result in
            switch result {
            case .success(let users):
                if let users = users?.data {
                    print(users.count)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func callApiCreateUser() {
        UserAPI.shared.createUser(name: "Quan", job: "Mobile Developer") {
            result in
            switch result{
            case .success:
                print("Sucess")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callApiGetUserInfo() {
        UserAPI.shared.getUserInfo(id: "1") {result in
            switch result {
            case .success:
                print("Success")
            case . failure(let error):
                print(error)
            }
        }
    }
    
    func callApiDeleteUser() {
        UserAPI.shared.deleteUser(id: 2) {result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callApiUpdateUser() {
        UserAPI.shared.updateUser(id: 2, name: "Quan ne", job: "Developer") { result in
            switch result {
            case .success:
                print("Success")
            case . failure(let error):
                print(error)
            }
        }
    }
    
    func fetchData<T: Decodable>(url: String, reponseClass: T.Type, completion: @escaping (Result<T?, NSError>) -> Void) {
        AF.request(url, method: .get, parameters: [:], headers: [:]).responseData { response in
            guard let statusCode = response.response?.statusCode else{return}
            if statusCode == 200 {
                guard let jsonResponse = try? response.result.get() else {return}
                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {return}
                guard let responseObject = try? JSONDecoder().decode(T.self, from: theJsonData) else {return}
                completion(.success(responseObject))
            }
        }
    }
    
    func fetchUserData(complete: @escaping (Result<[UserModel]?, NSError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users"
        AF.request(url, method: .get, parameters: [:], headers: [:]).responseData { (response) in
            guard let statusCode = response.response?.statusCode else {return}
            if statusCode == 200 {
                guard let jsonResponse = try? response.result.get() else {return}
                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {return}
                guard let responseObject = try? JSONDecoder().decode([UserModel].self, from: theJsonData) else {return}
                complete(.success(responseObject))
            }
        }
    }
}


