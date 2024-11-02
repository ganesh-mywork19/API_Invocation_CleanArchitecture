//
//  ListViewViewModel.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation

struct ListViewViewModel {
    private var authors: [AuthorModel]? = nil
    init(authors: [AuthorModel]? = nil) {
        self.authors = authors
    }
    var count: Int {
        return authors?.count ?? 0
    }
    func model(at index: Int) -> AuthorModel? {
        guard let model = authors?[safe: index] else{
            return nil
        }
        return model
    }
}
