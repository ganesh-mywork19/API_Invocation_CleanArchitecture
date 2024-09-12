//
//  AuthorListInteractorProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

protocol AuthorListInteractorProtocol {
    var inputModel: AuthorListInputModelProtocol? { get }
    var dbWorker: AuthorListDBWorkerProtocol? { get }
    var serviceWorker:AuthorListServiceWorkerProtocol? { get }
    var presenter:AuthorListPresenterProtocol? { get }
    
    @discardableResult func setDBWorker(dbWorker: AuthorListDBWorkerProtocol) -> Self
    @discardableResult func setPresenter(presenter: AuthorListPresenterProtocol) -> Self
    @discardableResult func setServiceWorker(serviceWorker: AuthorListServiceWorkerProtocol) -> Self
    
    func fetchAuthors(completion: (() -> Void)?)
}
