//
//  CoursesViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

enum TypeOfCourse {
    case current
    case passed
}

class CoursesViewController: UIViewController {
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
            coursesView.tableView.reloadData()
        }
    }
    var switcher = false
    
    // MARK: - Private properties
    internal var coursesView: CoursesView {
        return view as! CoursesView
    }
    
    private struct Constant {
        static let reuseCourseTableCellIdentifier = "reuseCourseTableCellId"
    }
    
    // MARK: - Initialisation
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override func loadView() {
        view = CoursesView()
    }
    
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
        self.coursesCurrent = CourseMock.shared.coursesCurrent
        self.coursesPassed = CourseMock.shared.coursesPassed
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = AppColors.AidKit.background
    }
    
    private func configureSegmentedControl () {
        coursesView.segmentedControl.addTarget(self, action: #selector(changeTypeCourses), for: .valueChanged)
    }
    
    private func configureTableView () {
        coursesView.tableView.register(CourseCell.self, forCellReuseIdentifier: Constant.reuseCourseTableCellIdentifier)
        coursesView.tableView.delegate = self
        coursesView.tableView.dataSource = self
    }
    
    private func configureAddButton () {
        coursesView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Private functions
    private func setTypeOfCourse() {
        switch coursesView.segmentedControl.selectedSegmentIndex {
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
        coursesView.tableView.isHidden = true
        coursesView.stubView.isHidden = false
    }
    
    private func showTableView() {
        coursesView.tableView.isHidden = false
        coursesView.stubView.isHidden = true
    }
    
    // MARK: Actions
    @objc private func changeTypeCourses() {
        setTypeOfCourse()
        setSourceOfCourses()
    }
    
    @objc private func addButtonTouchUpInside() {
        switcher.toggle()
        if switcher {
            coursesCurrent = []
            coursesPassed = []
        } else {
            configureMocData()
        }
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
        let dequeueCell =  tableView.dequeueReusableCell(withIdentifier: Constant.reuseCourseTableCellIdentifier,
                                                         for: indexPath)
        guard let cell = dequeueCell as? CourseCell,
              let course = courses?[indexPath.row] else {
            return dequeueCell
        }
        let courseModel = CourseViewModelFactory.cellModel(from: course)
        cell.configure(with: courseModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoursesViewController: UITableViewDelegate {
}
