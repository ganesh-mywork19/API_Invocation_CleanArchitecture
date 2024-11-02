//
//  APIServiceManagerTests.swift
//  MyTaskTests
//
//  Created by Ganesh Guturi on 04/09/24.
//

import XCTest
@testable import MyTask

final class APIServiceManagerTests: XCTestCase {

    private let maxTimeInterval: TimeInterval = 5 //it depends on the env
    private var sut: APIServiceManagerProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIServiceManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testUrlSession() {
        XCTAssertNotNil(sut.urlSession)
    }
    
    func testAPIInvocation_success() {
        let exp = expectation(description: "Mock API Service")
        let reqModel = APIMockSuccessRequest(requestId: "1234")
        Task {
            do {
                let _ = try await sut.fetchData(requestModel: reqModel, expectingType: APIMockResponse.self)
                exp.fulfill()
            }catch {
                print(error)
            }
        }
        wait(for: [exp], timeout: maxTimeInterval)
    }
    
    func testAPIInvocation_failure() {
        let exp = expectation(description: "Mock API Service")
        let reqModel = APIMockFailureRequest(requestId: "12345")
        Task {
            do {
                let _ = try await sut.fetchData(requestModel: reqModel, expectingType: APIMockResponse.self)
            }catch {
                print(error)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: maxTimeInterval)
    }
}
