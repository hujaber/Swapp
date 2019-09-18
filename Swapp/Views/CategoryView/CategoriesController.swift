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
    }
}
