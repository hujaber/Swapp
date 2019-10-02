//
//  StoreCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let storeImageView = UIImageView()
    private let storeDetailsLabel = UILabel()
    private let deliveryTimeLabel = UILabel()
    private let storeExpenseLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defer {
            activateConstraints()
        }
        selectionStyle = .none
        setupStoreImageView()
        setupStoreTitleLabel()
        setupDetailsLabel()
        setupDeliveryTimeLabel()
        setupExpenseLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        storeImageView.layer.cornerRadius = 10
    }
    
    private func setupStoreImageView() {
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
        storeImageView.contentMode = .scaleAspectFill
        storeImageView.clipsToBounds = true
        contentView.addSubview(storeImageView)
    }
    
    private func setupStoreTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .black
        
        contentView.addSubview(titleLabel)
    }
    
    private func setupDetailsLabel() {
        storeDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        storeDetailsLabel.numberOfLines = 1
        storeDetailsLabel.font = .systemFont(ofSize: 12, weight: .regular)
        storeDetailsLabel.textColor = .init(white: 175.0/255.0, alpha: 1.0)
        
        contentView.addSubview(storeDetailsLabel)
    }
    
    private func setupDeliveryTimeLabel() {
        deliveryTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryTimeLabel.numberOfLines = 1
        deliveryTimeLabel.font = .systemFont(ofSize: 11, weight: .regular)
        deliveryTimeLabel.textColor = .init(white: 175.0/255.0, alpha: 1)
        
        contentView.addSubview(deliveryTimeLabel)
    }
    
    private func setupExpenseLabel() {
        storeExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
        storeExpenseLabel.numberOfLines = 1
        storeExpenseLabel.font = .systemFont(ofSize: 11, weight: .regular)
        storeExpenseLabel.textColor = .init(white: 175.0/255.0, alpha: 1)
        
        contentView.addSubview(storeExpenseLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            storeImageView
                .topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 20),
            storeImageView
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 20),
            storeImageView.heightAnchor.constraint(equalToConstant: 80),
            storeImageView.widthAnchor.constraint(equalToConstant: 120),
            storeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: storeImageView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            storeDetailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            storeDetailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            storeDetailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deliveryTimeLabel.topAnchor.constraint(equalTo: storeDetailsLabel.bottomAnchor, constant: 10),
            deliveryTimeLabel.leadingAnchor.constraint(equalTo: storeDetailsLabel.leadingAnchor),
            deliveryTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            storeExpenseLabel.topAnchor.constraint(equalTo: deliveryTimeLabel.bottomAnchor, constant: 5),
            storeExpenseLabel.leadingAnchor.constraint(equalTo: deliveryTimeLabel.leadingAnchor),
            storeExpenseLabel.trailingAnchor.constraint(equalTo: deliveryTimeLabel.trailingAnchor)
        ])
        
    }
    
    func setupWithStore(_ store: Store) {
        titleLabel.text = store.name
        storeImageView.image = UIImage(named: "fastfood")
        storeDetailsLabel.text = store.description
        deliveryTimeLabel.text = "20 - 30 min"
        storeExpenseLabel.text = "$$"
    }
    
}
