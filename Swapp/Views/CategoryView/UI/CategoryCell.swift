//
//  CategoryCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 19/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit


class CategoryCell: UITableViewCell {
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        
    }
    
    func setupWithCategory(_ category: Category) {
        categoryTitleLabel.text = category.name
    }
}
