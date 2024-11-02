//
//  AuthorListDisplayProtocol.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

 
protocol ScreenDisplayProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func showMessage(_ text:String)
    func showError(_ text:String)
}

protocol AuthorListDisplayProtocol: ScreenDisplayProtocol{
    func reloadView(with authors: [AuthorModel])
}
