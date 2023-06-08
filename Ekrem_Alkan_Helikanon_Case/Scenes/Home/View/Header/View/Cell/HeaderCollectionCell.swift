//
//  HeaderCollectionCell.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

protocol HeaderCollectionCellDataProtocol {
    var headerCCImage: String { get }
    var headerCCTitle: String { get }
    var headerCCRating: String { get }
}

final class HeaderCollectionCell: UICollectionViewCell {
    static let identifier = "HeaderCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie"
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
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
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
        movieImageView.layer.cornerRadius = 6
        movieImageView.layer.masksToBounds = true
    }
    
    
    func configure(with data: HeaderCollectionCellDataProtocol) {
        if let URL = URL(string: data.headerCCImage) {
            movieImageView.setImage(withURL: URL)
        }
        movieTitleLabel.text = data.headerCCTitle
        ratingLabel.text = data.headerCCRating
    }
    
    
}

//MARK: - AddSubviews / Constraints
extension HeaderCollectionCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FFFFFF")
        
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: movieTitleLabel.font.lineHeight * 2),
            
            ratingStackView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            ratingStackView.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: ratingLabel.font.lineHeight)
          
        ])
    }
}
