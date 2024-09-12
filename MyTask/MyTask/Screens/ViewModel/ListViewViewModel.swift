//
//  ListViewViewModel.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation

struct ListViewViewModel {
    private var authors: [AuthorModel]!
    var count: Int {
        return authors?.count ?? 0
    }
    mutating func update(authors: [AuthorModel]) {
        self.authors = authors
    }
    func model(at index: Int) -> AuthorModel? {
        guard let model = authors[safe: index] else{
            return nil
        }
        return model
    }
    
    //Write listView related logic if you have
}
