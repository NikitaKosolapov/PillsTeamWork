//
//  MedicineDescriptionVC.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 14.09.2021.
//

import UIKit

/// Class displays description card of the tapped medicine
final class MedicineDescriptionVC: BaseViewController<MedicineDescriptionView> {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.medicineDescriptionDelegate = self
    }
}

extension MedicineDescriptionVC: MedicineDescriptionViewDelegate {
    func acceptButtonTapped() {
        // TODO: Add logic for accept button
    }
    
    func skipButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
