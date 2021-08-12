//
//  AppLayout.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 22.07.2021.
//

import Foundation
import UIKit

enum AppLayout {
    static var widthScreen: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var halfWidthScreen: CGFloat {
        return widthScreen/2
    }
    
    static var heightScreen: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    enum Journal {
        static let heightAddButton: CGFloat = 52.0
    }
    
    enum AidKit {
        // MARK: - UIStackView
        static var indentStackView: CGFloat = 16.0
        static var widthStackView: CGFloat {
            return AppLayout.widthScreen - (indentStackView*2)
        }
        static var leadingStackView: CGFloat {
            return indentStackView
        }
        static var trailingStackView: CGFloat {
            return -indentStackView
        }
        
        // MARK: - UISegmentControl
        static let heightSegmentControl: CGFloat = 37.0
        
        // MARK: - UITableViewCell
        static let widthPillsImageView: CGFloat = 36.0
        static let heightPillsImageView: CGFloat = widthPillsImageView
        static let leadingCourseCellView: CGFloat = 14.0
        static let trailingCourseCellView: CGFloat = -leadingCourseCellView
        static let topCourseCellView: CGFloat = 20.0
        static let bottomCourseCellView: CGFloat = -topCourseCellView
        
        // MARK: - UITableView
        static let tableEstimatedRowHeight: CGFloat = 10
        static let tableContentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 10, right: 0)
        static var widthProgressiveView: CGFloat {
            return widthStackView
        }
        static let widthIndentBetweenCells: CGFloat = 20.0
        static let heightVisiblePartOfProgressView: CGFloat = 6.0
        
        // MARK: - UIStubView
        static var indentImageFromTop: CGFloat {
            return AppLayout.heightScreen/10.0
        }
        static var widthStubImage: CGFloat {
            return widthStackView/2
        }
        static var heightStubImage: CGFloat {
            return widthStackView/2
        }
        static var leadingStubImage: CGFloat {
            return (widthStackView - widthStubImage)/2.0
        }
        
        // MARK: - UIAddButton
        static let heightAddButton: CGFloat = 52.0
        static let indentFromBottomAddButton: CGFloat = 14
    }
    
    enum Rate {
        static let widthRateView: CGFloat = 248
        static let heightRateView: CGFloat = 176
        static let leadingRateView: CGFloat = (AppLayout.widthScreen - widthRateView)/2
        static let topRateView: CGFloat = (0.8 * AppLayout.heightScreen - heightRateView)/2
        static let topStackView: CGFloat = 21
        static let leadingStackView: CGFloat = 15
        static let trailingStackView: CGFloat = -leadingStackView
        static let bottomStackView: CGFloat = -topStackView
        static let widthSmileImageView: CGFloat = 38
        static let heightSmileImageView: CGFloat = 38
        static let widthRateButton: CGFloat = 88
        static let heightRateButton: CGFloat = 24
        
    }

    enum Fonts {
        static let bigRegular = UIFont(name: "SFCompactDisplay-Regular", size: 20)
        static let bigSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 20)

        static let normalRegular = UIFont(name: "SFCompactDisplay-Regular", size: 17)
        static let normalSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 17)

        static let smallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 13)
        static let verySmallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 10)
    }
}
