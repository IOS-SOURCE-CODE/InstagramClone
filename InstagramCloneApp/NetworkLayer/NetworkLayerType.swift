//
//  NetworkLayerType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkLayerType {
   func request() -> Observable<Data?>
   func response(request: URLRequest) -> Observable<Data?>
}
