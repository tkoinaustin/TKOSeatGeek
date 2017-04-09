//
//  API.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/4/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import ReachabilitySwift

struct APIResponse {
  let raw: HTTPURLResponse
  let body: JSON
}

enum HTTPMethod: String {
  case get
  case post
  case put
  case delete
}

enum APIError: Error {
  case generic
  case body
  case request
  case server
  case reachability
}

struct APIRequest {
  var object: URLRequest
  
  var body: String = "" { didSet {
    object.httpBody = body.data(using: .utf8)
  }}
  
  init(_ method: HTTPMethod, path: String, query: String, headers: [String : String] = [String: String]()) {
    API.urlComponents.path = path
    API.urlComponents.query = query
    let url = API.urlComponents.url!
    self.object = URLRequest(url: url)
    self.object.httpMethod = method.rawValue
    self.object.httpBody = body.data(using: .utf8)
    
    for (key, value) in headers {
      self.object.addValue(value, forHTTPHeaderField: key)
    }
  }
}

class API {
  static var urlComponents = URLComponents(string: "https://api.seatgeek.com/2")!
  static let clientId = "NzIyNDM5OHwxNDkxMjQyOTI0LjAx"

  static var session = URLSession.shared
  
  static func fire(_ request: APIRequest) -> Promise<APIResponse> {
    
    return Promise<APIResponse> { fulfill, reject in
      guard (Reachability.init()?.isReachable)! else { return reject(APIError.reachability) }
      
      session.dataTask(with: request.object) { data, response, error in
        
        if let error = error { return reject(error) }
        guard let data = data else { return reject(APIError.body) }
        guard let httpResponse = response as? HTTPURLResponse else { return reject(APIError.generic) }
        
        switch httpResponse.statusCode {
        case 400...499: return reject(APIError.request)
        case 500...599: return reject(APIError.server)
        default: return fulfill(APIResponse(raw: httpResponse, body: JSON(data: data)))
        }
        }.resume()
    }
  }
}
