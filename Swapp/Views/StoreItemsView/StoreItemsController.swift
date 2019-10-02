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
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(StoreItemCell.self, forCellReuseIdentifier: StoreItemCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 10, left: 0, bottom: 5, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func bindViewModel() {
        
//        let dataSource = RxTableViewSectionedReloadDataSource<TableSection> (configureCell:{ (datasource, tableview, indexpath, item) -> UITableViewCell in
//            let cell = UITableViewCell()
//            cell.textLabel?.text = item.name
//            return cell
//        })
//        dataSource.titleForHeaderInSection = {
//            $0.sectionModels[$1].header
//        }
//        
//        viewModel
//            .fetchedItems
//            .map({ (categories) -> [TableSection] in
//                var sections: [TableSection] = []
//                categories.forEach({
//                    sections.append(TableSection(header: $0.name, items: $0.items))
//                })
//                return sections
//            })
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//        .disposed(by: disposeBag)
    }

}

extension StoreItemsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        do { return try viewModel.fetchedItems.value().count }
        catch { return 0 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            let category = try viewModel.fetchedItems.value()[section]
            return category.items.count
        } catch { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: StoreItemCell.reuseIdentifier,
                                 for: indexPath) as! StoreItemCell
        cell.setupWithItem(try! viewModel.fetchedItems.value()[indexPath.section].items[indexPath.row] as! StoreItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return try? viewModel.fetchedItems.value()[section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       
    }
    
}
