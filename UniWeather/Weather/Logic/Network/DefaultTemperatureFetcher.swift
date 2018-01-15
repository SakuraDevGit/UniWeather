//
//  DefaultTemperatureFetcher.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/13.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import Foundation

class DefaultTemperatureFetcher: TemperatureFetcher {
    
    func getTemperatureFromServer(latitude: String, longitude: String, completion: @escaping (Double?, Error?) -> ()) {
        let url = URL(string: "https://api.darksky.net/forecast/\(WeatherConsts.weatherAPI)/\(latitude),\(longitude)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let currently = jsonDictionary["currently"] as! [String: Any]
                let temperature = currently["temperature"] as! Double
                completion(temperature, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
}
