//
//  UniWeatherTests.swift
//  UniWeatherTests
//
//  Created by Frederick Rudolf Janse van Rensburg on 2018/01/10.
//  Copyright © 2018 SakuraDev. All rights reserved.
//

import XCTest
import Suas
@testable import UniWeather

class UniWeatherTests: XCTestCase {
    
    var store: Store!
    var temperatureFetcher: FakeTemperatureFetcher!
    var stateArray: [WeatherState]!
    
    override func setUp() {
        super.setUp()
        
        store = Suas.createStore(reducer: WeatherReducer(), middleware: AsyncMiddleware())
        temperatureFetcher = FakeTemperatureFetcher()
        stateArray = [WeatherState]()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGivenNoErrorFromTempFetcher_WhenGetTemperatureAsyncActionIsCalled_ThenStateIsUpdatedWithTemperature() {
        // Given
        temperatureFetcher.errorToReturn = nil
        temperatureFetcher.temperatureToReturn = 50
        
        _ = store.addListener(forStateType: WeatherState.self) { [weak self] (state) in
            self?.stateArray.append(state)
        }
        
        // When
        store.dispatch(action: GetTemperatureAsyncAction(latitude: "34.33", longitude: "-34.33", temperatureFetcher: temperatureFetcher))
        
        // Then
        XCTAssert(stateArray.last?.currentTempFahrenheit == "50.0 °F")
    }
    
    func testGivenAnErrorFromTempFetcher_WhenGetTemperatureAsyncActionIsCalled_ThenStateIsUpdatedWithTheError() {
        // Given
        temperatureFetcher.errorToReturn = NSError(domain: "test", code: 1337, userInfo: nil)
        temperatureFetcher.temperatureToReturn = nil
        
        _ = store.addListener(forStateType: WeatherState.self) { [weak self] (state) in
            self?.stateArray.append(state)
        }
        
        // When
        store.dispatch(action: GetTemperatureAsyncAction(latitude: "34.33", longitude: "-34.33", temperatureFetcher: temperatureFetcher))
        
        // Then
        XCTAssert(((stateArray.last?.error)! as NSError).code == 1337)
    }
    
    func testWhenGetTemperatureAsyncActionIsCalled_ThenStateIsUpdatedToBusy() {
        // Given
        temperatureFetcher.errorToReturn = nil
        temperatureFetcher.temperatureToReturn = 50
        
        _ = store.addListener(forStateType: WeatherState.self) { [weak self] (state) in
            self?.stateArray.append(state)
        }
        
        // When
        store.dispatch(action: GetTemperatureAsyncAction(latitude: "34.33", longitude: "-34.33", temperatureFetcher: temperatureFetcher))
        
        // Then
        XCTAssert(stateArray.first?.showSpinner == true)
    }
    
    func testGivenNoErrorFromTempFetcher_WhenGetTemperatureAsyncActionIsCalled_ThenStateIsUpdatedToNotBusy() {
        // Given
        temperatureFetcher.errorToReturn = nil
        temperatureFetcher.temperatureToReturn = 50
        
        _ = store.addListener(forStateType: WeatherState.self) { [weak self] (state) in
            self?.stateArray.append(state)
        }
        
        // When
        store.dispatch(action: GetTemperatureAsyncAction(latitude: "34.33", longitude: "-34.33", temperatureFetcher: temperatureFetcher))
        
        // Then
        XCTAssert(stateArray.last?.showSpinner == false)
    }
}
