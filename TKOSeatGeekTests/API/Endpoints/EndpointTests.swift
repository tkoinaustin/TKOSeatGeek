//
//  EndpointTests.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/4/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import TKOSeatGeek

class EndpointTests: XCTestCase {
  let originalURL = API.urlComponents
  
  override func setUp() {
    API.urlComponents = URLComponents(string: "https://example.com")!
    API.session = URLSession.shared
    super.setUp()
  }
  
  override func tearDown() {
    OHHTTPStubs.removeAllStubs()
    API.urlComponents = originalURL
    super.tearDown()
  }
  
  func testEvents200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/events")) { _ in
      let path = OHPathForFileInBundle("events-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.events(searchString: "word", resultSize: "10", page: "1").then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testEvent200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/events/3524773")) { _ in
      let path = OHPathForFileInBundle("event-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.event("3524773").then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testVenues200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/venues")) { _ in
      let path = OHPathForFileInBundle("venues-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.venues().then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testVenue200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/venues/35")) { _ in
      let path = OHPathForFileInBundle("venue-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.venue("35").then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testPerformers200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/performers")) { _ in
      let path = OHPathForFileInBundle("performers-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.performers().then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testPerformer200() {
    let async = expectation(description: "async")
    
    stub(condition: isPath("/performers/9655")) { _ in
      let path = OHPathForFileInBundle("performer-200.response", Bundle(for: type(of: self)))!
      let raw = try? String(contentsOfFile: path)
      return OHHTTPStubsResponse(httpMessageData: raw!.data(using: .utf8)!)
    }
    
    Endpoints.performer("9655").then { response -> Void in
      XCTAssertNotNil(response.body.dictionary)
      async.fulfill()
      }.catch { _ in }
    
    waitForExpectations(timeout: 2, handler: nil)
  }
}
