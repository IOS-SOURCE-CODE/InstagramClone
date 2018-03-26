//
//  ReachabilityManager.swift
//  InstagramCloneApp

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
    
   //MARK: - add observer to reachability
   func startMonitoring() {
      
      NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
         name: ReachabilityChangedNotification, object: reachability)
      
      do {
         try reachability.startNotifier()
      } catch {
         debugPrint("Could not start reachability notifier")
      }
   }
   
    //MARK - remove observer 
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }

}
