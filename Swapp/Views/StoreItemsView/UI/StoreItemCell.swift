//
//  StoreItemCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 2/10/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    
    private let itemImageView = UIImageView()
    private let itemDescriptionLabel = UILabel()
    private let itemPriceLabel = UILabel()
    private let itemTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defer {
            activateConstraints()
        }
        setupItemImageView()
        setupItemPriceLabel()
        setupItemDescriptionLabel()
        setupItemTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        itemImageView.layer.cornerRadius = 10
    }
    
    private func setupItemTitleLabel() {
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.numberOfLines = 1
        itemTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        itemTitleLabel.textColor = .black
        
        contentView.addSubview(itemTitleLabel)
    }
    
    private func setupItemImageView() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        contentView.addSubview(itemImageView)
    }
    
    private func setupItemDescriptionLabel() {
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.numberOfLines = 2
        itemDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        itemDescriptionLabel.textColor = .init(white: 175.0/255.0, alpha: 1)
        
        contentView.addSubview(itemDescriptionLabel)
    }
    
    private func setupItemPriceLabel() {
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.numberOfLines = 1
        itemPriceLabel.font = .systemFont(ofSize: 12, weight: .regular)
        itemPriceLabel.textColor = .appThemeColor
        contentView.addSubview(itemPriceLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            itemImageView
                .topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 20),
            itemImageView
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itemImageView.heightAnchor.constraint(equalToConstant: 65),
            itemImageView.widthAnchor.constraint(equalToConstant: 95),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.topAnchor, constant: 5),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            itemTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 5),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            itemPriceLabel.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: 0),
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemDescriptionLabel.leadingAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemDescriptionLabel.trailingAnchor)
        ])
    }
    
    func setupWithItem(_ item: StoreItem) {
        itemImageView.image = UIImage(named: "fastfood")
        itemPriceLabel.text = "$\(item.price)"
        itemTitleLabel.text = item.name
        itemDescriptionLabel.text = item.description
    }

}
