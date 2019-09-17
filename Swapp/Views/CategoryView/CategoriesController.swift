//
//  CategoriesController.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

class CategoriesController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = .init()
    }
}
