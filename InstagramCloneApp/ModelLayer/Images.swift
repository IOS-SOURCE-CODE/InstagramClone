//
//  Image.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct Images: Decodable {
   let thumbnail:ImageResource
   let lowResolution: ImageResource
   
   enum CodingKeys: String, CodingKey {
      case thumbnail
      case lowResolution  = "low_resolution"
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      thumbnail = try values.decode(ImageResource.self, forKey: .thumbnail)
      lowResolution = try values.decode(ImageResource.self, forKey: .lowResolution)
   }
}


struct ImageResource: Decodable {
   let width:Int
   let height:Int
   let url:URL
   
   enum CodingKeys: String, CodingKey {
      case width
      case height
      case url 
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      width = try values.decode(Int.self, forKey: .width)
      height = try values.decode(Int.self, forKey: .height)
      url = try values.decode(URL.self, forKey: .url)
   }
}
