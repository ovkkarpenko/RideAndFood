//
//  AuthorizationUITests.swift
//  RideAndFoodUITests
//
//  Created by Oleksandr Karpenko on 11.01.2021.
//  Copyright © 2021 skillbox. All rights reserved.
//

import XCTest
@testable import RideAndFood

class AuthorizationUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testValidPhone() {
        let app = buildApp()
        
        //given
        let phone = "7111111111"
        let phoneTextField = app.textFields["phoneTextField"]
        let checkbox = app.otherElements["checkbox"]
        let confirmButton = app.buttons["confirmButton"]
        
        //when
        phoneTextField.tap()
        phoneTextField.typeText(phone)
        checkbox.tap()
        
        //then
        XCTAssertTrue(confirmButton.isEnabled)
    }
    
    func testInvalidPhone() {
        let app = buildApp()
        
        //given
        let phone = "711111111"
        let phoneTextField = app.textFields["phoneTextField"]
        let checkbox = app.otherElements["checkbox"]
        let confirmButton = app.buttons["confirmButton"]
        
        //when
        phoneTextField.tap()
        phoneTextField.typeText(phone)
        checkbox.tap()
        
        //then
        XCTAssertTrue(!confirmButton.isEnabled)
    }
    
    func testValidAuthCode() {
        let app = buildApp()
        
        //given
        let phone = "7111111111"
        let wrongCode = "1111"
        let phoneTextField = app.textFields["phoneTextField"]
        let checkbox = app.otherElements["checkbox"]
        let confirmButton = app.buttons["confirmButton"]
        let codeLabel = app.staticTexts["codeLabel"]
        let hiddenTextField = app.textFields["hiddenTextField"]
        let menuButton = app.buttons["menuButton"]
        
        //when
        phoneTextField.tap()
        phoneTextField.typeText(phone)
        
        checkbox.tap()
        confirmButton.tap()
        
        wait(forElement: codeLabel, timeout: 5)
        
        hiddenTextField.typeText(codeLabel.label)
        confirmButton.tap()
        
        wait(forElement: menuButton, timeout: 5)
        
        //then
        XCTAssert(menuButton.exists)
    }
    
    func testInvalidAuthCode() {
        let app = buildApp()
        
        //given
        let phone = "7111111111"
        let wrongCode = "1111"
        let phoneTextField = app.textFields["phoneTextField"]
        let checkbox = app.otherElements["checkbox"]
        let confirmButton = app.buttons["confirmButton"]
        let codeLabel = app.staticTexts["codeLabel"]
        let hiddenTextField = app.textFields["hiddenTextField"]
        
        //when
        phoneTextField.tap()
        phoneTextField.typeText(phone)
        
        checkbox.tap()
        confirmButton.tap()
        
        wait(forElement: codeLabel, timeout: 5)
        
        hiddenTextField.typeText(wrongCode)
        confirmButton.tap()
        
        //then
        XCTAssertTrue(app.alerts.count != 0)
    }
    
    func buildApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        return app
    }
}
