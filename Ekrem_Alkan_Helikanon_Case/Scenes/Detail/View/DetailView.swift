//
//  DetailView.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol DetailViewButtonInterface: AnyObject {
    func detailView(_ view: DetailView, backButtonTapped button: UIButton)
}

final class DetailView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .init(hex: "FFFFFF")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.setImage(.init(systemName: "arrow.left"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .init(hex: "FFFFFF")
        button.backgroundColor = .init(hex: "A3A3A3").withAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var videoPlayerView: YTPlayerView = {
        let view = YTPlayerView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var detailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "FFFFFF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Super Mario Bros. Movie"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "heart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .init(hex: "A3A3A3")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .init(hex: "FFFFFF")
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.contentMode = .scaleAspectFit
        stackView.backgroundColor = .init(hex: "FFFFFF")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var releaseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.backgroundColor = .init(hex: "FFFFFF")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var releaseTitleLabel = DVLabel(type: .infoTitle)
    
    private lazy var releaseDataLabel = DVLabel(type: .infoData)
    
    private lazy var languageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.backgroundColor = .init(hex: "FFFFFF")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var languageTitleLabel = DVLabel(type: .infoTitle)
    
    private lazy var languageDataLabel = DVLabel(type: .infoData)
    
    private lazy var ratingCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.backgroundColor = .init(hex: "FFFFFF")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ratingCountTitleLabel = DVLabel(type: .infoTitle)
    
    private lazy var ratingCountDataLabel = DVLabel(type: .infoData)
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .init(hex: "120E4A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex: "A3A3A3")
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .init(hex: "120E4A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CastCollectionCell.self, forCellWithReuseIdentifier: CastCollectionCell.identifier)
        collection.backgroundColor = .init(hex: "FFFFFF")
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    //MARK: - References
    weak var delegate: DetailViewButtonInterface?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.layer.cornerRadius = 20
        backButton.layer.masksToBounds = true
        
        detailsView.layer.cornerRadius = 12
        detailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Only Top Left-Right
        
        detailsView.layer.shadowColor = UIColor.black.cgColor
        detailsView.layer.shadowOpacity = 0.2
        detailsView.layer.shadowRadius = 12
        detailsView.layer.shadowOffset = CGSize.init(width: 0, height: -3)
    }
    
    @objc private func backButtonTapped(_ button: UIButton) {
        delegate?.detailView(self, backButtonTapped: backButton)
    }
    
    func configure(with data: DetailViewDataProtocol) {
        movieTitleLabel.text = data.dvMovieTitle
        ratingLabel.text = data.dvRating
        releaseTitleLabel.text = "Release Date"
        releaseDataLabel.text = data.dvRelease
        languageTitleLabel.text = "Language"
        languageDataLabel.text = data.dvLanguage.capitalized
        ratingCountTitleLabel.text = "Rating"
        ratingCountDataLabel.text = data.dvVoteCount
        descriptionDataLabel.text = data.dvDescription
    }
    
    func configureVideoPlayerView(videoKey: String) {
        videoPlayerView.load(withVideoId: videoKey, playerVars: ["playsinline": "1"])
    }
    
    
    
}

//MARK: - AddSubviews / Constraints
extension DetailView {
    private func setupViews() {
        backgroundColor = .black
        addSubview(contentScrollView)
        
        contentScrollView.addSubview(videoPlayerView)
        contentScrollView.addSubview(backButton)
        contentScrollView.addSubview(detailsView)
        
        detailsView.addSubview(favoriteButton)
        detailsView.addSubview(movieTitleLabel)
        detailsView.addSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        detailsView.addSubview(genreCollectionView)
        detailsView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(releaseStackView)
        infoStackView.addArrangedSubview(languageStackView)
        infoStackView.addArrangedSubview(ratingCountStackView)
        
        releaseStackView.addArrangedSubview(releaseTitleLabel)
        releaseStackView.addArrangedSubview(releaseDataLabel)
        
        languageStackView.addArrangedSubview(languageTitleLabel)
        languageStackView.addArrangedSubview(languageDataLabel)
        
        ratingCountStackView.addArrangedSubview(ratingCountTitleLabel)
        ratingCountStackView.addArrangedSubview(ratingCountDataLabel)
        
        detailsView.addSubview(descriptionTitleLabel)
        detailsView.addSubview(descriptionDataLabel)
        detailsView.addSubview(castTitleLabel)
        detailsView.addSubview(castCollectionView)
        
        var videoPlayerMultipler: CGFloat = 0.27
        var castCollectionHeight: CGFloat = 110
        if UIScreen.main.bounds.height < 850 {
            videoPlayerMultipler = 0.33
        }
        
        if UIScreen.main.bounds.height > 900 {
            castCollectionHeight = 132
        }
                
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            videoPlayerView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            videoPlayerView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            videoPlayerView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            videoPlayerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: videoPlayerMultipler),
            
            detailsView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: -10),
            detailsView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            movieTitleLabel.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 15),
            movieTitleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -15),
            
            ratingStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 15),
            ratingStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: ratingLabel.font.lineHeight),
            
            genreCollectionView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 10),
            genreCollectionView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor),
            genreCollectionView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),
            genreCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            infoStackView.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor, constant: 15),
            infoStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -15),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: descriptionDataLabel.font.lineHeight + 5),
            
            descriptionDataLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 20),
            descriptionDataLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            descriptionDataLabel.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor),
            
            castTitleLabel.topAnchor.constraint(equalTo: descriptionDataLabel.bottomAnchor, constant: 20),
            castTitleLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            castTitleLabel.trailingAnchor.constraint(equalTo: descriptionTitleLabel.trailingAnchor),
            castTitleLabel.heightAnchor.constraint(equalToConstant: castTitleLabel.font.lineHeight),
            
            castCollectionView.topAnchor.constraint(equalTo: castTitleLabel.bottomAnchor, constant: 20),
            castCollectionView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: castCollectionHeight),
            castCollectionView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor)
        ])
    }
}
