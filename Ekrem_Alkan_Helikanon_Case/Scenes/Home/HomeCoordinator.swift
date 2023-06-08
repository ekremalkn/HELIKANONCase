//
//  HomeCoordinator.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    
    func start() {
        let service: CategoryService = NetworkService()
        let homeViewModel = HomeViewModel(service: service)
        let homeVC = HomeController(viewModel: homeViewModel)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "house"), tag: 0)
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeVC.homeCoordinator = self
        
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    func openDetail(_ movieID: String) {
        let service: DetailService = NetworkService()
        let detailViewModel = DetailViewModel(service: service, movieID: movieID)
        let detailVC = DetailController(viewModel: detailViewModel)
        
        navigationController.present(detailVC, animated: true)
    }
    
}
