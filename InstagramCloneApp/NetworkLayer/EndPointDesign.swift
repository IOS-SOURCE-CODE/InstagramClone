//
//  EndPointDesign.swift
//  EcommerceShopping
//
//  Created by Hiem Seyha on 3/17/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

fileprivate protocol EndPointConfigurationType {
   static var baseAPI : String { get }
}

fileprivate struct EndPointProduction: EndPointConfigurationType  {
   static var baseAPI: String {
      return "https://api.instagram.com/v1/"
   }
}

fileprivate struct EndPointDevelopment: EndPointConfigurationType {
   static var baseAPI: String {
      return "https://api.instagram.com/v1/"
   }
}


fileprivate struct EndPointConfigurationFactory<T:EndPointConfigurationType> {
   
   private static var currentEndPoint: String {
      return T.baseAPI
   }
   
   static var active: String {
      return currentEndPoint
   }
}

protocol EndPointConfigurationActiveType {
   static var active: String! { get set }
}

enum EndPointConfiguration {
   
   case development
   case production
   
   var active: String {
      switch self {
      case .development:
         return EndPointConfigurationFactory<EndPointDevelopment>.active
         
      case .production:
         return EndPointConfigurationFactory<EndPointProduction>.active
      }
      
   }
}









