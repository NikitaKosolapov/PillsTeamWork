//
//  LocalizationTest.swift
//  PillsTests
//
//  Created by aprirez on 7/17/21.
//

import XCTest
@testable import Pills

class LocalizationTest: XCTestCase { // TODO: let's introduce R.library allowing us not to implement such tests

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    let error = String.errorNotLocalized

    func testTextHelper() throws {
        XCTAssertFalse(Text.Pills.tablets.isEmpty)
        XCTAssertFalse(Text.Pills.capsules.isEmpty)
        XCTAssertFalse(Text.Pills.drops.isEmpty)
        XCTAssertFalse(Text.Pills.procedure.isEmpty)
        XCTAssertFalse(Text.Pills.salve.isEmpty)
        XCTAssertFalse(Text.Pills.spoon.isEmpty)
        XCTAssertFalse(Text.Pills.syringe.isEmpty)
        XCTAssertFalse(Text.Pills.suppository.isEmpty)
        XCTAssertFalse(Text.Pills.suspension.isEmpty)

        XCTAssertFalse(Text.Tabs.aidkit.isEmpty)
        XCTAssertFalse(Text.Tabs.journal.isEmpty)
        XCTAssertFalse(Text.Tabs.settings.isEmpty)

        XCTAssertFalse(Text.addNewPill.isEmpty)
        XCTAssertFalse(Text.name.isEmpty)
        XCTAssertFalse(Text.singleDose.isEmpty)
        XCTAssertFalse(Text.instruction.isEmpty)
        XCTAssertFalse(Text.comments.isEmpty)
        XCTAssertFalse(Text.time.isEmpty)
        XCTAssertFalse(Text.add.isEmpty)

        XCTAssertFalse(Text.Usage.beforeMeals.isEmpty)
        XCTAssertFalse(Text.Usage.whileEating.isEmpty)
        XCTAssertFalse(Text.Usage.afterMeals.isEmpty)
        XCTAssertFalse(Text.Usage.noMatter.isEmpty)

        XCTAssertFalse(Text.Journal.accepted.isEmpty)
        XCTAssertFalse(Text.Journal.missed.isEmpty)

        XCTAssertFalse(Text.AidKit.active.isEmpty)
        XCTAssertFalse(Text.AidKit.completed.isEmpty)

        XCTAssertFalse(Text.Settings.language.isEmpty)
        XCTAssertFalse(Text.Settings.aboutApp.isEmpty)
        XCTAssertFalse(Text.Settings.writeSupport.isEmpty)
        XCTAssertFalse(Text.Settings.notification.isEmpty)
        XCTAssertFalse(Text.Settings.appearance.isEmpty)
        XCTAssertFalse(Text.Settings.privacy.isEmpty)
        XCTAssertFalse(Text.Settings.termsOfUsage.isEmpty)
        XCTAssertFalse(Text.Settings.privacyPolicy.isEmpty)
        XCTAssertFalse(Text.Settings.rate.isEmpty)
    }

    func doTestLocale(_ locale: String) throws {
        XCTAssertFalse("tablets".localized(locale) == error)
        XCTAssertFalse("capsules".localized(locale) == error)
        XCTAssertFalse("drops".localized(locale) == error)
        XCTAssertFalse("procedure".localized(locale) == error)
        XCTAssertFalse("salve".localized(locale) == error)
        XCTAssertFalse("spoon".localized(locale) == error)
        XCTAssertFalse("syringe".localized(locale) == error)
        XCTAssertFalse("suppository".localized(locale) == error)
        XCTAssertFalse("suspension".localized(locale) == error)

        XCTAssertFalse("aidkit".localized(locale) == error)
        XCTAssertFalse("journal".localized(locale) == error)
        XCTAssertFalse("settings".localized(locale) == error)

        XCTAssertFalse("addNewPill".localized(locale) == error)
        XCTAssertFalse("name".localized(locale) == error)
        XCTAssertFalse("singleDose".localized(locale) == error)
        XCTAssertFalse("instruction".localized(locale) == error)
        XCTAssertFalse("comments".localized(locale) == error)
        XCTAssertFalse("time".localized(locale) == error)
        XCTAssertFalse("add".localized(locale) == error)

        XCTAssertFalse("beforeMeals".localized(locale) == error)
        XCTAssertFalse("whileEating".localized(locale) == error)
        XCTAssertFalse("afterMeals".localized(locale) == error)
        XCTAssertFalse("noMatter".localized(locale) == error)

        XCTAssertFalse("accepted".localized(locale) == error)
        XCTAssertFalse("missed".localized(locale) == error)

        XCTAssertFalse("active".localized(locale) == error)
        XCTAssertFalse("completed".localized(locale) == error)

        XCTAssertFalse("language".localized(locale) == error)
        XCTAssertFalse("aboutApp".localized(locale) == error)
        XCTAssertFalse("writeSupport".localized(locale) == error)
        XCTAssertFalse("notification".localized(locale) == error)
        XCTAssertFalse("appearance".localized(locale) == error)
        XCTAssertFalse("privacy".localized(locale) == error)
        XCTAssertFalse("termsOfUsage".localized(locale) == error)
        XCTAssertFalse("privacyPolicy".localized(locale) == error)
        XCTAssertFalse("rate".localized(locale) == error)
    }

    func testLocaleEn() throws {
        try doTestLocale("en")
    }

    func testLocaleRu() throws {
        try doTestLocale("ru")
    }

}
