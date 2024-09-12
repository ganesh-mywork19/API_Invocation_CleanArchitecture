//
//  APIMockSuccessRequest.swift
//  MyTaskTests
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
@testable import MyTask

struct APIMockSuccessRequest: APIRequestProtocol {
    
    var requestId: String
    var endpoint: ServiceEndpoint {
        return .test
    }
    var httpMethod: HttpMethod {
        return .GET
    }
}
