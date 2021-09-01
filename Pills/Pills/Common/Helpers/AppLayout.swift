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
    
    // swiftlint:disable nesting
    enum Journal {
        static let heightAddButton: CGFloat = 52
        static let pillNameFont = AppLayout.Fonts.normalSemibold
        static let paddingLeft: CGFloat = 16
        static let paddingRight: CGFloat = 16
        static let paddingBottom: CGFloat = 14

        enum Calendar {
            static let paddingLeft: CGFloat = 10
            static let paddingRight: CGFloat = 10
        }

        enum Stub {
            static let paddingTop: CGFloat = 30
            static let spacing: CGFloat = 16
        }

        // MARK: - UITableViewCell
        static let timeFont = AppLayout.Fonts.normalRegular
        static let timeLabelSize = CGSize(width: 54, height: 18)
        
        static let instructionFont = AppLayout.Fonts.smallRegular
        static let instructionTextColor = AppColors.semiBlack
        
        static let cellCornerRadius: CGFloat = 10
        static let cellBackgroundColor = AppColors.lightGray
        static let cellVerticalSpacing: CGFloat = 8
        static let cellPaddingTop: CGFloat = 18
        static let cellPaddingBottom: CGFloat = 18
        static let cellHorizontalSpacing: CGFloat = 8
        
        static let pillImageSize = CGSize(width: 28, height: 28)
        static let pillImageContainerSize = CGSize(width: 36, height: 36)
        static let pillImageContainerRadius: CGFloat = 18
        
        static let defaultStackViewSpacing: CGFloat = 10
        
        static let cellHeight: CGFloat = 80
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
        static let indentRateView: CGFloat = 36
        static let widthRateView: CGFloat = widthScreen - indentRateView*2
        static let heightRateView: CGFloat = 176.0
        static let leadingRateView: CGFloat = (AppLayout.widthScreen - widthRateView)/2
        static let topRateView: CGFloat = (0.8 * AppLayout.heightScreen - heightRateView)/2
        static let topStackView: CGFloat = 21
        static let leadingStackView: CGFloat = 22
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

    enum CustomTextField {
        static let paddingLeft: CGFloat = 12
        static let paddingRight: CGFloat = 12
        static let paddingTop: CGFloat = 12
        static let paddingBottom: CGFloat = 12
        
        static let standardHeight: CGFloat = 44
        static let cornerRadius: CGFloat = 10
    }

    enum AddCourse {
        static let pillNameFieldMaxLength = 50
        static let doseFieldMaxLength = 10
        static let periodFieldMaxLength = 5

        static let doseTypeDropDownWidth: CGFloat = 67
        static let typeInputWidth: CGFloat = 92
        static let doseUnitInputWidth: CGFloat = 106
        static let periodDropDownWidth: CGFloat = 120

        static let horizontalSpacing: CGFloat = 16
        static let noteInputHeight: CGFloat = 200
        
        // Fields for receiving frequency
        static let heightTextField: CGFloat = 44
        static let heightLabel: CGFloat = 16
        
        static let spaceCheckButtonAndLabel: CGFloat = 4
        static let widthCheckOfDay: CGFloat = 21
        static let heightCheckOfDay: CGFloat = 21

        static let spaceTextFieldsXDaysAndYDays: CGFloat = 16
        static let spaceTextFieldAndLabelForXDaysAndYDays: CGFloat = 8
    }
    
    enum Settings {
        static let cellHeight: CGFloat = 68
        static let cellCornerRadius: CGFloat = 10
    }
}
