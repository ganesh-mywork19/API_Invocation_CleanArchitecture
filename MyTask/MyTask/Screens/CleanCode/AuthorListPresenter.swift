//
//  AuthorListPresenter.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

final class AuthorListPresenter: AuthorListPresenterProtocol {
    
    weak var viewController: AuthorListDisplayProtocol?
    required init(viewController: AuthorListDisplayProtocol) {
        self.viewController = viewController
    }
    
    func showLoader() {
        viewController?.showLoader()
    }
    func hideLoader() {
        viewController?.hideLoader()
    }
    func showMessage(_ text: String) {
        viewController?.showMessage(text)
    }
    func showError(_ text: String) {
        viewController?.showError(text)
    }
    
    //manipulate the data/response according to your need
    func authorsResponse(model: AuthorsResponseModel) {
        var authors = [AuthorModel]()
        model.entries.forEach { author in
            authors.append(AuthorModel(name: author.name,
                                       url: author.url,
                                       seedCount: author.seedCount)
            )
        }
        viewController?.reloadView(with: authors)
    }
    
    deinit {
        print("deinit called >>>> AuthorListPresenter")
    }
}
