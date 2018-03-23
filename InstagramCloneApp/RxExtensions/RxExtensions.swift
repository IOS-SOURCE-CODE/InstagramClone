//
//  RxExtensions.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ObservableType where E: Sequence, E.Iterator.Element: Equatable {
   func distinctUntilChanged() -> Observable<E> {
      return distinctUntilChanged { (lhs, rhs) -> Bool in
         return Array(lhs) == Array(rhs)
      }
   }
}

