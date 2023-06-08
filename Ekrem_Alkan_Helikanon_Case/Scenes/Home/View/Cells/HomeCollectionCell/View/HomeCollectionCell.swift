//
//  HomeCollectionCell.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

protocol HomeCollectionCellDataProtocol where Self: Decodable {
    var homeCCImage: String { get }
    var homeCCTitle: String { get }
    var homeCCRating: String { get }
    var homeCCgenres: [Int] { get }
}

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
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.backgroundColor = .init(hex: "FFFFFF")
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "A3A3A3")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Variables
    var genreIDs: [Int] = [] {
        didSet {
            genreCollectionView.reloadData()
        }
    }

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
    
    func configureCell() {
        setupViews()
        setDelegates()
    }
    
    private func setDelegates() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    func configure(with data: HomeCollectionCellDataProtocol) {
        genreIDs = data.homeCCgenres
        if let URL = URL(string: "https://image.tmdb.org/t/p/w500/\(data.homeCCImage)") {
            movieImageView.setImage(withURL: URL)
        }
        movieTitleLabel.text = data.homeCCTitle
        ratingLabel.text = data.homeCCRating
        
    }
    
    
}

//MARK: - Configure CollectionView
extension HomeCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else { return UICollectionViewCell() }
        let genreID = genreIDs[indexPath.item]
        cell.configure(with: genreID)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genreID = genreIDs[indexPath.item]
        let genreName = GenreName.id(genreID).genreName
        
        let width = genreName.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]).width + 25
        
        let cellHeight = (collectionView.frame.height / 2) - 20
        
        return CGSize(width: width, height: cellHeight)
    }
    
}

//MARK: - AddSubviews / Constraints
extension HomeCollectionCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FFFFFF")
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
            movieTitleLabel.heightAnchor.constraint(equalToConstant: movieTitleLabel.font.lineHeight * 2),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            ratingStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            ratingStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: ratingLabel.font.lineHeight),
            
            genreCollectionView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 10),
            genreCollectionView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            genreCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            genreCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            seperatorView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 15),
            seperatorView.trailingAnchor.constraint(equalTo: genreCollectionView.trailingAnchor, constant: -10)
        ])
    }
}
