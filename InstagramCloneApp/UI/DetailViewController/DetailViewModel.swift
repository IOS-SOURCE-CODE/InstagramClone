//
//  DetailViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
   
  var item = Variable<[Post]>([])
  
  init(item:[Post]) {
    self.item.value = item
  }
   
   
   
}
