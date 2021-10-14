//
//  JournalViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit

final class JournalViewController: BaseViewController<JournalView> {
    
    fileprivate var eventsToShow: [Event] = []
    fileprivate var filteredEvents: [Event] = []
            
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
        eventsToShow = []
        for entry in journalEntries {
            for event in entry.schedule {
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
        setBarButton()
        getDates(from: filteredEvents)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: После реализации сохранения модели в БД
        // он должен вызываться в viewWillAppear  journalEntries = RealmService.shared.get(RealmMedKitEntry.self)
        prepareDataForDay(Date())
        rootView.delegate = self
        rootView.configure(tableDataSource: self)
        rootView.journalTableView.dataSource = self
        rootView.journalTableView.delegate = self
        filterEventsByDate(date: Date().startOfDay)
    }
    
    @objc func addNewCourseButtonAction(sender: UIButton!) {
        let addNewCourseViewController = AddNewCourseViewController()
        addNewCourseViewController.modalPresentationStyle = .pageSheet
        self.present(addNewCourseViewController, animated: true)
    }
}

// MARK: - JournalEventsDelegate

extension JournalViewController: JournalEventsDelegate {
    
    func filterEventsByDate(date: Date) {
        filteredEvents = eventsToShow.filter { $0.time == date }
        rootView.journalTableView.reloadData()
    }
    
    func addNewPill() {
        let addNewCourseViewController = AddNewCourseViewController()
        self.navigationController?.pushViewController(addNewCourseViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension JournalViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
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
        cell.configure(model: filteredEvents[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableViewDelegate

extension JournalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let event = filteredEvents[indexPath.row]
        
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

extension JournalViewController {
    func getDates(from events: [Event]) {
        eventsToShow.forEach { rootView.arrayOfEvents.append($0.time) }
    }
    
    func setBarButton() {
        let attributes = [NSAttributedString.Key.font : AppLayout.Fonts.normalRegular as Any]
        if #available(iOS 15.0, *) {
            let navigationAppearance = UINavigationBarAppearance()
            navigationAppearance.configureWithDefaultBackground()
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = attributes
            buttonAppearance.highlighted.titleTextAttributes = attributes
            navigationAppearance.buttonAppearance = buttonAppearance

            let appearance = UINavigationBar.appearance()
            appearance.standardAppearance = navigationAppearance
            appearance.scrollEdgeAppearance = navigationAppearance
        } else {
            let appearance = UIBarButtonItem.appearance()
            appearance.setTitleTextAttributes(attributes, for: .normal)
            appearance.setTitleTextAttributes(attributes, for: .highlighted)
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "\(Text.Tabs.journal)", style: .plain, target: nil, action: nil)
    }
}
