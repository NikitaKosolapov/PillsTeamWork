//
//  RateViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import UIKit

class RateViewController: BaseViewController<RateView> {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.rateViewDelegate = self
    }
}

// MARK: - RateViewDelegate
extension RateViewController: RateViewDelegate {
    
    // MARK: - Actions
    func badSmileButtonTouchUpInside() {
    }
    
    func normSmileButtonTouchUpInside() {
    }
    
    func bestSmileButtonTouchUpInside() {
    }
    
    func provideFeedbackButtonTouchUpInside() {
        dismiss(animated: false)
    }
    
    @objc  func noThanksButtonTouchUpInside() {
        self.dismiss(animated: false) {
        }
    }
}
