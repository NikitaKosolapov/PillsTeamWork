//
//  DeletePillViewController.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 22.09.2021.
//

import UIKit
import RealmSwift

class DeletePillViewController: BaseViewController<DeletePillView> {
    
    weak var delegate: DeleteCoursesByIndexPath?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.deletePillViewDelegate = self
    }
}

extension DeletePillViewController: DeletePillViewDelegate {
    
    func deleteButtonTouchUpInside() {
        delegate?.deleteRowAt()
        dismiss(animated: false)
    }
    
    func cancelButtonTouchUpInside() {
        dismiss(animated: false)
    }
}
