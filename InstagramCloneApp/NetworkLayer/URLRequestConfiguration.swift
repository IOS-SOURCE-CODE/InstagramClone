//
//  URLRequestConfiguration.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

protocol URLParameterConfigurationType {
  var parameters: [String: Any]? { get }
}

protocol URLBodyConfigurationType {
  var body: [String: Any]! { get set }
}


protocol URLConfigurationType {
  var method: Method { get }
  var path: String! { get set }
  
  func urlRequest(baseURL: URL) -> URLRequest
}


extension URLConfigurationType {
  
   func component(baseURL: URL) -> NSURLComponents {
    
    let url = baseURL.appendingPathComponent(path)
    
    guard let component = NSURLComponents(url: url, resolvingAgainstBaseURL: false) else { fatalError("Unable to create URL components from \(String(describing: url))") }
    return component
  }
}
