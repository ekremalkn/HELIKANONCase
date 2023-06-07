//
//  HomeCollectionHeaderView.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class HomeCollectionHeaderView: UICollectionReusableView {
    static let identifier = "HomeCollectionHeaderView"
    
    private lazy var topCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Now Playing"
        label.textColor = .init(hex: "16143E")
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .init(hex: "FBFCFE")
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var bottomCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex: "16143E")
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = "Popular"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderView() {
        setupViews()
        setDelegates()
    }
    
    private func setDelegates() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure CollectionView
extension HomeCollectionHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width / 2) - 20
        let cellHeight: CGFloat = collectionView.frame.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
   
}


//MARK: - AddSubviews / Constraints
extension HomeCollectionHeaderView {
    private func setupViews() {
        addSubview(topCategoryLabel)
        addSubview(bottomCategoryLabel)
        addSubview(horizontalCollectionView)
        
        NSLayoutConstraint.activate([
            topCategoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topCategoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topCategoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            topCategoryLabel.heightAnchor.constraint(equalToConstant: topCategoryLabel.font.lineHeight),
            
            bottomCategoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            bottomCategoryLabel.heightAnchor.constraint(equalToConstant: bottomCategoryLabel.font.lineHeight),
            bottomCategoryLabel.trailingAnchor.constraint(equalTo: topCategoryLabel.trailingAnchor),
            bottomCategoryLabel.leadingAnchor.constraint(equalTo: topCategoryLabel.leadingAnchor),
            
            horizontalCollectionView.topAnchor.constraint(equalTo: topCategoryLabel.bottomAnchor, constant: 10),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: bottomCategoryLabel.topAnchor, constant: -15)
        ])
    }
}
