//
//  NetworkLayerSetupTests.swift
//  NetworkLayerSetupTests
//
//  Created by Naveen Thunga on 29/08/23.
//

import XCTest

@testable import NetworkLayerSetup

final class NetworkLayerSetupTests: XCTestCase {

    var authenticationManager = AuthenticationManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidEmail() throws {
        let expect = expectation(description: "Verify Username")
        authenticationManager.veriyUserName(emailId: "s1demo@sequoia.com") { errorObject in
            XCTFail(errorObject.localizedDescription)
            expect.fulfill()
        } success: {
            expect.fulfill()
        }
        waitForExpectations(timeout: 05, handler: nil)
    }
    
    func testInvalidEmail() throws {
        let expect = expectation(description: "Verify Username")
        authenticationManager.veriyUserName(emailId: "s1demo@abc.com") { errorObject in
            //XCTAssertEqual( errorObject, "ErrorDomain")
            expect.fulfill()
        } success: {
            XCTFail("testcase failed")
            expect.fulfill()
        }
        waitForExpectations(timeout: 05, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
