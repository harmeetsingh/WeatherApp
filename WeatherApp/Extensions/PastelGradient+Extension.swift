//
//  PastelGradient+Extension.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 15/04/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import Pastel

extension PastelGradient {
    
    static func randomGradient() -> PastelGradient {
        
        let randomNumber = Int(arc4random_uniform(10))
        
        if let pastelGradient = PastelGradient(rawValue: randomNumber) {
            
            return pastelGradient
        }
        
        return .warmFlame
    }
}
