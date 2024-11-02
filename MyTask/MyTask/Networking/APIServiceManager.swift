//
//  APIServiceManager.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

enum APIServiceError: Error {
    case ErrorMessage(String)
    case Error(Error)
    //add your own error types
}

final class APIServiceManager: APIServiceManagerProtocol {
    
    private(set) var urlSession: URLSession? //Sometimes we need to set URLSessionConfiguration based on API need. So passing entire URLSession from outside.
    init(urlSession: URLSession = URLSession.shared){
        self.urlSession = urlSession
    }
    
    //expectingType can be sometimes direct array too. So passing the required type from outside
    func fetchData<T: Codable>(requestModel: APIRequestProtocol,
                               expectingType: T.Type) async throws -> T {
        guard let request = prepare(requestModel: requestModel) else {
            throw APIServiceError.ErrorMessage("You passed Invalid Url")
        }
        //check for internet status and proceed
        if NetworkMonitor.shared.status == .disconnected {
            throw APIServiceError.ErrorMessage("No Internet connection")
        }
        let (data, response) = try await urlSession!.data(for: request)
        guard (response.statusCode() == 200) else {
            throw APIServiceError.ErrorMessage("No data received")
        }
        do {
            let result = try JSONDecoder().decode(expectingType, from: data)
            print("result = \(result)")
            return result
        }catch {
            throw APIServiceError.Error(error)
        }
    }
    
    private func prepare(requestModel: APIRequestProtocol) -> URLRequest? {
        guard let apiURL = requestModel.apiURL else {
            assertionFailure("No apiURL found")
            return nil
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = requestModel.httpMethod.rawValue
        request.timeoutInterval = requestModel.timeoutInterval

        //set common header fields
        request.addValue("application/json", forHTTPHeaderField:"Accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        if let body = requestModel.body {
            request.httpBody = body //It will be used for POST
        }
        if let additionalHeaderFields = requestModel.additionalHeaderFields {
            for (key, value) in additionalHeaderFields {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    deinit {
        urlSession = nil
        print("deinit called >>>> APIServiceManager")
    }
}
