//
//  SearchViewModel.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit

class SearchViewModel {
  var results: EventSet!
  
  var searchString: String = "" { didSet {
      //search
    _ = self.load(searchString)
  }}
  
  func load(_ searchString: String) -> Promise<Void> {
    return EventSet.load(searchString).then { results -> Promise<Void> in
      print(results)
      self.results = results
      return Promise {fulfill, _ in
        fulfill()
      }
    }
  }
}
