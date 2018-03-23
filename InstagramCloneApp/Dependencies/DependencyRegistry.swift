//
//  MainAssembly.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import Swinject

class DependencyRegistry {
   lazy var resolver: Resolver = {
      return assembler!.resolver
   }()
   private var assembler: Assembler!
   init() {
      assembler = Assembler()
      assembler.apply(assembly: ObjectsAssembly())
   }
}
