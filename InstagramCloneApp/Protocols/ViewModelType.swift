//
//  ViewModelType.swift
//  EcommerceShopping
//
//  Created by Hiem Seyha on 2/26/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import Action
import RxSwift

protocol ViewModelType: class {
   var sceneCoordinator: SceneCoordinatorType { get }
}
