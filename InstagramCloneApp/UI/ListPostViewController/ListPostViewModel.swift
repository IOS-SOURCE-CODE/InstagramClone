//
//  ListPostViewModel.swift
//  InstagramCloneApp
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
   fileprivate var pagination = Observable<Pagination?>.just(nil)
   
   // MAKR: - Output
   var posts = Variable<[Post]>([])
   
   // MARK: - Input
   fileprivate let network: NetworkLayerType
   fileprivate let translation: TranslationLayerType
   
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
   
   
   /// Load more pages when user scrolling down
   func fetchMorePage() {
      
      self.pagination
         .map { $0?.next_url }
         .filter { $0 != nil }
         .map { URLRequest(url: $0!) }
         .distinctUntilChanged { $0 == $1 }
         .flatMap { [weak self] urlRequest -> Observable<[Post]> in
            guard let this = self else { return Observable.just([]) }
            this.pagination = Observable.just(nil)
            return this.network.response(request: urlRequest)
               .flatMap { [weak self] data -> Observable<[Post]> in
                  guard let newposts =  self?.responseJSON(with: data) else {
                     return Observable.just([])
                  }
                  return Observable.of(newposts)
            }
         }
         .subscribe(onNext: { [weak self] value in
            self?.posts.value.append(contentsOf: value)
         })
         .disposed(by: bag)
      
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
            .distinctUntilChanged({ $0 == $1 })
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
      self.pagination = Observable.just(result.pagination)
      return result.data
   }
}


