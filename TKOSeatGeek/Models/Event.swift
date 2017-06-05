//
//  Event.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class Event {
  let data: JSON
  let convertToDate = DateFormatter()
  let converToString = DateFormatter()

  required init? (from data: JSON) {
    guard data.dictionary != nil else { return nil }
    
    self.data = data
    convertToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    converToString.dateStyle = .long
    converToString.timeStyle = .short
  }
  
  var id: Int { return data["id"].intValue }
  var title: String { return data["title"].stringValue }
  var type: String { return data["type"].stringValue }
  var location: String { return data["venue", "extended_address"].stringValue }
  var imageUrl: URL? { return URL(string: data["performers"][0]["image"].stringValue) }
  var performers: String {
    var performers = ""
    for i in 0..<data["performers"].count {
      performers += data["performers"][i]["name"].stringValue + "\n"
    }
    return performers.substring(to: performers.index(before: performers.endIndex))
  }
  var startDate: String? {
    guard let dateString = data["datetime_local"].string else { return nil }
    guard let date = convertToDate.date(from: dateString) else { return nil }
    return converToString.string(from: date)
  }
}
