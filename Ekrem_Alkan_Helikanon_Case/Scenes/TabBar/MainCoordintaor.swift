//
//  HomeCoordinator.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class MainCoordintaor: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController = MainTabBarController()
    
    func start() {
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        
        let favoriteCoordinator = FavoriteCoordinator()
        favoriteCoordinator.start()
        childCoordinators.append(favoriteCoordinator)
        
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.start()
        childCoordinators.append(settingsCoordinator)
        
        rootViewController.viewControllers = [homeCoordinator.navigationController, favoriteCoordinator.navigationController, settingsCoordinator.navigationController]
    }
    
    
}
