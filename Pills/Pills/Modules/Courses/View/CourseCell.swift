//
//  CoursesCell.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit
import SnapKit

/// Class contains UI elements for a cell
final class CourseCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var courseCellView: CourseCellView = {
        let view = CourseCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with model: CourseViewModel) {
        courseCellView.configure(with: model)
        progressView.configure(with: model)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.white
        contentView.backgroundColor = AppColors.white
    }
    
    private func addSubviews() {
        contentView.addSubview(progressView)
        contentView.addSubview(courseCellView)
    }
    
    private func setupLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(
                AppLayout.AidKit.widthIndentBetweenCells + AppLayout.AidKit.heightVisiblePartOfProgressView
            )
            $0.leading.equalTo(safeArea.snp.leading)
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
        
        courseCellView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(AppLayout.AidKit.widthIndentBetweenCells)
            $0.leading.equalTo(safeArea.snp.leading)
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.bottom.equalTo(progressView.safeAreaLayoutGuide.snp.bottom)
                .offset(-AppLayout.AidKit.heightVisiblePartOfProgressView)
        }
    }
    
}
