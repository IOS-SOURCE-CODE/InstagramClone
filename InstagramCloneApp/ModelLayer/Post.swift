//
//  Post.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


struct Post : Decodable {
   let id: String
   let user: User
   let images: Images
   let likes: Like
   let comments: Comment
   let created_time: String
   

}

extension Post : Equatable {
   static func ==(lhs: Post, rhs: Post) -> Bool {
      return true
   }
}
