//
//  ListPostTableViewCell.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import Kingfisher

class ListPostTableViewCell: UITableViewCell {
   
   @IBOutlet weak var postImage: UIImageView!
   @IBOutlet weak var profileImage: UIImageView!
   
   @IBOutlet weak var username: UILabel!
   @IBOutlet weak var likeButton: UIButton!
   @IBOutlet weak var commentButton: UIButton!
   @IBOutlet weak var shareButton: UIButton!
   @IBOutlet weak var saveButton: UIButton!
   @IBOutlet weak var likeCountLabel: UILabel!
   @IBOutlet weak var createDateLabel: UILabel!
   @IBOutlet weak var commentLabel: UILabel!
   
   var viewModel: ListPostCellViewModel!
   
   
   func configure(with item: Post) {
      
      viewModel = ListPostCellViewModel(item: item)
      
     // Assign property
      profileImage.kf.setImage(with: viewModel.userProfileUrl)
      postImage.kf.setImage(with: viewModel.postImageURl, placeholder: viewModel.placeHolderUrl)
      likeCountLabel.text = viewModel.numberOfLike
      commentLabel.text = viewModel.numberOfComment
      createDateLabel.text = viewModel.createDate
      
      // Design ui
       profileImage.circle()
      
   }
   
}


extension ListPostTableViewCell: NibLoadable {}
extension ListPostTableViewCell: IdentifierReusable {}


