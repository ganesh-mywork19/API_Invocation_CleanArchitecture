//
//  AuthorListViewController.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
import UIKit

final class AuthorListViewController: UIViewController {
    
    private(set) var interactor: AuthorListInteractorProtocol?
    private(set) var router: AuthorListRouterProtocol?
    private var loaderView: LoaderView!
    private var listView: ListView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setInteractor(_ interactor: AuthorListInteractorProtocol) -> Self {
        self.interactor = interactor
        return self
    }
    func setRouter(_ router: AuthorListRouterProtocol) -> Self {
        self.router = router
        return self
    }

    private func createViews() {
        createListView()
        createLoaderView()
    }
    
    private func createListView() {
        listView?.removeFromSuperview()
        listView = ListView(viewModel: ListViewViewModel())
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLoaderView() {
        loaderView?.removeFromSuperview()
        loaderView = LoaderView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        loaderView.hideLoader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.defaultNavigationBar()
        navigationItem.title = "Authors List"

        createViews()
        interactor?.fetchAuthors()
    }
}

extension AuthorListViewController: AuthorListDisplayProtocol {
    func showLoader() {
        loaderView?.showLoader()
    }
    
    func hideLoader() {
        loaderView?.hideLoader()
    }
    
    func showMessage(_ text: String) {
        //show any alert message
    }
    
    func showError(_ text: String) {
        //show any error banner
    }
    
    func reloadView(with authors: [AuthorModel]) {
        listView?.update(viewModel: ListViewViewModel(authors: authors))
    }
}
