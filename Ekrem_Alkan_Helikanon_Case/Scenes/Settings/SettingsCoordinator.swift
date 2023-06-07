//
//  SettingsCoordinator.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let settingsVC = SettingsController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: .init(systemName: "gearshape"), tag: 2)
        settingsVC.tabBarItem.selectedImage = .init(systemName: "gearshape.fill")
        settingsVC.settingsCoordinator = self
        
        navigationController.setViewControllers([settingsVC], animated: false)
    }
    
    
}
