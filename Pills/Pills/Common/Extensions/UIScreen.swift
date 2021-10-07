//
//  UIScreen.swift
//  Pills
//
//  Created by Nikita on 07.10.2021.
//

import UIKit

extension UIScreen {
    var safeAreaBottom: CGFloat {
        guard let rootView = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return 0 }
        return rootView.safeAreaInsets.bottom
    }

    var safeAreaTop: CGFloat {
        guard let rootView = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return 20 }
        return rootView.safeAreaInsets.top == 0 ? 20 : rootView.safeAreaInsets.top
    }
}
