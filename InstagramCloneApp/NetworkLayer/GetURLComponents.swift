//
//  GetURLComponents.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


class GetURLRequest: URLConfigurationType, URLParameterConfigurationType {
  
  var method: Method {
    return .GET
  }
  
  var path: String!
  
  var parameters: [String : Any]?
  
  init(path:String, parameters: [String: Any]? = nil) {
    self.parameters = parameters
    self.path = path
  }
  
  func urlRequest(baseURL: URL) -> URLRequest {
    
    let urlcomponent = component(baseURL: baseURL)
    
    if parameters != nil {
      
      urlcomponent.queryItems = parameters!.map {
        (NSURLQueryItem(name: String(describing: $0), value: String(describing: $1)) as URLQueryItem)
      }
    }
    
    guard let finalURL = urlcomponent.url  else {
      fatalError("Unable to retrieve final URL")
    }
    
    var request = URLRequest(url: finalURL)
    
    request.httpMethod = method.rawValue
    request.setValue(HTTPHeaderField.json,
                     forHTTPHeaderField: HTTPHeaderField.acceptType)
    return request
  }
}
