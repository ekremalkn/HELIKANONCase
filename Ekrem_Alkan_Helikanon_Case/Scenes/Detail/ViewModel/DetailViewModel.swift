//
//  DetailViewModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    func viewDidLoad()
    
}

final class DetailViewModel {
    
    //MARK: - References
    let service: DetailService
    weak var view: DetailViewInterface?
    
    //MARK: - Init Methods
    init(service: DetailService) {
        self.service = service
    }
    
    func fetchMovieDetails(with id: String) {
        service.getMovieDetails(with: id) { [weak self] detailModel in
            guard let self else { return }
            if let details = detailModel {
                view?.configureDetails(with: details)
            }
        } onError: { error in
            print(error.localizedDescription)
        }

    }
}

extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        
    }
    
    
}
