//
//  Scene+ViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit


extension Scene {
  
  func viewController() -> UIViewController {
   
    switch self {
    case .home(let viewModel):
      return
         AppDelegate.dependency.resolver.resolve(ListPostViewController.self, argument: viewModel)!
      
    case .detail(let viewModel):
        return
         AppDelegate.dependency.resolver.resolve(DetailPostViewController.self, argument: viewModel)!
    }
   
  }
}
