//
//  TemperatureFetcher.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/13.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation

protocol TemperatureFetcher {
    func getTemperatureFromServer(latitude: String, longitude: String, completion: @escaping (Double?, Error?) -> ())
}
