//
//  ApiCall.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import Foundation
import Alamofire

typealias dictionaryType = [String:Any]

enum ApiResponse<T> {
    case success(data:T,message:String)
    case failure(code:StatusCode,message:String)
}

protocol NetworkProtocol {
    func connect(completion:@escaping(ApiResponse<AnyObject>)->())
}

enum Network:NetworkProtocol {
    case GET(endPoint:String,Parameter:Parameters)
    case POST(endPoint:String,Parameter:Parameters)
    case PUT(endPoint:String,Parameter:Parameters)
    
    func connect(completion: @escaping (ApiResponse<AnyObject>) -> ()) {
        switch self {
        case .GET(let endPoint,let parameter):
            let url = Endpoint.baseURL + endPoint
            print("********  LINK:",url)
            print("******** PARAMETERS PASSING:",parameter)
            AF.request(url, method:.get, parameters: parameter).responseJSON { (response) in
                switch(response.result) {
                    case .success(_):
                        if let result = response.value {
                            let dict = result as! dictionaryType
                            let apiMessage = dict["message"] as? String ?? ""
                            let statusCode = dict["code"] as? Int ?? 0
                            let status = StatusCode(rawValue: statusCode)!
                            switch status {
                                case .success:
                                    let data = dict["data"] as? NSArray ?? []
                                    completion(.success(data: data, message: apiMessage))
                                case .notFound:
                                    completion(.failure(code: .notFound, message: apiMessage))
                                default:break
                            }
                        }
                    case .failure(_):
                        completion(.failure(code: .connectionFailed, message: "Network Request Failed"))
                }
            }
            
        case .POST(let endPoint,let parameter):
            let url = Endpoint.baseURL + endPoint
            print("********  LINK:",url)
            print("******** PARAMETERS PASSING:",parameter)
            AF.request(url, method:.post, parameters: parameter, encoding:
                JSONEncoding.default).responseJSON { (response) in
                    switch(response.result) {
                    case .success(_):
                        if let result = response.value {
                            let dict = result as! dictionaryType
                            let apiMessage = dict["message"] as? String ?? ""
                            let statusCode = dict["code"] as? Int ?? 0
                            let status = StatusCode(rawValue: statusCode)!
                            switch status {
                            case .success:
                                let data = dict["data"] as AnyObject 
                                completion(.success(data: data, message: apiMessage))
                            case .notFound:
                                completion(.failure(code: .notFound, message: apiMessage))
                            default:break
                            }
                        } else {
                            assertionFailure("failed @ response binding")
                        }
                    case .failure(_):
                        completion(.failure(code: .connectionFailed, message: "Network Request Failed"))
                    }
            }
            
        case .PUT(let endPoint,let parameter):
            let url = Endpoint.baseURL + endPoint
            print("********  LINK:",url)
            print("******** PARAMETERS PASSING:",parameter)
            AF.request(url, method:.put, parameters: parameter, encoding:
                JSONEncoding.default).responseJSON { (response) in
                    switch(response.result) {
                    case .success(_):
                        if let result = response.value {
                            let dict = result as! dictionaryType
                            let apiMessage = dict["message"] as? String ?? ""
                            let statusCode = dict["code"] as? Int ?? 0
                            let status = StatusCode(rawValue: statusCode)!
                            switch status {
                            case .success:
                                let data = dict["data"] as AnyObject
                                completion(.success(data: data, message: apiMessage))
                            case .notFound:
                                completion(.failure(code: .notFound, message: apiMessage))
                            default:break
                            }
                        } else {
                            assertionFailure("failed @ response binding")
                        }
                    case .failure(_):
                        completion(.failure(code: .connectionFailed, message: "Network Request Failed"))
                    }
            }
        }
    }
}
