//
//  DVLabel.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import UIKit

final class DVLabel: UILabel {
    
    enum LabelType {
        case infoTitle
        case infoData
    }
    
    convenience init(type: LabelType) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        set(type: type)
    }
    
    private func set(type: LabelType) {
        switch type {
        case .infoTitle:
            textColor = .init(hex: "A3A3A3")
            font = .systemFont(ofSize: 14)
        case .infoData:
            textColor = .black
            font = .systemFont(ofSize: 13)
        }
    }
}
