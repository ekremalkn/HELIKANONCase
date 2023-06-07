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
    private lazy var genreLabelBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "DDE2FF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex: "98A5D8")
        label.text = "CRIME"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
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
        genreLabelBackgroundView.layer.cornerRadius = (contentView.frame.height * 0.75) / 2
        genreLabelBackgroundView.layer.masksToBounds = true
    }
    
    
    
}

//MARK: - AddSubviews / Constraints
extension GenreCell {
    private func setupViews() {
        backgroundColor = .init(hex: "FBFCFE")
        
        addSubview(genreLabelBackgroundView)
        genreLabelBackgroundView.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreLabelBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreLabelBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreLabelBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            genreLabelBackgroundView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            
            genreLabel.centerXAnchor.constraint(equalTo: genreLabelBackgroundView.centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: genreLabelBackgroundView.centerYAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: genreLabel.font.lineHeight),
            genreLabel.widthAnchor.constraint(equalTo: genreLabelBackgroundView.widthAnchor)
        ])
    }
}

