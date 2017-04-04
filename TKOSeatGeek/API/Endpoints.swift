//
//  Endpoints.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/4/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit
import PromiseKit

class Endpoints {
  private enum Endpoint {
    case events
    case event(id: String)
    case venues
    case venue(id: String)
    case performers
    case performer(id: String)
  
    func path() -> String {
      switch self {
      case .events: return "/events"
      case .event(id: let id): return "/events/\(id)"
      case .venues: return "/venues"
      case .venue(id: let id): return "/venues/\(id)"
      case .performers: return "/performers"
      case .performer(id: let id): return "/performers/\(id)"
      }
    }
  }
  
  static func events() -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.events.path())
    return API.fire(request)
  }
  
  static func event(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.event(id: id).path())
    return API.fire(request)
  }
  
  static func venues() -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.venues.path())
    return API.fire(request)
  }
  
  static func venue(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.venue(id: id).path())
    return API.fire(request)
  }
  
  static func performers() -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.performers.path())
    return API.fire(request)
  }
  
  static func performer(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.performer(id: id).path())
    return API.fire(request)
  }
}
