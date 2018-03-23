//
//  ListPostViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift
import Action

class ListPostViewModel {
   
   
   // MARK - Internal Access
   private let bag = DisposeBag()

   // MAKR: - Output
   var posts = Variable<[Post]>([])
   var pagination = Variable<Pagination?>(nil)
   
   // MARK: - Input
   let network: NetworkLayerType
   let translation: TranslationLayerType
   
   // MARK: - Init
   init(network: NetworkLayerType, translation: TranslationLayerType) {
      self.network = network
      self.translation = translation
      
      loadData()
   }

  lazy var detailAction: Action<Post, Swift.Never> = {
    return Action { post in
      let detailViewModel = DetailViewModel(item: [post])
      return SceneCoordinator.transition(to: .detail(viewModel: detailViewModel), type: .push).asObservable()
    }
  }()
  
   func fetchMorePage() {

      guard let nextUrl = self.pagination.value?.next_url else { return }
      
      let urlRequest = URLRequest(url: nextUrl)
      
      self.network.response(request: urlRequest).asObservable()
         .map { [weak self] data  in
            self?.responseJSON(with: data)
         }
         .map {  [weak self] newpost in
            guard let result = newpost else { return [] }
            _ = result.map { self?.posts.value.append($0) }
            return (self?.posts.value)!
         }
         .distinctUntilChanged()
         .catchErrorJustReturn([])
         .bind(to: self.posts)
         .disposed(by: self.bag)
   }
   
   
   func loadData() {
      
      ReachabilityManager.shared.isConnected
         .subscribe(onNext: { value in
            if value { request() }
         }).disposed(by: bag)
      
      func request() {
         network.request()
            .asObservable()
            .map { [weak self] data  in
               guard let strongSelf = self else { return [] }
               return strongSelf.responseJSON(with: data)
            }
            .distinctUntilChanged()
            .catchErrorJustReturn([])
            .bind(to: self.posts)
            .disposed(by: bag)
      }
   }
   
}

//MARK: - Helper
extension ListPostViewModel {
   
   fileprivate func responseJSON(with data: Data?) -> [Post] {
      guard let responseData = data else { return [] }
      guard let result: ListPost = self.translation.decode(data: responseData) else { return [] }
      self.pagination.value = result.pagination
      return result.data
   }
}


