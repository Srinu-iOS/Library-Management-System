//
//  ApiList.swift
//  LibraryManagementSystem
//
//  Created by Beehub on 08/12/20.
//

import Foundation
import UIKit

enum StatusCode:Int {
    case success = 200
    case successData = 201
    case error = 403
    case notFound = 404
    case badRequest = 400
    case tokenNotFound = 402
    case connectionFailed = 50
    case noInternet = 0
}

enum Endpoint:String {
    case LoginApi = "user/signIn"
    case SignUpApi = "user/signUp"
    case AdmiBookListApi = "getAdminBookList/"
    case SearchBooksApi = "search/books?"
    case AddBookApi = "addBooks"
    case EditBookApi = "editBooks"
    case LendBookApi = "user/lendBooks"
    case ReturnLendBookApi = "user/return/lendBooks"
    case UserLendBookListApi = "user/getLendBookList/"
    
    static var baseURL = "http://192.168.0.3:8080/"
}
