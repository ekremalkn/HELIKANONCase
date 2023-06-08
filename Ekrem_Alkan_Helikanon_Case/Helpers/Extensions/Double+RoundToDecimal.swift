//
//  Double+RoundToDecimal.swift
//  Ekrem_Alkan_Helikanon_Case
//
//  Created by Ekrem Alkan on 8.06.2023.
//

import Foundation

extension Double {
    func roundToDecimal(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
