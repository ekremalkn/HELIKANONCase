//
//  HomeView.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class HomeView: UIView {

    //MARK: - Creating UI Elements
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier)
        collection.register(HomeCollectionCell.self, forCellWithReuseIdentifier: HomeCollectionCell.identifier)
        collection.backgroundColor = .init(hex: "FBFCFE")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension HomeView {
    
    private func setupViews() {
        backgroundColor = .init(hex: "FBFCFE")
        addSubview(homeCollectionView)

        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
