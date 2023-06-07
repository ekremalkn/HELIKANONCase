//
//  MainTabBarController.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .init(hex: "16143E")
        tabBar.barTintColor = .init(hex: "F8F8F8")
        
    }
    
    
    
}
