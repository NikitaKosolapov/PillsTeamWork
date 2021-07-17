//
//  AppImages.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import Foundation
import UIKit

// TUTORIAL:
//   add a picture to Assets.xcassets.
// NOTE:
//   Necessary to create its own folder with pictures for each module.
// USAGE:
//   let image: UIImage = AppImages.Pills.tablets
//   let image = AppImages.Pills.tablets

enum AppImages {

    enum Pills {
        static let tablets = UIImage(named: "tablets")
        static let capsules = UIImage(named: "capsules")
        static let drops = UIImage(named: "drops")
        static let procedure = UIImage(named: "procedure")
        static let salve = UIImage(named: "salve")
        static let spoon = UIImage(named: "spoon")
        static let syringe = UIImage(named: "syringe")
        static let suppository = UIImage(named: "suppository")
        static let suspension = UIImage(named: "suspension")
    }

    enum Tabs {
        static let aidkit = UIImage(named: "aidkit")
        static let journal = UIImage(named: "journal")
        static let settings = UIImage(named: "settings")
    }
}
