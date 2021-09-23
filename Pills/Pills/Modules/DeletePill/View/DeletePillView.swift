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
        label.centerMultilineLabel(
            font: AppLayout.Fonts.smallRegular,
            text: "После удаления курс нельзя будет восстановить."
        )
        return label
    }()

    // MARK: - Private Methods

    override func configureView() {
        configureHeight(height: AppLayout.DeletePill.heightView)
        additionalField = descriptionLabel
        configureText(title: "Удалить", agree: "Отменить", deny: "Удалить")
        // MARK: To do: add delete pills texts to Text.swift
    }

}
