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
        let homeVC = HomeController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "house"), tag: 0)
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeVC.homeCoordinator = self
        
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
}
