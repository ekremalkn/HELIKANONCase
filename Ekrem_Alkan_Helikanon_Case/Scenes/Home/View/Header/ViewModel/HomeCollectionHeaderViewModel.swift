//
//  HomeCollectionHeaderViewModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

protocol HomeCollectionHeaderViewModelInterface {
    var view: HomeCollectionHeaderInterface? { get set }
    
    func viewInitizailed()
    func numberOfItems() -> Int
}

final class HomeCollectionHeaderViewModel {
    
    //MARK: - References
    let service: CategoryService
    weak var view: HomeCollectionHeaderInterface?
    
    var movies: [Result] = []
    //MARK: - Init Methods
    init(service: CategoryService) {
        self.service = service
        
    }

    func fetchTrendMovies() {
        service.getMovies(categoryType: .trends) { [weak self] trendMovies in
            guard let self else { return }
            if let trendMovies = trendMovies?.results {
                movies = trendMovies
                view?.reloadData()
            }
        } onError: { error in
            print(error.localizedDescription)
        }

    }

}

//MARK: - HomeCollectionHeaderViewModelInterface
extension HomeCollectionHeaderViewModel: HomeCollectionHeaderViewModelInterface {
    func viewInitizailed() {
        view?.configureHeaderView()
        fetchTrendMovies()
    }
    
    func numberOfItems() -> Int {
        movies.count
    }
    
    
}
