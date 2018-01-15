//
//  FakeTemperatureFetcher.swift
//  UniWeatherTests
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/15.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation
@testable import UniWeather

class FakeTemperatureFetcher: TemperatureFetcher {
    
    var temperatureToReturn: Double?
    var errorToReturn: Error?
    
    func getTemperatureFromServer(latitude: String, longitude: String, completion: @escaping (Double?, Error?) -> ()) {
        completion(temperatureToReturn, errorToReturn)
    }
}
