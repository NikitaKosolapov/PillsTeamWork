//
//  AppColorsTest.swift
//  PillsTests
//
//  Created by aprirez on 7/17/21.
//

import XCTest
@testable import Pills

class AppColorsTest: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testAppColors() throws {
        XCTAssertTrue(AppColors.white.cgColor.components != nil)
        XCTAssertTrue(AppColors.black.cgColor.components != nil)
        XCTAssertTrue(AppColors.red.cgColor.components != nil)
        XCTAssertTrue(AppColors.green.cgColor.components != nil)
        XCTAssertTrue(AppColors.blue.cgColor.components != nil)
    }

    func testUIColorExtensions() throws {
        let red = UIColor(hex: 0xFF0000)
        XCTAssertTrue(red.cgColor.components?[0] == 1.0) // test red
        XCTAssertTrue(red.cgColor.components?[1] == 0.0) // test green
        XCTAssertTrue(red.cgColor.components?[2] == 0.0) // test blue
        XCTAssertTrue(red.cgColor.components?[3] == 1.0) // test alpha

        let green = UIColor(hex: 0x00FF00)
        XCTAssertTrue(green.cgColor.components?[0] == 0.0) // test red
        XCTAssertTrue(green.cgColor.components?[1] == 1.0) // test green
        XCTAssertTrue(green.cgColor.components?[2] == 0.0) // test blue
        XCTAssertTrue(green.cgColor.components?[3] == 1.0 )// test alpha

        let blue = UIColor(hex: 0x0000FF)
        XCTAssertTrue(blue.cgColor.components?[0] == 0.0) // test red
        XCTAssertTrue(blue.cgColor.components?[1] == 0.0) // test green
        XCTAssertTrue(blue.cgColor.components?[2] == 1.0) // test blue
        XCTAssertTrue(blue.cgColor.components?[3] == 1.0) // test alpha
    }

}
