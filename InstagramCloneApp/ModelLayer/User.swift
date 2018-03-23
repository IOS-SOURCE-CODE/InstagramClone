//
//  User.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct User : Decodable {
   let id: String
   let fullName:String
   let profilePicture:URL
   let username:String
   
   enum CodingKeys: String, CodingKey {
      case id
      case fullName  = "full_name"
      case profilePicture = "profile_picture"
      case username
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      fullName = try values.decode(String.self, forKey: .fullName)
      profilePicture = try values.decode(URL.self, forKey: .profilePicture)
      username = try values.decode(String.self, forKey: .username)
   }
}
