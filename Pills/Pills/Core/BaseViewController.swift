//
//  BaseViewController.swift
//  Pills
//
//  Created by Andrey on 08/08/2021.
//

import UIKit

class BaseViewController<ViewType: UIView>: UIViewController {
    var rootView: ViewType {
        self.view as! ViewType
    }
    
    override func loadView() {
        self.view = ViewType()
    }
}
