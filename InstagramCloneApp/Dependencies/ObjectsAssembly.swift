//
//  DependencyRegistry.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import Swinject

class ObjectsAssembly: Assembly {
  
  func assemble(container: Container) {
    
   
    // Register ViewModel calling
    registerViewModel(container: container)
    
    
   // Register ViewController calling
    registerViewController(container: container)
   
   
   // Register layer calling
    registerLayer(container: container)
    
  }
  
  //MARK: - Register ViewController implementation
  fileprivate func registerViewController(container:Container) {
   
   container.register(ListPostViewController.self) { (r , viewModel:ListPostViewModel) in
      
      var listPost = ListPostViewController()
      listPost.bindViewModel(to: viewModel)
      return listPost
      
   }.inObjectScope(.weak)
   
   container.register(DetailPostViewController.self) { (r , viewModel: DetailViewModel)  in
      
      var detail = DetailPostViewController()
      detail.bindViewModel(to: viewModel)
      return detail
   }.inObjectScope(.weak)
   
  }
  
  //MARK: - Register ViewModel implementation
  fileprivate func registerViewModel(container:Container) {
    
   container.register(ListPostViewModel.self) { r in
      
      let network = r.resolve(NetworkLayerType.self)!
      let translation = r.resolve(TranslationLayerType.self)!
      
      let viewModel = ListPostViewModel(network: network, translation: translation)
      return viewModel
   }.inObjectScope(.weak)
   
   
    
  }
   
   
   //MARK: - Register layer implementation
   fileprivate func registerLayer(container:Container) {
      
      container.register(TranslationLayerType.self) { _ in
         return TranslationLayer()
      }.inObjectScope(.weak)
      
      container.register(NetworkLayerType.self) { r in
         
         let baseURL = URL(string: EndPoint.active)!
         let paramater:[String:Any] = [HTTPParameter.accessToken:  Authentication.apiKey, HTTPParameter.count: 10]
         let urlRequest = GetURLRequest(path: EndPoint.Post.get.value, parameters: paramater)
         
         let network = NetworkLayer(baseURL: baseURL, urlRequest: urlRequest)
         
         let networkProxy = NetworkLayerProxy(network: network)
         
         return networkProxy
         
      }.inObjectScope(.weak)
      
   }
  
}
