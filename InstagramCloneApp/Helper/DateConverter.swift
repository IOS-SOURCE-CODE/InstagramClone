//
//  DateConverter.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


public protocol TransformType {
   associatedtype Object
   associatedtype JSON
   
   func transformFromJSON(_ value: Any?) -> Object?
   func transformToJSON(_ value: Object?) -> JSON?
}


class DateConverter: TransformType {
   public typealias Object = Date
   public typealias JSON = Double
   
   init() {}
   
   func transformFromJSON(_ value: Any?) -> Date? {
      if let timeInt = value as? Double {
         return Date(timeIntervalSince1970: TimeInterval(timeInt))
      }
      
      if let timeStr = value as? String {
         return Date(timeIntervalSince1970: TimeInterval(atof(timeStr)))
      }
      
      return nil
   }
   
   func transformToJSON(_ value: Date?) -> Double? {
      if let date = value {
         return Double(date.timeIntervalSince1970)
      }
      return nil
   }
   
   fileprivate func stringFromDate(date: Date) -> String {
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
      let dateString = dateFormatter.string(from: date)
      guard let date = dateFormatter.date(from: dateString) else {
         fatalError("nable to create date from string \(dateString) with format \(dateFormatter.dateFormat)")
      }
      
      let now = Date()
      
      let componentsFormatter = DateComponentsFormatter()
      componentsFormatter.allowedUnits = [.day, .minute, .hour]
      componentsFormatter.maximumUnitCount = 2
      componentsFormatter.unitsStyle = .full
      
      guard let fromString = componentsFormatter.string(from: date, to: now) else { return "" }
      
      return "\(fromString) ago"
   }
   
   func convertFromStringTimeStamp(value:String) ->String? {
      guard let date = transformFromJSON(value) else { return nil }
      return stringFromDate(date: date)
   }
}
