//
//  HomeCollectionCell.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class HomeCollectionCell: UICollectionViewCell {
    static let identifier = "HomeCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Godfather"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .init(hex: "FBC311")
        imageView.image = .init(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "7.8 / 10 IMDB"
        label.textColor = .init(hex: "A3A3A3")
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.backgroundColor = .init(hex: "FBFCFE")
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "E9E9E9")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.layer.cornerRadius = 6
        movieImageView.layer.masksToBounds = true
    }
    
    private func configureCell() {
        setupViews()
        setDelegates()
    }
    
    private func setDelegates() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure CollectionView
extension HomeCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / 3) - 30
        let cellHeight = (collectionView.frame.height / 2) - 10
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

//MARK: - AddSubviews / Constraints
extension HomeCollectionCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FBFCFE")
        
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        addSubview(genreCollectionView)
        addSubview(seperatorView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 0.6),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            ratingStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: ratingLabel.font.lineHeight),
            
            genreCollectionView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 10),
            genreCollectionView.leadingAnchor.constraint(equalTo: ratingStackView.leadingAnchor),
            genreCollectionView.trailingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor),
            genreCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            seperatorView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 15),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
