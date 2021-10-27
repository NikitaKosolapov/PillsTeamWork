//
//  CoursesViewController.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

protocol DeleteCoursesByIndexPath: AnyObject {
    func deleteRowAt()
}

protocol CompleteCoursesByIndexPath: AnyObject {
    func completeRowAt()
}

final class CoursesViewController: BaseViewController<CoursesView> {
    
    // MARK: - Public Properties
    var typeOfCourse: TypeOfCourse = .current
    var switcher = false
    private var event: Event?
    var indexRow = 0
    var coursesCurrent: [Course] = [] {
        didSet {
            if typeOfCourse == .current {
                setSourceOfCourses()
            }
        }
    }
    
    var coursesPassed: [Course] = [] {
        didSet {
            if typeOfCourse == .passed {
                setSourceOfCourses()
            }
        }
    }
    
    var courses: [Course]? = [] {
        didSet {
            rootView.coursesTableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeTypeCourses()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        navigationController?.navigationBar.backgroundColor = AppColors.white
    }
    
    private func configureSegmentedControl () {
        rootView.segmentedControl.addTarget(self, action: #selector(changeTypeCourses), for: .valueChanged)
    }
    
    private func configureTableView () {
        rootView.coursesTableView.register(CourseCell.self)
        rootView.coursesTableView.delegate = self
        rootView.coursesTableView.dataSource = self
    }
    
    private func configureAddButton () {
        rootView.addButton.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    private func setTypeOfCourse() {
        switch rootView.segmentedControl.selectedSegmentIndex {
        case 0:
            typeOfCourse = .current
            disableAndEnableButtons()
        case 1:
            typeOfCourse = .passed
            disableAndEnableButtons()
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
        rootView.coursesTableView.isHidden = true
        rootView.coursesStubView.isHidden = false
    }
    
    private func showTableView() {
        rootView.coursesTableView.isHidden = false
        rootView.coursesStubView.isHidden = true
    }
    
    private func disableAndEnableButtons() {
        rootView.addButton.isHidden = false
        rootView.repeatButton.isHidden = true
        rootView.deleteButton.isHidden = true
        rootView.editButton.isHidden = true
        rootView.completeButton.isHidden = true
    }
    
    private func configureOfButtonsFromSegmented() {
        rootView.addButton.isHidden = true
        
        if typeOfCourse == .current {
            
            rootView.editButton.setButtonStyle(backgroundColor: AppColors.blue,
                                               text: Text.edit, font: AppLayout.Fonts.normalSemibold)
            rootView.editButton.setTitleColor(AppColors.whiteOnly, for: .normal)
            rootView.editButton.isHidden = false
            rootView.editButton.addTarget(self, action: #selector(showEditCourse), for: .touchUpInside)
            
            rootView.completeButton.setButtonStyle(backgroundColor: AppColors.red,
                                                   text: Text.complete, font: AppLayout.Fonts.normalSemibold)
            rootView.completeButton.setTitleColor(AppColors.whiteOnly, for: .normal)
            rootView.completeButton.isHidden = false
            rootView.completeButton.addTarget(self, action: #selector(completePillAlert), for: .touchUpInside)
            
        } else if typeOfCourse == .passed {
            
            rootView.repeatButton.setButtonStyle(backgroundColor: AppColors.blue,
                                                 text: Text.repeating, font: AppLayout.Fonts.normalSemibold)
            rootView.repeatButton.setTitleColor(AppColors.whiteOnly, for: .normal)
            rootView.repeatButton.isHidden = false
            rootView.repeatButton.addTarget(self, action: #selector(showAddNewCourse), for: .touchUpInside)
            
            rootView.deleteButton.setButtonStyle(backgroundColor: AppColors.red,
                                                 text: Text.delete, font: AppLayout.Fonts.normalSemibold)
            rootView.deleteButton.setTitleColor(AppColors.whiteOnly, for: .normal)
            rootView.deleteButton.isHidden = false
            rootView.deleteButton.addTarget(self, action: #selector(deletePillAlert), for: .touchUpInside)
        }
    }
    
    // MARK: - Actions
    
    @objc private func showEditCourse(_ sender: UIButton) {
        let addNewCourseViewControler = AddNewCourseViewController()
        addNewCourseViewControler.tagOfNavBar = Text.tagNavBar
        addNewCourseViewControler.rootView.setPillName(coursesCurrent[indexRow].namePill)
        addNewCourseViewControler.rootView.setStartDate(coursesCurrent[indexRow].dateStartOfCourse)
        addNewCourseViewControler.rootView.typeImage.image = coursesCurrent[indexRow].imagePill
        self.navigationController?.pushViewController(addNewCourseViewControler, animated: true)
        disableAndEnableButtons()
    }
    
    @objc private func completePillAlert(_ sender: UIButton) {
        let completePillViewController = CompletePillViewController()
        completePillViewController.delegate = self
        completePillViewController.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(completePillViewController, animated: false)
        disableAndEnableButtons()
    }
    
    @objc private func deletePillAlert(_ sender: UIButton) {
        let deletePillViewController = DeletePillViewController()
        deletePillViewController.delegate = self
        deletePillViewController.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(deletePillViewController, animated: false)
        disableAndEnableButtons()
    }
    
    @objc private func showAddNewCourse(_ sender: UIButton) {
        let addNewCourseViewController = AddNewCourseViewController()
        addNewCourseViewController.rootView.setPillName(coursesPassed[indexRow].namePill)
        addNewCourseViewController.rootView.setStartDate(coursesPassed[indexRow].dateStartOfCourse)
        addNewCourseViewController.rootView.typeImage.image = coursesPassed[indexRow].imagePill
        self.navigationController?.pushViewController(addNewCourseViewController, animated: true)
        disableAndEnableButtons()
    }
    
    @objc private func changeTypeCourses() {
        setTypeOfCourse()
        setSourceOfCourses()
    }
    
    @objc private func addButtonTouchUpInside() {
        // let rateViewController = RateViewController()
        // rateViewController.modalPresentationStyle = .overCurrentContext
        // present(rateViewController, animated: true, completion: nil)
        
        // TODO: - You should present a addPillsController
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CourseCell
        
        if cell.courseCellView.layer.borderColor == AppColors.blue.cgColor {
            cell.courseCellView.layer.borderColor = UIColor.clear.cgColor
            disableAndEnableButtons()
        } else {
            cell.courseCellView.layer.borderWidth = 1
            cell.courseCellView.layer.borderColor = AppColors.blue.cgColor
            indexRow = indexPath.row
            configureOfButtonsFromSegmented()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CourseCell
        cell.courseCellView.layer.borderColor = UIColor.clear.cgColor
        cell.progressView.layer.borderColor = UIColor.clear.cgColor
    }
}

extension CoursesViewController: DeleteCoursesByIndexPath, CompleteCoursesByIndexPath {
    func completeRowAt() {
        coursesPassed.append(coursesCurrent[indexRow])
        coursesCurrent.remove(at: indexRow)
        rootView.coursesTableView.reloadData()
    }
    
    func deleteRowAt() {
        coursesPassed.remove(at: indexRow)
        rootView.coursesTableView.reloadData()
    }
}
