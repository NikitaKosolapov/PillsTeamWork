//
//  CoursesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

class CoursesView: UIView {
// MARK: - Subviews
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 251/255, alpha: 1)
        configureCollectionView()
        setupConstraints()
    }
    private func configureCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        //collectionViewLayout.estimatedItemSize = CGSize(width: 3*UIScreen.main.bounds.width/7, height: 500)
        collectionViewLayout.itemSize = CGSize(width: 4*UIScreen.main.bounds.width/9, height: 210)
        collectionViewLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.contentInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 251/255, alpha: 1)
        collectionView.backgroundColor = .gray
        collectionView.isHidden = false
        addSubview(collectionView)
    }
    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
