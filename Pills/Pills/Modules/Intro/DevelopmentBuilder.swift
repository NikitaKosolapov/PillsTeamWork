//
//  DevelopmentBuilder.swift
//  Pills
//
//  Created by Andrey on 24/07/2021.
//

import UIKit

class DevelopmentBuilder {
    static func build() -> DevelopmentViewController {
        let viewController = DevelopmentViewController()
        let router = DevelopmentRouter(viewController: viewController)
        viewController.router = router
        return viewController
    }
}
