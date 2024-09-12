//
//  APIRequestProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

enum HttpMethod: String {
    case POST = "POST"
    case GET = "GET"
}
enum ServiceEndpoint: String {
    case authorsList = "/people/george08/lists.json"
    case test = "/people/mekBot/books/want-to-read.json" //For testing only. Actually this should be a light weight API from  server
    case none
}

protocol APIRequestProtocol {
    var requestId: String { get } //will be used to track the request and response from server (if your server is capable)
    var httpMethod: HttpMethod { get }
    var endpoint: ServiceEndpoint { get }
    var apiURL: URL? { get } //final server URL
    var baseUrlString: String { get }
    var timeoutInterval: TimeInterval { get }
    var additionalHeaderFields: [String: String]? { get }
    var body: Data? { get }
}

extension APIRequestProtocol {
    var httpMethod: HttpMethod {
        return .POST //Setting the default value
    }
    var apiURL: URL? {
        let baseUrl = baseUrlString + endpoint.rawValue
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        return url
    }
    var baseUrlString: String {
        return "http://openlibrary.org"
    }
    var timeoutInterval: TimeInterval {
        return 30 //Setting the default value
    }
    var body: Data? {
        return nil
    }
    var additionalHeaderFields: [String: String]? {
        return nil
    }
}
