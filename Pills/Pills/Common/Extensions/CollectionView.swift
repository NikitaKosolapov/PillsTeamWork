//
//  CollectionView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import Foundation
import UIKit
extension UICollectionViewCell: AutoReusable {
}

extension UICollectionView {
    func register <T: UITableViewCell> (_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: T.autoReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType: T.Type, index indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.autoReuseIdentifier, for: indexPath) as! T
    }
}
