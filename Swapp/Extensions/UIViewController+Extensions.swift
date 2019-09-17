//
//  UIViewController+Extensions.swift
//  Swapp
//
//  Created by Hussein Jaber on 17/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

extension NSObject {
    ///Returns the name of a class as a string.
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UIViewController {
    ///Returns a view controller from the provided storyboard using its identifier
    /// - Parameter storyboard: Storyboard containing the view controller
    /// - Parameter identifier: The associated VC identifier
    ///
    /// - Returns: A view controller of the provided generic type T
    private class func instantiateController<T: UIViewController>(inStoryboard storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    ///Class func Returns a view controller from the provided storyboard using its identifier
    /// - Parameter storyboard: Storyboard containing the view controller
    /// - Parameter identifier: The associated VC identifier
    ///
    /// - Returns: A view controller with thw same caller type
    class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateController(inStoryboard: storyboard, identifier: identifier)
    }
    
    ///Class func Returns a view controller from the provided storyboard using the class name
    /// - Parameter storyboard: Storyboard containing the view controller
    ///
    /// - Returns: A view controller with thw same caller type
    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return controllerInStoryboard(storyboard, identifier: nameOfClass)
    }
    ///Class func Returns a view controller from the provided storyboard using the class name
    /// - Parameter storyboard: Storyboard enum containing the view controller
    ///
    /// - Returns: A view controller with thw same caller type
    class func controllerInStoryboard(_ storyboard: Storyboard) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle:nil), identifier: nameOfClass)
    }
}

extension UIViewController {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return topLayoutGuide.bottomAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomLayoutGuide.topAnchor
        }
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.leadingAnchor
        } else {
            return view.leadingAnchor
        }
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return view.trailingAnchor
        }
    }
}


extension UIViewController {
    func fillInViewSafely(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeTopAnchor),
            view.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
            view.bottomAnchor.constraint(equalTo: safeBottomAnchor)
            ])
    }
}

