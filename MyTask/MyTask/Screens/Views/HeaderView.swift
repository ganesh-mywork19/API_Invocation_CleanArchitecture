//
//  HeaderView.swift
//  MyTask
//
//  Created by Ganesh Guturi on 12/09/24.
//

import Foundation
import UIKit

//TODO: Should be customized more
extension UINavigationController {
    func defaultNavigationBar() {
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(red: 0, green: 99/255, blue: 41/255, alpha: 1.0)
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
