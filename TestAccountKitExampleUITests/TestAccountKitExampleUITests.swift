//
//  TestAccountKitExampleUITests.swift
//  TestAccountKitExampleUITests
//
//  Created by Salah on 3/28/22.
//  Copyright © 2022 Salah. All rights reserved.
//

import XCTest

class TestAccountKitExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        testEmail()
//        testPhoneNumber();
        orderSucess()
                
             
        
    }
    func testEmail(){
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Email"].tap()
        app.buttons["Login"].tap()
        XCTAssertEqual(app.tables.cells.count > 0, true)
    }
    func testPhoneNumber(){
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Phone Number"].tap()
        app.buttons["Login"].tap()
        XCTAssertEqual(app.tables.cells.count > 0, true)
    }
    // this for check order success 
    func orderSucess(){
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Phone Number"].tap()
        let phonenumberTextField = app.textFields["PhoneNumber"]
        app.buttons["Login"].tap()
        let table = app.tables.firstMatch;
        let cellElement=table.cells.element(boundBy: 2);
        cellElement.tap();
        //
        // remove textfields
        phonenumberTextField.tap()
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey/*@START_MENU_TOKEN@*/.press(forDuration: 0.7);/*[[".tap()",".press(forDuration: 0.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phonenumberTextField.tap()
        app.staticTexts["Select All"].tap()
        deleteKey.tap()
        //
        app.buttons["Login"].tap()
        let table2 = app.tables.firstMatch;
        var value = table2.staticTexts.element(boundBy:0).label

        XCTAssertTrue(value == "(type 3) +972599953505");

    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
