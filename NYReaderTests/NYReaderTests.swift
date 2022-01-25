//
//  NYReaderTests.swift
//  NYReaderTests
//
//  Created by Hp  on 24/01/2022.
//

import XCTest
@testable import NYReader

class NYReaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeViewModelReturnZeroArticles() throws {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(viewController: viewController)
        let count = viewModel.numberOfArticles()
        
        assert(count == 0, "Articles should initially equal 0")
    }
    
    func testTitle() throws {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(viewController: viewController)
        let newsObject = NewsModel(title: "Test", headline: "Test Headline", body: "Test Body")
        viewModel.news = [newsObject]
        let title = viewModel.title(atIndex: 0)
        
        assert(title == "Test", "Title is not retreived correctly")
    }
    
    func testHeadLine() throws {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(viewController: viewController)
        let newsObject = NewsModel(title: "Test", headline: "Test Headline", body: "Test Body")
        viewModel.news = [newsObject]
        let headLine = viewModel.headline(atIndex: 0)
        
        assert(headLine == "Test Headline", "HeadLine is not retreived correctly")
    }
    
    func testBody() throws {
        let newsObject = NewsModel(title: "Test", headline: "Test Headline", body: "Test Body")
        let viewModel = DetailsViewModel(model: newsObject)
        
        assert(viewModel.body() == "Test Body", "Body is not retreived correctly")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
