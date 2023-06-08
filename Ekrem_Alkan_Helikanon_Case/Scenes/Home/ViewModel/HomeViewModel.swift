//
//  HomeViewModel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItems() -> Int
    func didSelectItem(at indexPath: IndexPath)
}

final class HomeViewModel {
    
    //MARK: - References
    let service: CategoryService
    weak var view: HomeViewInterface?
    
    var movies: [Result] = []
    
    //MARK: - Init Methods
    init(service: CategoryService) {
        self.service = service
    }
    
    func fetchPopularMovies() {
        service.getMovies(categoryType: .popular) { [weak self] popularMovies in
            guard let self else { return }
            if let popularMovies = popularMovies?.results {
                movies = popularMovies
                view?.reloadData()
            }
        } onError: { error in
            print(error.localizedDescription)
        }
        
    }
    
}

//MARK: - HomeViewModelInterface
extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func viewWillAppear() {
        fetchPopularMovies()
    }
    
    func numberOfItems() -> Int {
        movies.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let id = movies[indexPath.item].id else { return }
        let movieID = String(describing: id)
        view?.openDetailVC(with: movieID)
    }
    
    
}

