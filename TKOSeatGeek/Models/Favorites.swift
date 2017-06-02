//
//  Favorites.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/9/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import Foundation

class Favorites {
  
  static let defaults = UserDefaults.standard
  
  static func set(_ id: Int) -> Bool {
    defaults.set(true, forKey: id.description)
    return true
  }
  
  static func remove(_ id: Int) -> Bool {
    defaults.removeObject(forKey: id.description)
    return false
  }
  
  static func isFavorite(_ id: Int) -> Bool {
    return defaults.object(forKey: id.description) != nil
  }
  
  static func toggle(_ id: Int) -> Bool {
    if defaults.object(forKey: id.description) == nil { return self.set(id) }
    else { return self.remove(id) }
  }
}
