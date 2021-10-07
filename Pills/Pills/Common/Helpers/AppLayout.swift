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
        return widthScreen / 2
    }
    
    static var heightScreen: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // swiftlint:disable nesting
    enum Journal {
        static let heightAddButton: CGFloat = 52
        static let pillNameFont = AppLayout.Fonts.normalSemibold
        static let paddingRight: CGFloat = 14
        static let paddingBottom: CGFloat = 14
        static let minusViewWidth: CGFloat = 36
        static let minusViewHeight: CGFloat = 5
        static let minusViewPaddingTop: CGFloat = 6
        static let addButtonPaddingTop: CGFloat = 6
        static let addButtonPaddingBottom: CGFloat = 19
        static let stackViewTableViewAndButtonPaddingTop: CGFloat = 28

        enum Calendar {
            static let paddingLeft: CGFloat = 10
            static let paddingRight: CGFloat = 10
            static let heightArrowButton: CGFloat = 12
            static let widthArrowButton: CGFloat = 10
            static let arrowButtonTopSpacing: CGFloat = 16
            static let arrowButtonTrailing: CGFloat = 32
            static let arrowButtonLeading: CGFloat = -arrowButtonTrailing
            static let headerLabelHeight: CGFloat = 183
            static let calendarHeight: CGFloat = 300
        }

        enum Stub {
            static let paddingTop: CGFloat = 30
            static let spacing: CGFloat = 16
            static let manImageContainerHeight: CGFloat = 169
        }

        // MARK: - UITableViewCell
        
        static let timeFont = AppLayout.Fonts.normalRegular
        static let timeLabelSize = CGSize(width: 54, height: 18)
        
        static let instructionFont = AppLayout.Fonts.smallRegular
        
        static let cellCornerRadius: CGFloat = 10
        static let cellBackgroundColor = AppColors.lightGray
        static let cellVerticalSpacing: CGFloat = 8
        static let cellPaddingTop: CGFloat = 18
        static let cellPaddingBottom: CGFloat = 18
        static let cellHorizontalSpacing: CGFloat = 8
        
        static let pillImageSize: CGFloat = 25
        static let pillImageContainerSize: CGFloat = 36
        static let pillImageContainerRadius: CGFloat = 18
        static let pillTypeImagePaddingTop: CGFloat = 5
        
        static let defaultStackViewSpacing: CGFloat = 10
        
        static let cellHeight: CGFloat = 80
    }
    
    enum MedicineDescription {
        static let pillNameFont = AppLayout.Fonts.normalSemibold
        static let pillsQuantityFont = AppLayout.Fonts.smallRegular
        static let instructionFont = AppLayout.Fonts.smallRegular
        static let timeFont = AppLayout.Fonts.normalRegular
        static let pillInstructionFont = AppLayout.Fonts.verySmallRegular
        static let pillImageContainerRadius: CGFloat = 18
        static let defaultStackViewSpacing: CGFloat = 10
        static let stackViewVerticalSpacing: CGFloat = 2
        static let stackViewHorizontalSpacing: CGFloat = 13
        static let mainVerticalStackViewSpacing: CGFloat = 14
        static let windowViewCornerRadius: CGFloat = 10
        static let timeLabelCornerRadius: CGFloat = 4
        static let windowViewHeight: CGFloat = 181
        static let windowViewWidth: CGFloat = 288
        static let aspectRatio: CGFloat = 156 / 568
        static let topPadding: CGFloat = aspectRatio * UIScreen.main.bounds.height
        static let windowViewLeading: CGFloat = 16
        static let windowViewTrailing: CGFloat = -16
        static let windowViewBottomAnchor: CGFloat = -16
        static let windowViewTopAnchor: CGFloat = 16
        static let stackViewHorizontalHeight: CGFloat = 36
        static let pillImageContainerWidthAndHeight: CGFloat = 36
        static let timeLabelWidth: CGFloat = 54
        static let pillInstructionLabelTopAnchor: CGFloat = 14
        static let buttonStackViewTopAnchor: CGFloat = 14
        static let buttonStackViewHeight: CGFloat = 45
        static let buttonStackViewSpacing: CGFloat = 12
        
    }
    
    enum AidKit {
        // MARK: - UIStackView
        
        static var indentStackView: CGFloat = 16.0
        static var topInsetStackView: CGFloat = 19.0
        static var bottomInsetStackView: CGFloat = topInsetStackView
        static var mainStackViewSpacing: CGFloat = 5
        static var widthStackView: CGFloat {
            return AppLayout.widthScreen - (indentStackView * 2)
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
        
        static let pillImageSize: CGFloat = 25
        static let pillImageContainerSize: CGFloat = 36
        static let pillImageContainerRadius: CGFloat = 18
        static let leadingCourseCellView: CGFloat = 14.0
        static let topCourseCellView: CGFloat = 20.0
        
        // MARK: - CoursesCellView
        
        static let durationAndDaysStackViewSpacing: CGFloat = 10
        static let mainCoursesCellStackViewSpacing: CGFloat = 10
        
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
            return AppLayout.heightScreen / 10.0
        }
        static var widthStubImage: CGFloat {
            return widthStackView / 2
        }
       
        static var leadingStubImage: CGFloat {
            return (widthStackView - widthStubImage) / 2.0
        }
        static var stubInfoLabelTopAnchor: CGFloat = 15.0
        
        // MARK: - UIAddButton
        
        static let heightAddButton: CGFloat = 52.0
        static let indentFromBottomAddButton: CGFloat = 14
    }

    enum Alert {
        static let indentView: CGFloat = 36
        static let widthView: CGFloat = widthScreen - indentView * 2
        static let leadingView: CGFloat = (AppLayout.widthScreen - widthView) / 2
        static let heightView: CGFloat = 181.0
        static let topView: CGFloat = 0.25 * AppLayout.heightScreen
        static let widthButton: CGFloat = 122
        static let heightButton: CGFloat = 45
        static let topStackView: CGFloat = 24
        static let leadingStackView: CGFloat = 16
        static let trailingStackView: CGFloat = -leadingStackView
        static let bottomStackView: CGFloat = -topStackView
        static let cornerRadius: CGFloat = 10
        static let spacingVertical: CGFloat = 15
        static let spasingHorizontal: CGFloat = 16
        
    }
    
    enum Rate {
        static let heightView: CGFloat = 213.0
        static let widthSmileImageView: CGFloat = 38
        static let heightSmileImageView: CGFloat = 38
    }
    
    enum DeletePill {
        static let heightView: CGFloat = 181.0
        static let labelHeight: CGFloat = 32
    }

    enum Fonts {
        static let bigRegular = UIFont(name: "SFCompactDisplay-Regular", size: 20)
        static let bigSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 20)

        static let normalRegular = UIFont(name: "SFCompactDisplay-Regular", size: 17)
        static let normalSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 17)

        static let smallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 13)
        static let verySmallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 10)
        
        static let rateButtonSmall = UIFont(name: "SFCompactDisplay-Semibold", size: 14)
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
        static let textFieldsXDaysAndYDays = 2

        static let typeInputWidth: CGFloat = 92
        static let doseUnitInputWidth: CGFloat = 106

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
        static let vStackViewSpacing: CGFloat = 8
    }
    
    enum Settings {
        static let cellHeight: CGFloat = 68
        static let cellCornerRadius: CGFloat = 10
    }
}
