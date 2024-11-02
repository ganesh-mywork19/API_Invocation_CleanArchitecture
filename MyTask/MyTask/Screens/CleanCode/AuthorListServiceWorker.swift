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

    func fetchAuthors(requestModel: APIRequestProtocol) async throws -> AuthorsResponseModel {
        
        do {
            let responseModel = try await serviceManager!.fetchData(requestModel: requestModel,
                                                          expectingType: AuthorsResponseModel.self)
            return responseModel
        }catch {
            print(error)
            throw error
        }
    }
    
    deinit {
        print("deinit called >>>> AuthorListServiceWorker")
    }
}
