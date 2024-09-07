//
//  AuthorListDBWorker.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

final class AuthorListDBWorker: AuthorListDBWorkerProtocol {
    
    private(set) var inputModel: AuthorListInputModelProtocol?
    required init(model: AuthorListInputModelProtocol) {
        self.inputModel = model
    }
    
    deinit {
        print("deinit called >>>> AuthorListDBWorker")
    }
}
