//
//  MedicineDescriptionVC.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 14.09.2021.
//

import UIKit

protocol MedicineDescriptionVCDelegate: AnyObject {
    func update(index: IndexPath)
}

/// Class displays description card of the tapped medicine
final class MedicineDescriptionVC: BaseViewController<MedicineDescriptionView> {
    
    // MARK: - Private Properties
    
    private var realm = RealmService.shared
    private weak var delegate: MedicineDescriptionVCDelegate?
    private var event: Event?
    private var index: IndexPath
    
    // MARK: - Initializers
    
    init(
        index: IndexPath,
        subscriber: MedicineDescriptionVCDelegate?,
        event: Event
    ) {
        self.index = index
        self.event = event
        self.delegate = subscriber
        super.init(nibName: nil, bundle: nil)
        rootView.set(with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.medicineDescriptionDelegate = self
    }
}

extension MedicineDescriptionVC: MedicineDescriptionViewDelegate {
    
    func onMedicineDescriptionViewTapped() {
        dismiss(animated: false)
    }
    
    func acceptButtonTapped() {
        realm.update {
            event?.pill.schedule.first?.acceptedType = .used
        }
        delegate?.update(index: index)
        dismiss(animated: false, completion: nil)
    }
    
    func skipButtonTapped() {
        realm.update {
            event?.pill.schedule.first?.acceptedType = .unused
        }
        delegate?.update(index: index)
        dismiss(animated: false, completion: nil)
    }
}
