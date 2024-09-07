//
//  AuthorsRequestModel.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

struct AuthorsRequestModel: APIRequestProtocol{
    
    var requestId: String
    init() {
        requestId = UUID().uuidString.lowercased()
    }
    var httpMethod: HttpMethod{
        return .GET
    }
    var endpoint: ServiceEndpoint{
        return .authorsList
    }
    
}
