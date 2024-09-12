//
//  AuthorListViewController.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
import UIKit

//class HeaderView: UIStackView {
//    
//    private var titleLabel: UILabel!
//
//    deinit {
//        print("deinit called >>>> SCChatContactCustomView")
//    }
//
//    init() {
//        super.init(frame: .zero)
//        createViews()
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func update(title: String) {
//        titleLabel?.text = title
//    }
//    
//    private func createViews() {
//        createTitleLabel()
//    }
//    
//    private func createTitleLabel() {
//        titleLabel?.removeFromSuperview()
//        titleLabel = UILabel()
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.textColor = .white
//        titleLabel.textAlignment = .center
//        addArrangedSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        ])
//    }
//}

final class AuthorListViewController: UIViewController {
    
    private(set) var interactor: AuthorListInteractorProtocol?
    private(set) var router: AuthorListRouterProtocol?
    private var viewModel: ListViewViewModel!
    private var loaderView: LoaderView!
    private var listView: ListView!

    convenience init(with viewModel: ListViewViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
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
        listView = ListView(viewModel: viewModel)
        listView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listView)
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        self.view.backgroundColor = .white
        createViews()
        interactor?.fetchAuthors {}
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
    
    func showInfo(_ text: String?) {
        //show any info banner
    }
    
    func showError(_ text: String) {
        //show any error banner
    }
    
    func reloadView(with authors: [AuthorModel]) {
        viewModel?.update(authors: authors)
        listView?.update(viewModel: viewModel)
    }
}
