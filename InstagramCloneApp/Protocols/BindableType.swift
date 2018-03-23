//
//  BindableType.swift
//  EcommerceShopping
//
//  Created by Hiem Seyha on 2/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import Action

protocol BindableType {
   associatedtype  T
   
   var viewModel: T! { get set }
   
   func bindViewModel()
}

extension BindableType where Self: UIViewController {
   
   mutating func bindViewModel(to model: Self.T) {
      viewModel = model
      loadViewIfNeeded()
      bindViewModel()
      
   }
   
}



