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
  var showError: ((APIError) -> Void) = { _ in }
  
  var searchString: String = "" { didSet {
    if searchString == "" {
      events.removeAll()
      updateUI()
    }
  }}
  
  func searchForEvents() {
    if searchString == "" {
      events.removeAll()
      updateUI()
    } else {
      _ = self.load(searchString)
    }
  }
  
  func load(_ searchString: String) -> Promise<Void> {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    return EventSet.loadEvents(searchString).then { results -> Promise<Void> in
      print(results)
      self.results = results
      self.events = results.events
      self.updateUI()
      if self.events.isEmpty {
        self.showError(APIError.noResults)
      }
      return Promise {fulfill, _ in
        fulfill()
        }
      }.catch { error in
        //swiftlint:disable force_cast
        self.showError(error as! APIError)
        //swiftlint:enable force_cast
      }.always {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
  }
}
