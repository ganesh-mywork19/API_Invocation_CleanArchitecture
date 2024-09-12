//
//  AuthorListServiceWorker.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//


import Foundation

final class AuthorListServiceWorker: AuthorListServiceWorkerProtocol{
    
    private(set) var serviceManager: APIServiceManagerProtocol?
    required init(serviceManager: APIServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }

    func fetchAuthors(requestModel: APIRequestProtocol,
                      completetion: @escaping (Result<AuthorsResponseModel, APIServiceError>) -> Void) {
        serviceManager?.fetchData(requestModel: requestModel,
                                  expectingType: AuthorsResponseModel.self) { result in
            DispatchQueue.main.async {
                completetion(result)
            }
        }
    }
    
//    func fetchAuthors(requestModel: APIRequestProtocol) async throws -> (Result<AuthorsResponseModel, Error>) {
//        let result = try await serviceManager?.fetchData(requestModel: requestModel,
//                                 expectingType: AuthorsResponseModel.self)
//        return result
//    }
    
    deinit {
        print("deinit called >>>> AuthorListServiceWorker")
    }
}
