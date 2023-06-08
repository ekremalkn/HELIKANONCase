//
//  DetailController.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func configureViewController()
    func configureDetails(with details: DetailModel)
    func configureVideoPlayerView(with videoKey: String)
    
    func reloadGenreCollectionData()
    func reloadCastCollectionData()
}

final class DetailController: UIViewController {
    
    deinit {
        print("Detail COntroller deinit")
    }
    
    //MARK: - References
    private let viewModel: DetailViewModel
    private let detailView = DetailView()
    
    //MARK: - Init Methods
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

//MARK: - Configure HomeCollectionView
extension DetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let genreCollectionView = detailView.genreCollectionView
        let castCollectionView = detailView.castCollectionView
        
        if collectionView == genreCollectionView {
            return viewModel.numberOfItems(type: .genre)
        } else if collectionView == castCollectionView {
            return viewModel.numberOfItems(type: .cast)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let genreCollectionView = detailView.genreCollectionView
        let castCollectionView = detailView.castCollectionView
        
        if collectionView == genreCollectionView {
            guard let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else { return UICollectionViewCell() }
            let genreID = viewModel.genreIDs[indexPath.item]
            cell.configure(with: genreID)
            return cell
        } else if collectionView == castCollectionView {
            guard let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionCell.identifier, for: indexPath) as? CastCollectionCell else { return UICollectionViewCell() }
            let castInfo = viewModel.casts[indexPath.item]
            cell.configure(with: castInfo)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genreCollectionView = detailView.genreCollectionView
        let castCollectionView = detailView.castCollectionView
        
        if collectionView == genreCollectionView {
            let genreID = viewModel.genreIDs[indexPath.item]
            let genreName = GenreName.id(genreID).genreName
            
            let cellWidth = genreName.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]).width + 25
            
            let cellHeight = collectionView.frame.height / 2
            
            return CGSize(width: cellWidth, height: cellHeight)
            
        } else if collectionView == castCollectionView {
            var cellWidth = 80
            var cellHeight = 110
            
            if UIScreen.main.bounds.height > 900 {
                cellWidth = 96
                cellHeight = 132
            }
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        return CGSize()
    }
    
    
}

//MARK: - DetailViewInterface
extension DetailController: DetailViewInterface {
    func configureViewController() {
        detailView.delegate = self
        
        detailView.genreCollectionView.delegate = self
        detailView.genreCollectionView.dataSource = self
        
        detailView.castCollectionView.delegate = self
        detailView.castCollectionView.dataSource = self
    }
    
    func configureDetails(with details: DetailModel) {
        detailView.configure(with: details)
    }
    
    func configureVideoPlayerView(with videoKey: String) {
        detailView.configureVideoPlayerView(videoKey: videoKey)
    }
    
    func reloadGenreCollectionData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            detailView.genreCollectionView.reloadData()
        }
    }
    
    func reloadCastCollectionData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            detailView.castCollectionView.reloadData()
        }
    }
    
}

//MARK: - DetailView Button Interface
extension DetailController: DetailViewButtonInterface {
    func detailView(_ view: DetailView, backButtonTapped button: UIButton) {
        dismiss(animated: true)
    }
    
    
}


