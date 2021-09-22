//
//  DeletePillView.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 22.09.2021.
//

import UIKit

final class DeletePillView: AlertView {
    
    // MARK: - Private Properties
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: ""
        )
        return label
    }()

    // MARK: - Private Methods
    
    private func configureDescription() {

    }
    
    override func configureAlert(alertType: AlertView.AlertType, title: String, agree: String, deny: String) {

    }

}
