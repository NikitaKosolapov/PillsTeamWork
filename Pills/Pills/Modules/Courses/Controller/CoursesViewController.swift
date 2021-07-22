//
//  CoursesViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

enum TypeCourses {
    case current
    case passed
}

class CoursesViewController: UIViewController {
    // MARK: - Public properties
    var coursesCurrent: [Course]?
    var coursesPassed: [Course]?
    var courses: [Course]?
    
    // MARK: - Private properties
    internal var coursesView: CoursesView {
        return view as! CoursesView
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Text.AidKit.active, Text.AidKit.completed])
        segmentedControl.addTarget(self, action: #selector(changeTypeCourses), for: .valueChanged)
        segmentedControl.setWidth(AppLayout.AidKit.paddingSegmentControl*UIScreen.main.bounds.width, forSegmentAt: 0)
        segmentedControl.setWidth(AppLayout.AidKit.paddingSegmentControl*UIScreen.main.bounds.width, forSegmentAt: 1)
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private var typeCourses: TypeCourses = .current
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
        changeSource()
    }
    
    // MARK: - ConfigureUI
    private func configure () {
        configureMocData()
        configNavigationBar()
        configureCollectionView()
    }
    
    private func configureMocData () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let startDate = dateFormatter.date(from: "01.02.2021")!
        let endDate = dateFormatter.date(from: "02.03.2022")!
        let firstCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Valium",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate,
            countOfCourseDoses: 360,
            countOfDosesPassed: 30,
            typeOfDose: "mg")
        let secondCurrentCourse = Course(
            imagePill: AppImages.Pills.capsules ?? UIImage(),
            namePill: "Gydroxizin",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate,
            countOfCourseDoses: 90,
            countOfDosesPassed: 60,
            typeOfDose: "Piece")
        let thirdCurrentCourse = Course(
            imagePill: AppImages.Pills.suspension ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate,
            countOfCourseDoses: 89,
            countOfDosesPassed: 45,
            typeOfDose: "mg")
        let coursesCurrent = [firstCurrentCourse, secondCurrentCourse, thirdCurrentCourse]
        self.coursesCurrent = coursesCurrent
        let firstPassedCourse = Course(
            imagePill: AppImages.Pills.capsules ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate,
            countOfCourseDoses: 89,
            countOfDosesPassed: 45,
            typeOfDose: "mg")
        let secondPassedCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Donormil",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate,
            countOfCourseDoses: 360,
            countOfDosesPassed: 30,
            typeOfDose: "mg")
        let coursesPassed = [firstPassedCourse, secondPassedCourse]
        self.coursesPassed = coursesPassed
    }
    
    private func configNavigationBar() {
        navigationItem.titleView = segmentedControl
    }
    
    private func configureCollectionView () {
        coursesView.collectionView.register(CourseCell.self, forCellWithReuseIdentifier: Constant.reuseIdentifier)
        coursesView.collectionView.delegate = self
        coursesView.collectionView.dataSource = self
    }
    
    // MARK: - Private functions
    @objc private func changeTypeCourses() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            typeCourses = .current
        case 1:
            typeCourses = .passed
        default:
            break
        }
        self.changeSource()
    }
    
    private func changeSource() {
        switch typeCourses {
        case .current:
            courses = coursesCurrent
        case .passed:
            courses = coursesPassed
        }
        coursesView.collectionView.reloadData()
    }
}
// MARK: - UICollectionViewDataSource
extension CoursesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = courses?.count else {
            return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeueCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reuseIdentifier, for: indexPath)
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
extension CoursesViewController: UICollectionViewDelegate {
}
