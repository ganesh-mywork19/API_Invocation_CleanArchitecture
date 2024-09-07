//
//  APIMockFailureRequest.swift
//  MyTaskTests
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
@testable import MyTask

struct APIMockFailureRequest: APIRequestProtocol {
    
    var requestId: String
    var endpoint: ServiceEndpoint{
        return .none
    }
    var apiURL: URL?{
        return URL(string: "https://www.apple.com") //use any dummy API
    }
}
