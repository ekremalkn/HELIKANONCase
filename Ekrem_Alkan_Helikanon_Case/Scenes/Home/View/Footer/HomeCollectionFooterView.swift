//
//  HomeCollectionFooterView.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import UIKit

final class HomeCollectionFooterView: UICollectionReusableView {
        static let identifier = "HomeCollectionFooterView"
    
    //MARK: - Creating UI Elements
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .init(hex: "A3A3A3")
        return indicator
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

//MARK: - AddSubviews / Constraints
extension HomeCollectionFooterView {
    private func setupViews() {
        backgroundColor = .init(hex: "FFFFFF")
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

