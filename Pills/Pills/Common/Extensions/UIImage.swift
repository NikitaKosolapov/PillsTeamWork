//
//  UIImage.swift
//  Pills
//
//  Created by Mac on 19.09.2021.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) {
            let rect = CGRect(origin: .zero, size: size)
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            color.setFill()
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let cgImage = image?.cgImage else { return nil }
            self.init(cgImage: cgImage)
        }
}
