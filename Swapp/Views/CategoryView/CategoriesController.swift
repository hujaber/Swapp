//
//  CategoriesController.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift

class CategoriesController: UIViewController {
    
    let didSelectCategory = PublishSubject<Category>()

    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = CategoriesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        setupTableView()
        viewModel.fetchCategories()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = .init()
        tableView.register(CategoryCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        viewModel
            .fetchedCategories
            .bind(to: tableView
                .rx
                .items(cellIdentifier: CategoryCell.reuseIdentifier, cellType: CategoryCell.self)) {
                    row, category, cell in
                    cell.setupWithCategory(category)
        }
        .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Category.self)
            .bind { [weak self] category in
                guard let self = self,
                    let indexPath = self.tableView.indexPathForSelectedRow
                    else { return }
                self.didSelectCategory.onNext(category)
                self.tableView.deselectRow(at: indexPath, animated: true)
        }
        .disposed(by: disposeBag)
    }
}
