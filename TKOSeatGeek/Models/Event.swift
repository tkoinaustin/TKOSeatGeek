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
  let id: Int
  let title: String
  let location: String
  let startDate: String
  
  init?(
    id: Int?,
    title: String?,
    location: String?,
    startDate: String?
    ) {
    guard let id = id else { return nil }
    self.id = id

    guard let title = title else { return nil }
    self.title = title
    
    guard let location = location else { return nil }
    self.location = location
    
    guard let startDate = startDate else { return nil }
    self.startDate = startDate
  }
}
