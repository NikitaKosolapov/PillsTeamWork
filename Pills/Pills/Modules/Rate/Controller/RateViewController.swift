//
//  RateViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import UIKit

class RateViewController: UIViewController {
    // MARK: - Properties
    private var rateView: RateView {
        return view as! RateView
    }
    // MARK: - Life cycle
    override func loadView() {
        let rateView = RateView()
        self.view = rateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure
    private func configureUI() {
        configureRateView()
    }
    
    private func configureRateView() {
        rateView.badSmileButton.addTarget(self, action: #selector(badSmileButtonTouchUpInside), for: .touchUpInside)
        rateView.normSmileButton.addTarget(self, action: #selector(normSmileButtonTouchUpInside), for: .touchUpInside)
        rateView.bestSmileButton.addTarget(self, action: #selector(bestSmileButtonTouchUpInside), for: .touchUpInside)
        rateView.provideFeedbackButton.addTarget(self, action: #selector(provideFeedbackButtonTouchUpInside),
                                                 for: .touchUpInside)
        rateView.noThanksButton.addTarget(self, action: #selector(noThanksButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func badSmileButtonTouchUpInside() {
        
    }
    
    @objc private func normSmileButtonTouchUpInside() {
        
    }
    
    @objc private func bestSmileButtonTouchUpInside() {
        
    }
    
    @objc private func provideFeedbackButtonTouchUpInside() {
        
    }
    
    @objc private func noThanksButtonTouchUpInside() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
