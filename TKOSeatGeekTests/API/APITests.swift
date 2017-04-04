//
//  APITests.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/4/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import TKOSeatGeek

class APITests: XCTestCase {
  var smokeRequest: APIRequest { return APIRequest(.get, path: "/smoke") }
  let originalURL = API.baseURL
  
  override func setUp() {
    API.baseURL = URL(string: "https://example.com")!
    API.session = URLSession.shared
    super.setUp()
  }
  
  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
    API.baseURL = originalURL
    super.tearDown()
  }
  
  func testAPIFireSuccess200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/smoke")) { _ in
      let obj = ["status": "ok"]
      return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
    }
    
    _ = API.fire(smokeRequest).then { response -> Void in
      XCTAssertEqual(response.body["status"], "ok")
      async.fulfill()
    }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testAPIFireFailure401() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/smoke")) { _ in
      let obj = ["status": "notok"]
      return OHHTTPStubsResponse(jsonObject: obj, statusCode: 401, headers: nil)
    }
    
    API.fire(smokeRequest).then { _ -> Void in
      }.catch { error in
        XCTAssertEqual(error as? APIError, APIError.request)
        async.fulfill()
    }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testAPIFireFailure503() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/smoke")) { _ in
      let obj = ["status": "notok"]
      return OHHTTPStubsResponse(jsonObject: obj, statusCode: 503, headers: nil)
    }
    
    API.fire(smokeRequest).then { _ -> Void in
      }.catch { error in
        XCTAssertEqual(error as? APIError, APIError.server)
        async.fulfill()
    }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testAPIFireFailure() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/smoke")) { _ in
      return OHHTTPStubsResponse(error: APIError.generic)
    }
    
    API.fire(smokeRequest).then { _ -> Void in
      }.catch { error in
        XCTAssertEqual(error as? APIError, APIError.generic)
        async.fulfill()
    }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
}
