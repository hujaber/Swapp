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
    let didSelectStore = PublishSubject<Store>()

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
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(StoreCell.self, forCellReuseIdentifier: StoreCell.reuseIdentifier)
        viewModel
            .fetchedStores
            .bind(to: tableView.rx.items(cellIdentifier: StoreCell.reuseIdentifier, cellType: StoreCell.self)) { row, store, cell in
                cell.setupWithStore(store)
        }
        .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Store.self)
            .bind(to: didSelectStore)
            .disposed(by: disposeBag)
    }
}
