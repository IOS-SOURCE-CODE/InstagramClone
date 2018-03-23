//
//  MainNavigationController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import NSObject_Rx

protocol MainNavigationControllerType {
   var sceneCoordinator: SceneCoordinatorType! { get set }
}

class MainNavigationController: UINavigationController , MainNavigationControllerType {
  
   var sceneCoordinator: SceneCoordinatorType!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.rx.didShow.skip(1).bind {
         SceneCoordinator.currentViewController = $0
      }.disposed(by: self.rx.disposeBag)
      
   }
   
   deinit {
      print("Deinit Main Navigation Controller")
   }
   
}
