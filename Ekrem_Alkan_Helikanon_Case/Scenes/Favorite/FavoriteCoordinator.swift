//
//  FavoriteCoordinator.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class FavoriteCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    
    func start() {
        let favoriteVC = FavoriteController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: .init(systemName: "heart"), tag: 1)
        favoriteVC.tabBarItem.selectedImage = .init(systemName: "heart.fill")
        favoriteVC.favoriteCoordinator = self
        
        navigationController.setViewControllers([favoriteVC], animated: false)
    }
    
}
