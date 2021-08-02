//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Vinsi on 01/08/2021.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import NewsApp

class NewsAppTests: XCTestCase {
    
    private var urlComponent: URLComponents?
    
    override func setUpWithError() throws {
        stub(condition: isHost("api.nytimes.com") && isPath("/svc/mostpopular/v2/mostviewed/all-sections")) { request in
            self.urlComponent = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            guard let path = OHPathForFile("news.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return fixture(filePath: path,
                           status: 200,
                           headers: [ "Content-Type": "application/json"]
            )
        }
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testQuery() {
        
    }
    
    func testResponse() throws {
        let expectation = XCTestExpectation(description: "Contract Check")
        let vm = HomeViewModel(articleRepository: ArticleRepository(newService: NewsServiceImpl()))
        _ = vm.$state.sink (receiveCompletion: { completion in
            switch completion {
            case .finished:()
            case .failure(let error):
                print("failed\(error.localizedDescription)")
            }
        }, receiveValue: { state in
            switch state {
            case .success:
                expectation.fulfill()
            default:()
            }
        })
    
    wait(for: [expectation], timeout: 30)
}

func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
        // Put the code you want to measure the time of here.
    }
}

}
