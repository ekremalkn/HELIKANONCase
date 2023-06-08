//
//  DetailViewModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

protocol DetailViewDataProtocol {
    var dvMovieTitle: String { get }
    var dvRating: String { get }
    var dvGenreIDs: [Int] { get }
    var dvRelease: String { get }
    var dvLanguage: String { get }
    var dvVoteCount: String { get }
    var dvDescription: String { get }
}

enum CollectionViewType {
    case genre
    case cast
}

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    func viewDidLoad()
    
    func numberOfItems(type: CollectionViewType) -> Int
}

final class DetailViewModel {
    
    //MARK: - References
    let service: DetailService
    weak var view: DetailViewInterface?
    
    //MARK: - Variables
    let movideID: String
    var genreIDs: [Int] = []
    var casts: [Cast] = []
    
    //MARK: - Init Methods
    init(service: DetailService, movieID: String) {
        self.service = service
        self.movideID = movieID
    }
    
    func fetchMovieDetails() {
        service.getMovieDetails(with: movideID) { [weak self] detailModel in
            guard let self else { return }
            if let details = detailModel {
                genreIDs = details.dvGenreIDs
                view?.reloadGenreCollectionData()
                view?.configureDetails(with: details)
            }
        } onError: { error in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchVideoDetails() {
        service.getVideoDetails(with: movideID) { [weak self] videoModel in
            guard let self else { return }
            if let videos = videoModel?.results {
                if let videoKey = videos.randomElement()?.key {
                    view?.configureVideoPlayerView(with: videoKey)
                }
            }
        } onError: { error in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchCasts() {
        service.getCastsDetails(with: movideID) { [weak self] castModel in
            guard let self else { return }
            if let casts = castModel?.cast {
                self.casts = casts
                view?.reloadCastCollectionData()
            }
        } onError: { error in
            print(error.localizedDescription)
        }

    }
}

extension DetailViewModel: DetailViewModelInterface {
    func numberOfItems(type: CollectionViewType) -> Int {
        switch type {
        case .genre:
            return genreIDs.count
        case .cast:
            return casts.count
        }
    }
    
    func viewDidLoad() {
        view?.configureViewController()
        fetchCasts()
        fetchMovieDetails()
        fetchVideoDetails()
    }
    
    
}
