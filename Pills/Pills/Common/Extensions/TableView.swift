//
//  TableView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import Foundation
import UIKit

extension UITableViewCell: AutoReusable {
}

extension UITableView {
    func register <T: UITableViewCell> (_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.autoReuseIdentifier)
    }
    
    func dequeueReusableCell <T: UITableViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.autoReuseIdentifier, for: indexPath) as! T
    }
}
