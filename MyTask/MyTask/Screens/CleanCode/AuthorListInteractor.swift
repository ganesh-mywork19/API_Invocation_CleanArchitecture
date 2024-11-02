//
//  AuthorListInteractor.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

final class AuthorListInteractor: AuthorListInteractorProtocol {
    
    var inputModel: AuthorListInputModelProtocol? {
        return dbWorker?.inputModel
    }
    private(set) var dbWorker: AuthorListDBWorkerProtocol?
    private(set) var serviceWorker: AuthorListServiceWorkerProtocol?
    private(set) var presenter: AuthorListPresenterProtocol?
    
    @discardableResult func setDBWorker(dbWorker: AuthorListDBWorkerProtocol) -> Self {
        self.dbWorker = dbWorker
        return self
    }
    
    @discardableResult func setPresenter(presenter: AuthorListPresenterProtocol) -> Self {
        self.presenter = presenter
        return self
    }
    
    @discardableResult func setServiceWorker(serviceWorker: AuthorListServiceWorkerProtocol) -> Self {
        self.serviceWorker = serviceWorker
        return self
    }
    
    func fetchAuthors() {
        guard let request = authorsRequestModel else{
            assertionFailure("Unable to prepare AuthorsRequestModel")
            return
        }
        self.presenter?.showLoader()
        Task { @MainActor in
            do{
                let resModel = try await serviceWorker!.fetchAuthors(requestModel: request)
                self.presenter?.authorsResponse(model: resModel)
                self.presenter?.hideLoader()
            }catch{
                self.presenter?.hideLoader()
                print(error)
                self.presenter?.showError(error.localizedDescription)
            }
        }
    }
    
    deinit {
        print("deinit called >>>> AuthorListInteractor")
    }
}

extension AuthorListInteractor {
    var authorsRequestModel: APIRequestProtocol? {
        let model = AuthorsRequestModel()
        //add if anythings needs to be filled up here
        return model
    }
}
