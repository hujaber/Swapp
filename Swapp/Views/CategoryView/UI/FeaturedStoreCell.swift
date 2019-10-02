//
//  FeaturedStoreCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 30/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

class FeaturedStoreCell: UICollectionViewCell {
    
    class var identifier: String {
        self.nameOfClass
    }
    
    private let itemBackgroundView = UIView()
    private let storeImageView = UIImageView()
    private let storeTitleLabel = UILabel()
    private let storeDetailsLabel = UILabel()
    private let deliveryTimeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defer {
            activateConstraints()
        }
        setupBackgroundView()
        setupStoreImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        itemBackgroundView.layer.cornerRadius = 10
        itemBackgroundView.layer.borderColor = UIColor.categoryCellShadowColor.cgColor
        itemBackgroundView.layer.borderWidth = 1
    }
    
    
    
    private func setupBackgroundView() {
        itemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        itemBackgroundView.clipsToBounds = true
        itemBackgroundView.backgroundColor = .appBackgroundColor
        
        contentView.addSubview(itemBackgroundView)
    }
    
    private func setupStoreImageView() {
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
        storeImageView.image = UIImage(named: "fastfood")
        storeImageView.contentMode = .scaleAspectFill
        itemBackgroundView.addSubview(storeImageView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            itemBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemBackgroundView.heightAnchor.constraint(equalToConstant: 120),
            itemBackgroundView.widthAnchor.constraint(equalToConstant: 140),
            
            storeImageView.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor),
            storeImageView.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor),
            storeImageView.trailingAnchor.constraint(equalTo: itemBackgroundView.trailingAnchor),
            storeImageView.heightAnchor.constraint(equalTo: itemBackgroundView.heightAnchor, multiplier: 0.6)
        ])
    }
    
}
