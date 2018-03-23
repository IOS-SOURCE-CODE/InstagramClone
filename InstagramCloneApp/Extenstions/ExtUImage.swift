//
//  ExtUImage.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func circle() {
    
    self.layer.cornerRadius = self.bounds.width / 2
    self.clipsToBounds = true
    
  }
}
