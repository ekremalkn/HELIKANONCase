//
//  Coordinator.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 7.06.2023.
//

import UIKit.UINavigationController

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}


