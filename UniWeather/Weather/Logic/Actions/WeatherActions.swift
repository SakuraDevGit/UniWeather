//
//  WeatherActions.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/13.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation
import Suas

enum NetworkActionStatus {
    case busy
    case success
    case error
}

struct WeatherAction {
    private init() {}
    
    struct UpdateCurrentTemperature: Action {
        let status: NetworkActionStatus
        let temperatureFahrenheit: String?
        let error: Error?
    }
}
