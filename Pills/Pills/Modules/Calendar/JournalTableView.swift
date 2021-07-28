//
//  JournalTableView.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit

class JournalTableView: UITableView {

    class Event {
        let time: Date
        let pill: RealmMedKitEntry

        init(time: Date, pill: RealmMedKitEntry) {
            self.time = time
            self.pill = pill
        }
    }

    fileprivate var eventsToShow: [Event] = []

    var journalEntries: [RealmMedKitEntry] = [
        JournalMock.shared.entryExample1,
        JournalMock.shared.entryExample2
    ] {
        didSet {
            prepareDataForDay()
        }
    }

    func configure(_ forDate: Date = Date()) {
        self.tableFooterView = UIView()
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.dataSource = self
        self.delegate = self
        register(JournalTableViewCell.self, forCellReuseIdentifier: "JournalCell")
        rowHeight = JournalTableViewCell.CellTheme.cellHeight
        prepareDataForDay(forDate)
    }

    func prepareDataForDay(_ forDate: Date = Date()) {
        let selectedDate = forDate.startOfDay
        eventsToShow = []
        for entry in journalEntries {
            for event in entry.schedule where event.time.startOfDay == selectedDate {
                eventsToShow.append(Event(time: event.time, pill: entry))
            }
        }
        eventsToShow.sort { (event1, event2) -> Bool in
            return event1.time < event2.time ? true : false
        }
    }
}

extension JournalTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                dequeueReusableCell(
                    withIdentifier: "JournalCell",
                    for: indexPath
                ) as? JournalTableViewCell
        else {
            return UITableViewCell()
        }

        cell.configure(model: eventsToShow[indexPath.row])

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
