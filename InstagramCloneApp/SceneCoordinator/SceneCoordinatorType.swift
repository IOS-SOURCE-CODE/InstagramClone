//
//  SceneCoordinatorType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType: class {
  
  
   @discardableResult
   static func transition(to scene: Scene, type: SceneTransitionType) -> Completable
  
  @discardableResult
  static func pop(animated: Bool) -> Completable
  
  
}

extension SceneCoordinatorType {
  
  @discardableResult
  static func pop() -> Completable {
    return pop(animated: true)
  }
}
