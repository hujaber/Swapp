//
//  CategoryCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 19/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell {
    
    private let categoryImageView: UIImageView = .init()
    private let categoryTitleLabel: UILabel = .init()
    private let itemBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defer {
            activateConstraints()
        }
        
        setupBackgroundView()
        setupCategoryImageView()
        setupTextLabel()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        itemBackgroundView.layer.cornerRadius = 20
        itemBackgroundView
            .layer
            .borderColor = UIColor.categoryCellShadowColor.cgColor
        itemBackgroundView.layer.borderWidth = 1
    }
    
    private func addShadowToBackground() {
        itemBackgroundView.layer.shadowColor = UIColor.categoryCellShadowColor.cgColor
        itemBackgroundView.layer.shadowOffset = .init(width: 1, height: 1)
        itemBackgroundView.layer.shadowRadius = 12
        itemBackgroundView.layer.shadowOpacity = 1
        itemBackgroundView.layer.shadowPath = UIBezierPath(rect: itemBackgroundView.bounds).cgPath
        itemBackgroundView.layer.rasterizationScale = UIScreen.main.scale
        itemBackgroundView.layer.shouldRasterize = true
        itemBackgroundView.layer.masksToBounds = true
    }
    
    private func setupBackgroundView() {
        itemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        itemBackgroundView.backgroundColor = .appBackgroundColor
        itemBackgroundView.clipsToBounds = true
        contentView.addSubview(itemBackgroundView)
    }
    
    private func setupCategoryImageView() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate)
        categoryImageView.image = image
        categoryImageView.tintColor = .appThemeColor
        categoryImageView.contentMode = .scaleAspectFill
        itemBackgroundView.addSubview(categoryImageView)
    }
    
    private func setupTextLabel() {
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryTitleLabel.numberOfLines = 1
        categoryTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        // rgba(58, 71, 89, 1)
        categoryTitleLabel.textColor = .colorWithRGBA(58, 71, 89)
        itemBackgroundView.addSubview(categoryTitleLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            itemBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            itemBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itemBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            itemBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            categoryImageView.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor, constant: 12),
            categoryImageView.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor, constant: 15),
            categoryImageView.heightAnchor.constraint(equalToConstant: 25),
            categoryImageView.widthAnchor.constraint(equalToConstant: 25),
            categoryImageView.bottomAnchor.constraint(equalTo: itemBackgroundView.bottomAnchor, constant: -12),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 15),
            categoryTitleLabel.centerYAnchor.constraint(equalTo: categoryImageView.centerYAnchor)
        ])
    }
    
    func setupWithCategory(_ category: Category) {
        categoryTitleLabel.text = category.name
    }
}
