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
    
    func fetchAuthors(completion: (() -> Void)?) {
        guard let request = authorsRequestModel else{
            assertionFailure("Unable to prepare AuthorsRequestModel")
            return
        }
        //        Task{
        //             do{
        //                 let result = try await serviceWorker!.fetchAuthors(requestModel: request)
        //             }catch{
        //                  print(error)
        //             }
        //        }
        self.presenter?.showLoader()
        serviceWorker?.fetchAuthors(requestModel: request) {[weak self] result in
            guard let self else { return }
            self.presenter?.hideLoader()
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.presenter?.authorsResponse(model: model)
                }
            case .failure(let error):
                print(error)
                switch error {
                case .ErrorMessage(let msg):
                    DispatchQueue.main.async {
                        self.presenter?.showInfo(msg)
                    }
                case .Error(let err):
                    DispatchQueue.main.async {
                        self.presenter?.showError(err.localizedDescription)
                    }
                }
            }
            completion?()
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
