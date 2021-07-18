//
//  ViewController.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit

class DevelopmentViewController: UIViewController {
    
    private var router: DevelopmentRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

extension DevelopmentViewController {
    func configure() {
        router = DevelopmentRouter(vc: self)
        
        view.backgroundColor = .red
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
