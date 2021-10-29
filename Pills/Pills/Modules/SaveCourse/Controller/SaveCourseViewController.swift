//
//  SaveCourseViewController.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 28.10.2021.
//

import UIKit

final class SaveCourseViewController: BaseViewController<SaveCourseView> {
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.saveCourseDelegate = self
    }
}

extension SaveCourseViewController: SaveCourseViewDelegate {
    func okButtonTapped() {
        print("Ok")
    }
}
