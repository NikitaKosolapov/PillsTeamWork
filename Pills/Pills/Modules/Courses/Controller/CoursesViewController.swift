//
//  CoursesViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

class CoursesViewController: UIViewController {
    // MARK: - Public properties
    var coursesCurrent: [Course]?
    var coursesPassed: [Course]?
    var courses: [Course]?
    var switcher = false
    
    // MARK: - Private properties
    internal var coursesView: CoursesView {
        return view as! CoursesView
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Text.AidKit.active, Text.AidKit.completed])
        segmentedControl.addTarget(self, action: #selector(changeTypeCourses), for: .valueChanged)
        segmentedControl.setWidth(AppLayout.AidKit.widthSegment, forSegmentAt: 0)
        segmentedControl.setWidth(AppLayout.AidKit.widthSegment, forSegmentAt: 1)
        segmentedControl.selectedSegmentTintColor = AppColors.AidKit.segmentActive
        segmentedControl.backgroundColor = AppColors.AidKit.segmentNoActive
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.AidKit.segmentTextActive], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.AidKit.segmentTextNoActive], for: .normal)
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.shadowOffset = CGSize(width: 0, height: 0)
        segmentedControl.layer.shadowColor = UIColor.red.cgColor
        segmentedControl.layer.shadowOpacity = 1
        segmentedControl.layer.shadowRadius = 50
        return segmentedControl
    }()
    
    private struct Constant {
        static let reuseIdentifier = "reuseId"
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
        configureTableView()
        configureAddButton()
    }
    
    private func configureMocData () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let startDate = dateFormatter.date(from: "01.01.2021")!
        let endDate = dateFormatter.date(from: "01.09.2022")!
        let firstCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Valium",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let secondCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Gydroxizin",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let thirdCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let coursesCurrent = [firstCurrentCourse, secondCurrentCourse, thirdCurrentCourse]
        self.coursesCurrent = coursesCurrent
        let firstPassedCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let secondPassedCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Donormil",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let coursesPassed = [firstPassedCourse, secondPassedCourse]
        self.coursesPassed = coursesPassed
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.backgroundColor = AppColors.AidKit.background
        navigationItem.titleView = segmentedControl
    }
    
    private func configureTableView () {
        coursesView.tableView.register(CourseCell.self, forCellReuseIdentifier: Constant.reuseIdentifier)
        coursesView.tableView.delegate = self
        coursesView.tableView.dataSource = self
    }
    
    private func configureAddButton () {
        coursesView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Private functions
    @objc private func changeTypeCourses() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            courses = coursesCurrent
        case 1:
            courses = coursesPassed
        default:
            break
        }
        coursesView.tableView.reloadData()
    }
    
    private func hideTableView() {
        coursesView.tableView.isHidden = true
        coursesView.stubView.isHidden = false
    }
    
    private func hideStubView() {
        coursesView.tableView.isHidden = false
        coursesView.stubView.isHidden = true
    }
    
    // MARK: Actions
    @objc private func addButtonTouchUpInside() {
        switcher.toggle()
        if switcher {
            coursesCurrent = []
            coursesPassed = []
            changeTypeCourses()
        } else {
            configureMocData()
            changeTypeCourses()
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
            hideTableView()
            return 0 }
        hideStubView()
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell =  tableView.dequeueReusableCell(withIdentifier: Constant.reuseIdentifier, for: indexPath)
        guard let cell = dequeueCell as? CourseCell,
              let course = courses?[indexPath.row] else {
            return dequeueCell
        }
        let courseModel = CourseCellModelFactory.cellModel(from: course)
        cell.configure(with: courseModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoursesViewController: UITableViewDelegate {
}
