//
//  AppDelegate.swift
//  InstagramCloneApp
//
//  Created by Hiem Seyha on 3/23/18.
//  Copyright © 2018 Hiem Seyha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   
   var dependencyRegistry: DependencyRegistry!
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.makeKeyAndVisible()
      
      ReachabilityManager.shared.startMonitoring()
      
      // MARK: Change endpoint production or development
      EndPoint.active = EndPointConfiguration.production.active
      
      dependencyRegistry = DependencyRegistry()
      SceneCoordinator.window = window
      let viewModel = dependencyRegistry.resolver.resolve(ListPostViewModel.self)!
      
      SceneCoordinator.transition(to: .home(viewModel: viewModel), type: .root)
      
      
      return true
   }
   
   static var dependency: DependencyRegistry = {
      let appDelegate =  UIApplication.shared.delegate as! AppDelegate
      return appDelegate.dependencyRegistry
   }()
   
}
