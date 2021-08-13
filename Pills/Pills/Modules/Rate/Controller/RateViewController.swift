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
    internal func badSmileButtonTouchUpInside() {
    }
    
    internal func normSmileButtonTouchUpInside() {
    }
    
    internal func bestSmileButtonTouchUpInside() {
    }
    
    internal func provideFeedbackButtonTouchUpInside() {
    }
    
    @objc internal func noThanksButtonTouchUpInside() {
        self.dismiss(animated: true, completion: nil)
    }
}
