//
//  StoreCell.swift
//  Swapp
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWithStore(_ store: Store) {
        titleLabel.text = store.name
    }
    
}
