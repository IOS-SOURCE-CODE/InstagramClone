//
//  NetworkLayer.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

final class NetworkLayer: NetworkLayerType {
   
   let baseURL : URL
   let session: URLSession
   let resource: URLConfigurationType
   
   init(baseURL: URL, urlRequest:URLConfigurationType, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
      
      self.baseURL = baseURL
      self.session = session
      self.resource = urlRequest
   }
   
   // MARK: -  required url configuration class
   func request() -> Observable<Data?> {
      
      return Observable.create { [weak self] observer in
         
         guard let strongSelf = self else {
           return Disposables.create()
         }
         
         let request = strongSelf.resource.urlRequest(baseURL: strongSelf.baseURL)
         
         let task = strongSelf.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
               observer.onError(APIClientError.Other(error))
            } else {
               guard let HTTPResponse = response as? HTTPURLResponse else {
                  fatalError("Couldn't get HTTP response")
               }
               
               if 200 ..< 300 ~= HTTPResponse.statusCode {
                  observer.onNext(data!)
                  observer.onCompleted()
               } else{
                  observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
               }
            }
         }
         
         task.resume()
         
         return Disposables.create(with: task.cancel)
         
      }
   }
   
   
   // MARK: - require url request
   func response(request: URLRequest) -> Observable<Data?> {
      return Observable.create { observer in
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
               observer.onError(APIClientError.Other(error))
            } else {
               guard let HTTPResponse = response as? HTTPURLResponse else {
                  fatalError("Couldn't get HTTP response")
               }
               
               if 200 ..< 300 ~= HTTPResponse.statusCode {
                  observer.onNext(data!)
                  observer.onCompleted()
               } else{
                  observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
               }
            }
         }
         task.resume()
         
         return Disposables.create(with: task.cancel)
      }
   }
   
}

