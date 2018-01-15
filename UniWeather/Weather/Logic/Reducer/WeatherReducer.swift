//
//  CurrentTemperatureReducer.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/13.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation
import Suas

struct WeatherState {
    var currentTempFahrenheit: String?
    var error: Error?
    var showSpinner: Bool
}

struct WeatherReducer: Reducer {
    var initialState = WeatherState(currentTempFahrenheit: nil, error: nil, showSpinner: false)
    
    func reduce(state: WeatherState, action: Action) -> WeatherState? {
        if let action = action as? WeatherAction.UpdateCurrentTemperature {
            switch action.status {
            case .busy:
                return WeatherState(currentTempFahrenheit: formatForFahrenheit(tempFahrenheit: state.currentTempFahrenheit), error: nil, showSpinner: true)
            case .success:
                return WeatherState(currentTempFahrenheit: formatForFahrenheit(tempFahrenheit: action.temperatureFahrenheit), error: nil, showSpinner: false)
            case .error:
                return WeatherState(currentTempFahrenheit: formatForFahrenheit(tempFahrenheit: state.currentTempFahrenheit), error: action.error, showSpinner: false)
            }
        }
        
        return nil
    }
    
    func formatForFahrenheit(tempFahrenheit: String?) -> String? {
        guard let tempFahrenheit = tempFahrenheit else { return nil }
        return "\(tempFahrenheit) °F"
    }
}
