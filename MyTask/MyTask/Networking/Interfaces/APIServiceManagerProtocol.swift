//
//  APIServiceManagerProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation

protocol APIServiceManagerProtocol {
    var urlSession: URLSession? { get }
    func fetchData<T: Codable>(requestModel: APIRequestProtocol,
                               expectingType: T.Type,
                               completetion: @escaping (Result<T, APIServiceError>) -> Void)
}
