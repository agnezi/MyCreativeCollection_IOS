//
// MyCreativeCollectionUITests
// Created by: itsjagnezi on 13/04/23
// Copyright (c) today and beyond
//

import XCTest

final class MyCreativeCollectionUITests: XCTestCase {

    override func setUpWithError() throws {
        
			
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testContentViewScreen() throws {
			let app = XCUIApplication()
				
			app.launchArguments = ["isRunningUITests"]
			app.launch()
			
			let contentViewScreen = app.navigationBars["Collections"]
			
			if ProcessInfo.processInfo.arguments.contains("isRunningUITests") {
				let contentViewNavigationTitle = contentViewScreen.staticTexts["Collections"]
				
				XCTAssert(contentViewNavigationTitle.exists)
				
				let sectionOfList = contentViewScreen.staticTexts["Things to read"]
				
				XCTAssert(sectionOfList.exists)
				
			}
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
