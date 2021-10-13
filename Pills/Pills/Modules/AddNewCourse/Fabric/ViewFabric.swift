//
//  ViewFabric.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 13.10.2021.
//

import UIKit
import SnapKit

final class ViewFabric {
    
    static func generateView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.snp.makeConstraints {
            $0.height.width.equalTo(AppLayout.AddCourse.insetViewSize)
        }
        return view
    }
    
}
