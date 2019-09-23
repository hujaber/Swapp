//
//  StoresController.swift
//  Swapp
//
//  Created by Hussein Jaber on 20/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift

class StoresController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let viewModel = StoresViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel
            .fetchedStores
            .map({ $0.count == 0 })
            .bind(to: rx.isLoading)
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.tableFooterView = .init()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StoreCell.self)
        viewModel
            .fetchedStores
            .bind(to: tableView.rx.items(cellIdentifier: StoreCell.reuseIdentifier, cellType: StoreCell.self)) { row, store, cell in
                cell.textLabel?.text = String(store.categoryId)
        }
        .disposed(by: disposeBag)
    }
}
