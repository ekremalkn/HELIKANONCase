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
    func didScrollToEnd()
}

final class HomeViewModel {
    
    //MARK: - References
    let service: CategoryService
    weak var view: HomeViewInterface?
    
    var movies: [Result] = []
    var isPaginating: Bool = false
    
    var page: Int = 1 {
        didSet {
            fetchPopularMovies(isPagination: true)
        }
    }
    
    //MARK: - Init Methods
    init(service: CategoryService) {
        self.service = service
    }
    
    func fetchPopularMovies(isPagination: Bool) {
        isPaginating = isPagination ? true : false
        service.getMovies(categoryType: .popular(page: page)) { [weak self] popularMovies in
            guard let self else { return }
            if let popularMovies = popularMovies?.results {
                if isPagination {
                    movies.append(contentsOf: popularMovies)
                } else {
                    movies = popularMovies
                }
                
                view?.reloadData()
                isPaginating = false
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
        fetchPopularMovies(isPagination: false)
    }
    
    func numberOfItems() -> Int {
        movies.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let id = movies[indexPath.item].id else { return }
        let movieID = String(describing: id)
        view?.openDetailVC(with: movieID)
    }
    
    func didScrollToEnd() {
        page += 1
    }
    
    
}

