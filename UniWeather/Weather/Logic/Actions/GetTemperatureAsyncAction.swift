//
//  GetTemperatureAsyncAction.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/13.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation
import Suas

struct GetTemperatureAsyncAction: AsyncAction {
    
    let latitude: String
    let longitude: String
    let temperatureFetcher: TemperatureFetcher
    
    init(latitude: String, longitude: String, temperatureFetcher: TemperatureFetcher) {
        self.latitude = latitude
        self.longitude = longitude
        self.temperatureFetcher = temperatureFetcher
    }
    
    func execute(getState: @escaping GetStateFunction, dispatch: @escaping DispatchFunction) {
        dispatch(WeatherAction.UpdateCurrentTemperature(status: .busy, temperatureFahrenheit: nil, error: nil))
        temperatureFetcher.getTemperatureFromServer(latitude: latitude, longitude: longitude) { (temperature, error) in
            if let error = error {
                dispatch(WeatherAction.UpdateCurrentTemperature(status: .error, temperatureFahrenheit: nil, error: error))
                return
            }
            
            dispatch(WeatherAction.UpdateCurrentTemperature(status: .success, temperatureFahrenheit: String(temperature ?? 0), error: nil))
        }
    }
}
