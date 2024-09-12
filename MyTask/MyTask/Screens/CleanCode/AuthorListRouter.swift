//
//  AuthorListRouter.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation
import UIKit

final class AuthorListRouter: AuthorListRouterProtocol {
    
    weak var viewController: UIViewController? = nil
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    deinit {
        print("deinit called >>>> AuthorListRouter")
    }
}
