//
//  ReachabilityManager.swift
//  Application Registration
//
//  Created by Hiem Seyha on 7/11/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import Foundation
import RxSwift
import ReachabilitySwift


class ReachabilityManager: NSObject {
    
   static let shared : ReachabilityManager = {
      return ReachabilityManager()
   }()
    
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .notReachable
    }
   
   private override init(){}
   
   var isConnected = BehaviorSubject(value: false)
    
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
     let reachability = Reachability()!
    
   @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
   
        switch reachability.currentReachabilityStatus {
            
        case .reachableViaWiFi:
            reachabilityStatus = .reachableViaWiFi
            isConnected.onNext(isNetworkAvailable)
            
        case .reachableViaWWAN:
            reachabilityStatus = .reachableViaWWAN
            isConnected.onNext(isNetworkAvailable)
         
        case .notReachable:
            reachabilityStatus = .notReachable
            isConnected.onNext(isNetworkAvailable)
         
        }
    }
    
    // Start Monitoring wifi
   func startMonitoring() {
      
      NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
         name: ReachabilityChangedNotification, object: reachability)
      
      do {
         try reachability.startNotifier()
      } catch {
         debugPrint("Could not start reachability notifier")
      }
   }
   
    // Stop Monitoring wifi
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }

}
