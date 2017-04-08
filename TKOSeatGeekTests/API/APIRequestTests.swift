//
//  APIRequestTests.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/4/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import XCTest

@testable import TKOSeatGeek

class APIRequestTests: XCTestCase {
  let originalURL = API.urlComponents
  
  override func setUp() {
    API.urlComponents = URLComponents(string: "https://unittest.com")!
    API.session = URLSession.shared
    super.setUp()
  }
  
  override func tearDown() {
    API.urlComponents = originalURL
    super.tearDown()
  }
  
  func testAPIRequestCreation() {
    var req = APIRequest(
      .post,
      path: "/hi/what",
      query: "",
      headers: [
        "one": "two",
        "three": "four"
      ]
    )
    
    req.body = "hi"
    
    XCTAssertEqual(String(data: req.object.httpBody!, encoding: .utf8), "hi")
    
    let headers = req.object.allHTTPHeaderFields
    
    XCTAssertEqual(headers?.count, 2)
    XCTAssertEqual(headers?["one"], "two")
    XCTAssertEqual(headers?["three"], "four")
    
    let url = URL(string: "https://unittest.com/hi/what")
    
    XCTAssertEqual(req.object.url!, url)
  }
}
