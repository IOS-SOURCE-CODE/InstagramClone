//
//  HTTPConfiguration.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

enum Method: String {
   case GET , POST
}

struct HTTPHeaderField {
   static let authentication = "Authorization"
   static let  contentType = "Content-Type"
   static let  acceptType = "Accept"
   static let  acceptEncoding = "Accept-Encoding"
  
   static let  json = "application/json"
}

struct HTTPParameter {
    static let  accessToken = "access_token"
    static let  count = "count"
}


// TODO: - Should store in keychain
struct Authentication {
   static let apiKey = "7322641520.f494368.f1ba46d284894a73bc75e04be1344c81"
}
