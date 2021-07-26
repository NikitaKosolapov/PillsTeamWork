//
//  ViewController.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit

class DevelopmentViewController: UIViewController {
    
    var router: DevelopmentRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

extension DevelopmentViewController {
    // TODO: remove me when all controllers got ready
    static var bgColors: [UIColor] = [.red, .green, .blue, .black]

    func configure() {
        
        // TODO: remove me when all controllers got ready
        view.backgroundColor = DevelopmentViewController.bgColors.first ?? .yellow
        DevelopmentViewController.bgColors.removeFirst()

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
