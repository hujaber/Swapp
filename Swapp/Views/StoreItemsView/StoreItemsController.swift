//
//  StoreItemsController.swift
//  Swapp
//
//  Created by Hussein Jaber on 25/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class StoreItemsController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    struct TableSection: SectionModelType {
        typealias Item = CartItem
        var header: String
        var items: [Item]
        
        init(original: Self, items: [Self.Item]) {
            self = original
            self.items = items
        }
        
        init(header: String, items: [Self.Item]) {
            self.header = header
            self.items = items
        }
    }

    @IBOutlet private weak var tableView: UITableView!
    let viewModel = StoreItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = .init()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<TableSection> (configureCell:{ (datasource, tableview, indexpath, item) -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.text = item.description
            return cell
        })
        dataSource.titleForHeaderInSection = {
            $0.sectionModels[$1].header
        }
        
        viewModel
            .fetchedItems
            .map({ (categories) -> [TableSection] in
                var sections: [TableSection] = []
                categories.forEach({
                    sections.append(TableSection(header: $0.name, items: $0.items))
                })
                return sections
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }

}
