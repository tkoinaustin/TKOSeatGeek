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

class SearchViewModel: NSObject {
  var results: EventSet!
  var events = [Event]()
  var updateUI: (() -> Void) = { }
  
  var searchString: String = "" { didSet {
    if searchString == "" {
      events.removeAll()
      updateUI()
    } else {
      _ = self.load(searchString)
    }
  }}
  
  func load(_ searchString: String) -> Promise<Void> {
    return EventSet.load(searchString).then { results -> Promise<Void> in
      print(results)
      self.results = results
      self.events = results.events
      self.updateUI()
      return Promise {fulfill, _ in
        fulfill()
      }
    }
  }
}
