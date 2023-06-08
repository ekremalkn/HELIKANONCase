//
//  GenreCell.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    //MARK: - Creating UI Elements
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex: "98A5D8")
        label.text = "CRIME"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
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
        contentView.layer.cornerRadius = (contentView.frame.height) / 2
        contentView.layer.masksToBounds = true
    }
    
    func configure(with genreID: Int) {
        let genreName = GenreName.id(genreID).genreName
        genreLabel.text = genreName.uppercased()
    }
    
    
}

//MARK: - AddSubviews / Constraints
extension GenreCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FBFCFE")
        contentView.backgroundColor = .init(hex: "DDE2FF")
        contentView.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: genreLabel.font.lineHeight),
            genreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}

