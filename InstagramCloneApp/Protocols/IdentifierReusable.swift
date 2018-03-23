//
//  IdentifierReusableProtocol.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

protocol IdentifierReusable {
  static var identifier: String { get }
}

extension IdentifierReusable {
  static var identifier: String {
    return String(describing: self)
  }
}


