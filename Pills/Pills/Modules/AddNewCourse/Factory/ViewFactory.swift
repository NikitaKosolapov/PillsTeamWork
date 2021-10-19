//
//  ViewFactory.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 13.10.2021.
//

import UIKit
import SnapKit

final class ViewFactory {
    
    static func generateView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.snp.makeConstraints {
            $0.width.equalTo(AppLayout.AddCourse.insetViewSize)
        }
        return view
    }
    
}
