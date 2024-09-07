//
//  AuthorListServiceWorkerProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//


import Foundation

protocol AuthorListServiceWorkerProtocol {
    
    var serviceManager: APIServiceManagerProtocol?{get}
    init(serviceManager: APIServiceManagerProtocol)
    func fetchAuthors(requestModel: APIRequestProtocol,
                      completetion: @escaping (Result<AuthorsResponseModel, APIServiceError>) -> Void)
}
