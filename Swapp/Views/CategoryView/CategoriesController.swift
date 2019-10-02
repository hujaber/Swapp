//
//  CategoriesController.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesController: UIViewController {
    
    let didSelectCategory = PublishSubject<Category>()
    
    private let tableView =  UITableView(frame: .zero, style: .plain)
    private var collectionView: UICollectionView!
    private let collectionViewTitleLabel = UILabel()
    
    private let viewModel = CategoriesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defer {
            bind()
            viewModel.fetchCategories()
        }
        navigationItem.title = "Categories"
        setupTableView()
        viewModel.fetchCategories()
        setupNavigationBar()
        setupTitleLabel()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        let vi = UIView(frame: .init(x: 0, y: 0, width: 300, height: 50))
        vi.backgroundColor = .black
        //    navigationController?.navigationBar.addSubview(vi)
        //  navigationItem.titleView = vi
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = .init()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupTitleLabel() {
        collectionViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTitleLabel.textColor = .appThemeColor
        collectionViewTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        collectionViewTitleLabel.numberOfLines = 1
        collectionViewTitleLabel.text = "Featured Stores"
        view.addSubview(collectionViewTitleLabel)
        
        NSLayoutConstraint.activate([
            collectionViewTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            collectionViewTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionViewTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
//        collectionViewFlowLayout.itemSize = .init(width: 110, height: 110)
        collectionViewFlowLayout.estimatedItemSize = .init(width: 140, height: 120)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FeaturedStoreCell.self,
                                forCellWithReuseIdentifier: FeaturedStoreCell.identifier)
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewTitleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func bind() {
        viewModel
            .fetchedCategories
            .map({ $0.count == 0})
            .bind(to: rx.isLoading)
            .disposed(by: disposeBag)
        
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
        
        viewModel
            .featuredStores
            .bind(to: collectionView
                .rx
                .items(cellIdentifier: FeaturedStoreCell.identifier,
                       cellType: FeaturedStoreCell.self)) { row, store, cell in
        }
        .disposed(by: disposeBag)
        
    }
}
