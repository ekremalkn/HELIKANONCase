//
//  CastCollectionCell.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import UIKit

protocol CastCollectionCellDataProtocol {
    var castCCActorImage: String { get }
    var castCCActorName: String { get }
}

final class CastCollectionCell: UICollectionViewCell {
    static let identifier = "CastCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()
    
    private lazy var actorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 2
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
    
    func configure(with data: CastCollectionCellDataProtocol) {
        if let URL = URL(string: data.castCCActorImage) {
            actorImageView.setImage(withURL: URL)
        }
        actorNameLabel.text = data.castCCActorName
    }
    
}

//MARK: - AddSubviews / Constraints
extension CastCollectionCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FFFFFF")
        addSubview(actorImageView)
        addSubview(actorNameLabel)
        
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actorImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            
            actorNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            actorNameLabel.heightAnchor.constraint(equalToConstant: actorNameLabel.font.lineHeight),
            actorNameLabel.leadingAnchor.constraint(equalTo: actorImageView.leadingAnchor),
            actorNameLabel.trailingAnchor.constraint(equalTo: actorImageView.trailingAnchor)
        ])
    }
}

