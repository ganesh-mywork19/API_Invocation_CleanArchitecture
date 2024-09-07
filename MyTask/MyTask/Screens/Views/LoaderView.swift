//
//  LoaderView.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
import UIKit

final class LoaderView: UIView {
    
    private var loader: UIActivityIndicatorView!
    init(){
        super.init(frame: CGRect.zero)
        createViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews(){
        loader?.removeFromSuperview()
        loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loader)
        loader.startAnimating()
    }
    
    func showLoader(){
        DispatchQueue.main.async {
            self.loader?.alpha = 1
        }
    }
    func hideLoader(){
        DispatchQueue.main.async {
            self.loader?.alpha = 0
        }
    }
}
