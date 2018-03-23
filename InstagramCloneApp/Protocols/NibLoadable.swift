//
//  NibLoadableViewType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

protocol NibLoadable : class {
  static var nibName: String { get }
}


extension NibLoadable where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}
