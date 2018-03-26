//
//  Pagination.swift
//  InstagramCloneApp
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


struct Pagination : Decodable {
   var next_max_id: URL?
   var next_url: URL?
   
}


extension Pagination: Equatable {
  static func ==(lhs: Pagination, rhs: Pagination) -> Bool {
    return lhs == rhs
  }
  
  
}
