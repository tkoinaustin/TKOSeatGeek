//
//  EventSet.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class EventSet {
  let data: JSON
  let events: [Event]
  
  var page: String { return data["meta", "page"].stringValue }
  var perPage: String { return data["meta", "per_page"].stringValue }
  var total: String { return data["meta", "total"].stringValue }
  
  required init?(from data: JSON) {
    guard EventSet.isValid(data) else { return nil }
    
    self.data = data
    var events = [Event]()
    
    for event in data["events"].arrayValue {
      if let content = Event(from: event) { events.append(content) }
    }
  
    self.events = events
  }
  
  static func load(_ searchString: String, resultSize: String = "100", page: String = "1") -> Promise<EventSet> {
    return Endpoints.events(
      searchString: searchString,
      resultSize: resultSize,
      page: page
      ).then(on: DispatchQueue.global(qos: .background)) {response in
        return Promise<EventSet> { fulfill, reject in
          guard let results = EventSet(from: response.body) else { return reject(NSError.cancelledError() ) }
          fulfill(results)
        }
    }
  }
  
  static func isValid(_ data: JSON) -> Bool {
    if data.dictionary != nil { return true }
    return false
  }
}
