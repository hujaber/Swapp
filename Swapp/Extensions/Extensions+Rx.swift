//
//  Extensions+Rx.swift
//  Swapp
//
//  Created by Hussein Jaber on 22/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: UIViewController {
     public var isLoading: Binder<Bool> {
           return Binder(self.base, binding: { (vc, active) in
               if active {
                   SVProgressHUD.show()
               } else {
                   SVProgressHUD.dismiss()
               }
           })
       }
}
