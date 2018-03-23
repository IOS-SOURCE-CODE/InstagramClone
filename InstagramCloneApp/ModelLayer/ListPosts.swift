//
//  ListPosts.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct ListPost: Decodable {
   var data: [Post]
   var pagination: Pagination?
   
   enum CodingKeys: String, CodingKey {
      case data
      case pagination
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      data = try values.decode([Post].self, forKey: .data)
     pagination = try values.decode(Pagination.self, forKey: .pagination)
      
      
      
      
   }
}
