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

final class AppImages {
    private static let badImage = UIImage()

    enum Tabs {
        static let aidkit = UIImage(named: "aidkit")
        static let journal = UIImage(named: "journal")
        static let settings = UIImage(named: "settings")
    }
    
    enum AidKit {
        static let stubImage = UIImage(named: "stubCourse")
    }
    
    enum Rate {
        static let badSmile = UIImage(named: "badSmile")
        static let normSmile = UIImage(named: "normSmile")
        static let okSmile = UIImage(named: "okSmile")
    }

    enum Tools {
        static let downArrow = UIImage(named: "downArrow")
        static let rightArrow = UIImage(named: "rightArrow")
        static let calendar = UIImage(named: "calendar")
    }
    
    enum AddCourse {
        static let check = UIImage(named: "check")
        static let noCheck = UIImage(named: "noCheck")
    }
}
