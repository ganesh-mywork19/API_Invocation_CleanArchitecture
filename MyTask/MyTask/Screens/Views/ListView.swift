//
//  ListView.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation
import UIKit

class ListView: UIView {
    
    fileprivate var viewModel: ListViewViewModel!
    fileprivate var _tableView: UITableView!
    static var cellIdentifier = "CellIdentifier"
    init(viewModel: ListViewViewModel){
        super.init(frame: CGRect.zero)
        self.viewModel = viewModel
        createViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        createTableView()
        //create more views
    }
    
    func update(viewModel: ListViewViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self._tableView?.reloadData()
        }
    }
    
    private func createTableView() {
        _tableView?.removeFromSuperview()
        _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.backgroundColor = .clear
        _tableView.separatorStyle = .singleLine
        _tableView.alwaysBounceVertical = false
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: ListView.cellIdentifier) //Not going to create any custom cell at this time.
        addSubview(_tableView)
        NSLayoutConstraint.activate([
            _tableView.topAnchor.constraint(equalTo: self.topAnchor),
            _tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            _tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            _tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListView.cellIdentifier, for: indexPath)
        if let model = viewModel?.model(at: indexPath.row){
            cell.textLabel?.text = model.name
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
}
