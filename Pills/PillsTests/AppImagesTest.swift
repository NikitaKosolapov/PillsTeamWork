//
//  AppImagesTest.swift
//  PillsTests
//
//  Created by aprirez on 7/17/21.
//

import XCTest
@testable import Pills

class AppImagesTest: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testPillsImages() throws {
        XCTAssertTrue(AppImages.Pills.tablets != nil)
        XCTAssertTrue(AppImages.Pills.capsules != nil)
        XCTAssertTrue(AppImages.Pills.drops != nil)
        XCTAssertTrue(AppImages.Pills.procedure != nil)
        XCTAssertTrue(AppImages.Pills.salve != nil)
        XCTAssertTrue(AppImages.Pills.spoon != nil)
        XCTAssertTrue(AppImages.Pills.syringe != nil)
        XCTAssertTrue(AppImages.Pills.suppository != nil)
        XCTAssertTrue(AppImages.Pills.suspension != nil)
    }

    func testTabsImages() throws {
        XCTAssertTrue(AppImages.Tabs.aidkit != nil)
        XCTAssertTrue(AppImages.Tabs.journal != nil)
        XCTAssertTrue(AppImages.Tabs.settings != nil)
    }

}
