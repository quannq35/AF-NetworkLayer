//
//  BaseAPI.swift
//  Generics Alamofire
//
//  Created by Macmini on 11/08/2023.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping(Result<M?, NSError>) -> Void ) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers ).responseJSON {
            response in
            guard let statusCode = response.response?.statusCode else {
                //ADD Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            guard (200 ... 299) ~= statusCode else {
                // Add Custom error base on status code 404/ 401
                // Error parsing for the error message from the BE
                let message = "Error Message Parsed From BE"
                let error = NSError(domain: target.baseURL + target.path, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(error))
                return
            }
            
            guard let jsonResponse = try? response.result.get() else {
                // Add Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: [])  else {
                // Add Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            guard let responseObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                // Add Custom Error
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }

            completion(.success(responseObject))
        }
    }
}

private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
    switch task {
    case .requestPlain:
        return ([:], URLEncoding.default)
    case .requestParameters(parameter: let parameters, encoding: let encoding):
        return (parameters, encoding)
    }
}
