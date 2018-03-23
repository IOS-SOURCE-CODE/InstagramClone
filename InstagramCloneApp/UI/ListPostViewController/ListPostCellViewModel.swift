//
//  ListPostCellViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//


import UIKit

class ListPostCellViewModel {
   
   let item: Post
   
   init(item: Post) {
      self.item = item
   }
   
   var placeHolderUrl: UIImage {
      return UIImage(named: "emptyImage")!
   }
   
   var userProfileUrl: URL {
      return item.user.profilePicture
   }
   
   var numberOfLike: String {
      return myLike(like: item.likes.count)
   }
   
   var numberOfComment:String {
      return myComment(comment: item.comments.count)
   }
   
   var postImageURl: URL {
      return item.images.lowResolution.url
   }
   
   var createDate:String {
      let dateConverter = DateConverter()
      let result = dateConverter.convertFromStringTimeStamp(value: item.created_time)!
      return result
   }
   
}

// MARK - Helper
extension ListPostCellViewModel {
   fileprivate func myLike(like: Int) -> String {
      let mylike = like > 1 ? "\(like) likes" : "\(like) like"
      return mylike
   }
   
   fileprivate func myComment(comment: Int) -> String {
      let mycomment = comment > 1 ? "\(comment) comments" : "\(comment) comment"
      return mycomment
   }
}
