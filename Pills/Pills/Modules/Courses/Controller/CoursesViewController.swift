//
//  CoursesViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

class CoursesViewController: BaseViewController<CoursesView> {
    
    // MARK: - Public properties
    var typeOfCourse: TypeOfCourse = .current
    var coursesCurrent: [Course]? = [] {
        didSet {
            if typeOfCourse == .current {
                setSourceOfCourses()
            }
        }
    }
    var coursesPassed: [Course]? = [] {
        didSet {
            if typeOfCourse == .passed {
                setSourceOfCourses()
            }
        }
    }
    var courses: [Course]? = [] {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    var switcher = false

    // MARK: - Initialisation
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeTypeCourses()
    }
    
    // MARK: - ConfigureUI
    private func configure () {
        configureMocData()
        configNavigationBar()
        configureSegmentedControl()
        configureTableView()
        configureAddButton()
    }
    
    private func configureMocData () {
        self.coursesCurrent = []
        self.coursesPassed = CourseMock.shared.coursesPassed
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = AppColors.AidKit.background
    }
    
    private func configureSegmentedControl () {
        rootView.segmentedControl.addTarget(self, action: #selector(changeTypeCourses), for: .valueChanged)
    }
    
    private func configureTableView () {
        rootView.tableView.register(CourseCell.self)
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func configureAddButton () {
        rootView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Private functions
    private func setTypeOfCourse() {
        switch rootView.segmentedControl.selectedSegmentIndex {
        case 0:
            typeOfCourse = .current
        case 1:
            typeOfCourse = .passed
        default:
            break
        }
    }
    
    private func setSourceOfCourses() {
        switch typeOfCourse {
        case .current:
            courses = coursesCurrent
        case .passed:
            courses = coursesPassed
        }
    }
    
    private func showStubView() {
        rootView.tableView.isHidden = true
        rootView.stubView.isHidden = false
    }
    
    private func showTableView() {
        rootView.tableView.isHidden = false
        rootView.stubView.isHidden = true
    }
    
    // MARK: Actions
    @objc private func changeTypeCourses() {
        setTypeOfCourse()
        setSourceOfCourses()
    }
    
    @objc private func addButtonTouchUpInside() {
        let rateViewController = RateViewController()
        rateViewController.modalPresentationStyle = .overCurrentContext
        present(rateViewController, animated: true, completion: nil)
        
        //TODO: - You should present a addPillsController
        
        //        switcher.toggle()
        //        if switcher {
        //            coursesCurrent = []
        //            coursesPassed = []
        //        } else {
        //            configureMocData()
        //        }
    }
}
// MARK: - UICollectionViewDataSource
extension CoursesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = courses?.count,
              let empty = courses?.isEmpty,
              empty == false else {
            showStubView()
            return 0 }
        showTableView()
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(ofType: CourseCell.self, for: indexPath)
        guard let course = courses?[indexPath.row] else {
            return dequeueCell
        }
        let courseModel = CourseViewModelFactory.cellModel(from: course)
        dequeueCell.configure(with: courseModel)
        return dequeueCell
    }
}

// MARK: - UITableViewDelegate
extension CoursesViewController: UITableViewDelegate {
}
