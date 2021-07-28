//
//  AppLayout.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 22.07.2021.
//

import Foundation
import UIKit

enum AppLayout {
    static let widthAddButton: CGFloat = UIScreen.main.bounds.width - 14.0*2
    static let heightAddButton: CGFloat = 52.0
    
    enum AidKit {
        static let paddingSegmentControl: CGFloat = 6.0/13.0
    }

    enum Fonts {
        static let normalRegular = UIFont(name: "SFCompactDisplay-Regular", size: 17)
        static let normalSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 17)

        static let smallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 13)
    }
}
