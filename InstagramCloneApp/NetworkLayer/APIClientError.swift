//
//  APIClientError.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

enum APIClientError: Error {
  case CouldNotDecodeJSON
  case BadStatus(status: Int)
  case Other(Error)
}
