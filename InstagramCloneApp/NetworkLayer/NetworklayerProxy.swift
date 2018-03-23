//
//  NetworklayerProxy.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

final class NetworkLayerProxy: NetworkLayerType {
   
   private let realNetworklayer: NetworkLayerType
   private var isConnected = false
   private let bag = DisposeBag()
   
   init(network: NetworkLayerType) {
      self.realNetworklayer = network
   }

   func request() -> Observable<Data?> {

      guard ReachabilityManager.shared.isNetworkAvailable else {
         return Observable.just(nil)
      }
      
      return realNetworklayer.request()
   }
   
   func response(request: URLRequest) -> Observable<Data?> {
      guard ReachabilityManager.shared.isNetworkAvailable else {
         return Observable.just(nil)
      }
      return realNetworklayer.response(request:request)
   }
   
   
   
   
}
