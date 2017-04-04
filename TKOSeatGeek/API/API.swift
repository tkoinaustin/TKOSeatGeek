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
}

struct APIRequest {
  var object: URLRequest
  
  var body: String = "" { didSet {
    object.httpBody = body.data(using: .utf8)
  }}
  
  init(_ method: HTTPMethod, path: String, headers: [String : String] = [String: String]()) {
    let url = API.baseURL.appendingPathComponent(path)
    self.object = URLRequest(url: url)
    self.object.httpMethod = method.rawValue
    self.object.httpBody = body.data(using: .utf8)
    
    for (key, value) in headers {
      self.object.addValue(value, forHTTPHeaderField: key)
    }
  }
}

class API {
  static var baseURL = URL(string: "https://api.seatgeek.com/2/")!
  
  static var session = URLSession()
  
  static func fire(_ request: APIRequest) -> Promise<APIResponse> {
    
    return Promise<APIResponse> { fulfill, reject in
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
