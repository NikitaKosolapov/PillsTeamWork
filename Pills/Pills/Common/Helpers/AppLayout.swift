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
    static let widthAddButton: CGFloat = widthScreen - (16.0*2)
    static let heightAddButton: CGFloat = 52.0
    
    enum AidKit {
        // MARK: - UISegmentControl
        static let widthSegment: CGFloat = widthAddButton/2.0
        
        // MARK: - UITableView
        static let widthPillsImageView: CGFloat = 36.0
        static let heightPillsImageView: CGFloat = widthPillsImageView
        static let widthTableView: CGFloat = widthAddButton
        static let leadingTableView: CGFloat = (AppLayout.widthScreen - AppLayout.AidKit.widthTableView)/2.0
        static let trailingTableView: CGFloat = -(AppLayout.widthScreen - AppLayout.AidKit.widthTableView)/2.0
        static let tableEstimatedRowHeight: CGFloat = 10
        static let tableContentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 10, right: 0)
        static let widthProgressiveView: CGFloat = widthScreen
        
        // MARK: - UIStubView
        static let widthStubView: CGFloat = widthTableView
        static let leadingStubView: CGFloat = leadingTableView
        static let trailingStubView: CGFloat = trailingTableView
        static let heightStubTranslucentView: CGFloat = heightScreen/10.0
        static let widthStubImage: CGFloat = 150.0
        static let heightStubImage: CGFloat = 150.0
        static let leadingStubImage: CGFloat = (widthStubView - widthStubImage)/2.0
        static let trailingStubImage: CGFloat = (widthTableView - widthStubImage)/2.0
        static let widthStubLabel: CGFloat = widthTableView
        
        // MARK: - UIAddButton
        static let leadingAddButtonView: CGFloat = leadingTableView
        static let trailingAddButtonView: CGFloat = trailingTableView
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
