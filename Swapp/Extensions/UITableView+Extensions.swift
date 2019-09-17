//
//  UITableView+Extensions.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit


/// Returns the name of the nib file as `String` from the name of the class (note : nib file and its associated class must have same names)
protocol NibLoadableView: class { }
extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}

/// Retuns a `String` as a reusable identifier of any view (again using the class name as ID)
protocol ReusableView: class {}
extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView, ReusableView {}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        guard Bundle.main.path(forResource: T.NibName, ofType: "nib") != nil  else {
            if Bundle(identifier: "hujaber.FindREKit")?.path(forResource: T.NibName, ofType: "nib") != nil {
                let Nib = UINib(nibName: T.NibName, bundle: Bundle(identifier: "hujaber.FindREKit"))
                self.register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
            }
            return
        }
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        self.register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

