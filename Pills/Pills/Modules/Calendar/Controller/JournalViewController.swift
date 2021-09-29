//
//  JournalViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit

final class JournalViewController: BaseViewController<JournalView> {
    
    fileprivate var eventsToShow: [Event] = []

    // MARK: - MOCK DATA
    var journalEntries: [RealmMedKitEntry] = [
        JournalMock.shared.entryExample1,
        JournalMock.shared.entryExample2
    ] {
        didSet {
            prepareDataForDay()
        }
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
    
    // ---------------------------------------------------------
    // MARK: - Controller logic
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "\(Text.Tabs.journal)", style: .plain, target: nil, action: nil)
        rootView.updateBGColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: После реализации сохранения модели в БД
//        journalEntries = RealmService.shared.get(RealmMedKitEntry.self)
        prepareDataForDay(Date())
        rootView.delegate = self
        rootView.configure(tableDataSource: self)
        rootView.journalTableView.dataSource = self
        rootView.journalTableView.delegate = self
    }
    
    @objc func addNewCourseButtonAction(sender: UIButton!) {
        let addNewCourseViewController = AddNewCourseViewController()
        addNewCourseViewController.modalPresentationStyle = .pageSheet
        self.present(addNewCourseViewController, animated: true)
    }
}

// MARK: - JournalEventsDelegate

extension JournalViewController: JournalEventsDelegate {
    func addNewPill() {
        let addNewCourseViewController = AddNewCourseViewController()
        self.navigationController?.pushViewController(addNewCourseViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension JournalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(
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

// MARK: - UITableViewDelegate

extension JournalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let event = eventsToShow[indexPath.row]
        
        let destinationVC = MedicineDescriptionVC(index: indexPath, subscriber: self, event: event)
        destinationVC.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(destinationVC, animated: false, completion: nil)
    }
}

// MARK: - MedicineDescriptionVCDelegate

extension JournalViewController: MedicineDescriptionVCDelegate {
    func update(index: IndexPath) {
        rootView.journalTableView.reloadRows(at: [index], with: .automatic)
    }
}
