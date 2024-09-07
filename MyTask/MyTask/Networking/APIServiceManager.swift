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
                               expectingType: T.Type,
                               completetion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let request = prepare(requestModel: requestModel) else{
            DispatchQueue.main.async {
                completetion(.failure(.ErrorMessage("You passed Invalid Url")))
            }
            return
        }
        
        //check for internet status and proceed
        if NetworkMonitor.shared.status == .disconnected {
            DispatchQueue.main.async {
                completetion(.failure(.ErrorMessage("No Internet connection")))
            }
            return
        }
        
        urlSession?.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completetion(.failure(.Error(error)))
                }
            }
            guard let data = data, (response?.statusCode() == 200) else {
                DispatchQueue.main.async {
                    completetion(.failure(.ErrorMessage("No data received")))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expectingType, from: data)
                print("result = \(result)")
                DispatchQueue.main.async {
                    completetion(.success(result))
                }
            }
            catch {
                DispatchQueue.main.async {
                    completetion(.failure(.ErrorMessage(error.localizedDescription)))
                }
            }
        }.resume()
    }
    
    //I want let you know that we can achive this using the async and await as well
//    func fetchData<T: Codable>(requestModel: APIRequestProtocol,
//                               expectingType: T.Type) async throws -> (Result<T, Error>) {
//        
//        guard let request = prepare(requestModel: requestModel) else{
//            return .failure(ServiceAPIError.InvalidUrl)
//        }
//        
//        //check for internet status and proceed
//        if NetworkMonitor.shared.status == .disconnected {
//            return .failure(ServiceAPIError.NoInternet)
//        }
//        let (data, response) = try await urlSession!.data(for: request)
//        guard response.statusCode() == 200 else {
//            return .failure(ServiceAPIError.InvalidData)
//        }
//        do {
//            let result = try JSONDecoder().decode(expectingType, from: data)
//            print("result = \(result)")
//            return .success(result)
//        }
//        catch {
//            return  .failure(error)
//        }
//    }
    
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
