//
//  AppLayout.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 22.07.2021.
//

import Foundation
import UIKit

enum AppLayout {
    static let widthScreen: CGFloat = UIScreen.main.bounds.width
    static let heightScreen: CGFloat = UIScreen.main.bounds.height
    
    enum AidKit {
        // MARK: - UIStackView
        static let widthStackView: CGFloat = widthScreen - (16.0*2)
        static let leadingStackView: CGFloat = (AppLayout.widthScreen - AppLayout.AidKit.widthStackView)/2.0
        static let trailingStackView: CGFloat = -(AppLayout.widthScreen - AppLayout.AidKit.widthStackView)/2.0
        
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
        static let widthProgressiveView: CGFloat = widthStackView
        static let widthIndentBetweenCells: CGFloat = 20.0
        static let heightVisiblePartOfProgressView: CGFloat = 6.0
        
        // MARK: - UIStubView
        static let indentImageFromTop: CGFloat = heightScreen/10.0
        static let widthStubImage: CGFloat = widthStackView/2
        static let heightStubImage: CGFloat = widthStackView/2
        static let leadingStubImage: CGFloat = (widthStackView - widthStubImage)/2.0
        
        // MARK: - UIAddButton
        static let heightAddButton: CGFloat = 52.0
        static let indentFromBottomAddButton: CGFloat = 14
    }

    enum Fonts {
        static let bigRegular = UIFont(name: "SFCompactDisplay-Regular", size: 20)
        static let bigSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 20)

        static let normalRegular = UIFont(name: "SFCompactDisplay-Regular", size: 17)
        static let normalSemibold = UIFont(name: "SFCompactDisplay-Semibold", size: 17)

        static let smallRegular = UIFont(name: "SFCompactDisplay-Regular", size: 13)
    }
}
