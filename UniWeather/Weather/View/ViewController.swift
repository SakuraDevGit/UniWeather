//
//  ViewController.swift
//  UniWeather
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/10.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import UIKit
import Suas

class ViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).store.addListener(forStateType: WeatherState.self) { [weak self] (state) in
            self?.updateView(state: state)
        }.linkLifeCycleTo(object: self)
    }
    
    func updateView(state: WeatherState) {
        temperatureLabel.text = state.currentTempFahrenheit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getTemperatureTouchUpInside(_ sender: UIButton) {
        let temperatureFetcher = DefaultTemperatureFetcher()
        (UIApplication.shared.delegate as! AppDelegate).store.dispatch(action: GetTemperatureAsyncAction(latitude: latitudeTextField.text ?? "",
                                                                                                         longitude: longitudeTextField.text ?? "",
                                                                                                         temperatureFetcher: temperatureFetcher))
    }
    
}

