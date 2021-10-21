//
//  CompletePillViewController.swift
//  Pills
//
//  Created by Mac on 20.10.2021.
//

import UIKit

class CompletePillViewController: BaseViewController<CompletePillView> {
    
    weak var delegate: CompleteCoursesByIndexPath?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.completePillViewDelegate = self
    }
}

extension CompletePillViewController: CompletePillViewDelegate {
    
    func yesButtonTouchUpInside() {
        delegate?.completeRowAt()
        dismiss(animated: false)
    }
    
    func noButtonTouchUpInside() {
        dismiss(animated: false)
    }
}
