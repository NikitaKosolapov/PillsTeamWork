//
//  JournalTableView.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit

class JournalTableView: UITableView {

    func configure() {
        self.tableFooterView = UIView()
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.bounces = false

        register(JournalTableViewCell.self, forCellReuseIdentifier: "JournalCell")
        rowHeight = AppLayout.Journal.cellHeight
    }

}
