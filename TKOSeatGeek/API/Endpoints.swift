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
    case events(query: String, size: String, page: String)
    case event(id: String)
    case venues
    case venue(id: String)
    case performers
    case performer(id: String)
  
    func path() -> String {
      switch self {
      case .events(query: _, size: _, page: _): return "/2/events"
      case .event(id: let id): return "/2/events/\(id)"
      case .venues: return "/2/venues"
      case .venue(id: let id): return "/2/venues/\(id)"
      case .performers: return "/2/performers"
      case .performer(id: let id): return "/2/performers/\(id)"
      }
    }
    
    func query() -> String {
      switch self {
      case .events(query: let query, size: let size, page: let page):
        return "q=\(query)&page=\(page)&per_page=\(size)&client_id=\(API.clientId)"
      default:
        return "client_id=\(API.clientId)"
      }
    }
    
  }
  
  static func events(searchString: String, resultSize: String, page: String) -> Promise<APIResponse> {
    let request = APIRequest(
      .get,
      path: Endpoint.events(query: searchString, size: resultSize, page: page).path(),
      query: Endpoint.events(query: searchString, size: resultSize, page: page).query())
    return API.fire(request)
  }
  
  static func event(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.event(id: id).path(), query: Endpoint.event(id: id).query())
    return API.fire(request)
  }
  
  static func venues() -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.venues.path(), query: Endpoint.venues.query())
    return API.fire(request)
  }
  
  static func venue(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.venue(id: id).path(), query: Endpoint.venue(id: id).query())
    return API.fire(request)
  }
  
  static func performers() -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.performers.path(), query: Endpoint.performers.query())
    return API.fire(request)
  }
  
  static func performer(_ id: String) -> Promise<APIResponse> {
    let request = APIRequest(.get, path: Endpoint.performer(id: id).path(), query: Endpoint.performer(id: id).query())
    return API.fire(request)
  }
}
