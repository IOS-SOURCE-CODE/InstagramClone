//
//  ExtUITableView.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//


import UIKit


extension UITableView {
  
  func register<T: UITableViewCell>(_ : T.Type) where T: IdentifierReusable  {
    register(T.self, forCellReuseIdentifier: T.identifier)
  }
  
  func register<T: UITableViewCell>(_: T.Type) where T: IdentifierReusable, T: NibLoadable {
    
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forCellReuseIdentifier: T.identifier)
    
  }
  
  func deqeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: IdentifierReusable    {
    
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Cound not dequeue cell with identifier")
    }
    return cell
  }
  
}

