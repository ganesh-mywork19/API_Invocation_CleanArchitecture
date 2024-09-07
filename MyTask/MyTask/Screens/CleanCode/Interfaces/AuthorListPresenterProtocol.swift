//
//  AuthorListPresenterProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

protocol AuthorListPresenterProtocol: ScreenDisplayProtocol{
    var viewController: AuthorListDisplayProtocol? {set get}
    init(viewController: AuthorListDisplayProtocol)
    func authorsResponse(model: AuthorsResponseModel)
}
