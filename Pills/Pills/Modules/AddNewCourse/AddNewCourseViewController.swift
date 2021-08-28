//
//  AddNewCourseViewController.swift
//  Pills
//
//  Created by aprirez on 8/4/21.
//

import UIKit
import DropDown

class AddNewCourseViewController: BaseViewController<AddNewCourseView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = AppColors.addNewCourseBackgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "\(Text.newPill)"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
}
