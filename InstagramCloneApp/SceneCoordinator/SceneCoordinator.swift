//
//  SceneCoordinator.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift

class SceneCoordinator {
  
   static var currentViewController: UIViewController?
   static var window: UIWindow!

   
   private init() {}
   
   static let share : SceneCoordinator =  {
      return SceneCoordinator()
   }()
  
  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }
}


extension SceneCoordinator : SceneCoordinatorType {
   
   typealias me = SceneCoordinator
  
  @discardableResult
   static func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
    
    let subject = PublishSubject<Void>()
    let viewController = scene.viewController()
    
    switch type {
      
    case .root:
      
      window.rootViewController = MainNavigationController(rootViewController: viewController)
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      
      
      subject.onCompleted()
      
    case .push:
      guard let navigationController = currentViewController?.navigationController else {
        fatalError("Can't push a view controller without a current navigation controller")
      }
      
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      
      navigationController.pushViewController(viewController, animated: true)
      currentViewController = me.actualViewController(for: viewController)
      
    case .modal:
      currentViewController?.present(viewController, animated: true, completion: {
        subject.onCompleted()
      })
      
      currentViewController = me.actualViewController(for: viewController)
    }
    
    return subject.asObserver().take(1).ignoreElements()
  }
  
  @discardableResult
  static func pop(animated: Bool) -> Completable {
    
    let subject = PublishSubject<Void>()
    
    if let presenter = currentViewController?.presentingViewController {
      currentViewController?.dismiss(animated: animated, completion: {
         
         me.currentViewController = me.actualViewController(for: presenter)
        subject.onCompleted()
      })
    } else if let navigationController = currentViewController?.navigationController {
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      
      
      guard navigationController.popViewController(animated: animated) != nil else {
        fatalError("can't navigate back from \(currentViewController!)")
      }
      
      
      currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
    } else {
      fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController!)")
    }
    
    return subject.asObserver().take(1).ignoreElements()
  }
  
}

