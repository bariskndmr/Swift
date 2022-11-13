//
//  WeatherManager.swift
//  Clima
//
//  Created by BarisKandemir on 20.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(error: Error)
}

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=828966dd00e73ffad60098054ebbbb37&units=metric"
  
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(cityName: String){
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(with: urlString)
  }
  
  func fetchWeather(latitude: CLLocationDegrees, longtiude: CLLocationDegrees){
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtiude)"
    performRequest(with: urlString)
  }
  
  
  func performRequest(with urlString: String) {
    // 1. Create URL
    if let url = URL(string: urlString){
      // 2. Create a URLSession
      let session = URLSession(configuration: .default)
      // 3. Give the session task
      let task = session.dataTask(with: url) { (data, response, error) in
        // if we were use "if let" in here we couldn't return
        if error != nil {
          delegate?.didFailWithError(error: error!)
          return
        }
        if let safeData = data {
          // if WeatherManager been a class, we must call it self.parseJSON
          if let weather = parseJSON(safeData){
            delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      // 4. Start the task
      task.resume()
    }
  }
  
  
  
  func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do{
      let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name
      
      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather
    } catch{
      delegate?.didFailWithError(error: error)
      return nil
    }
    
  }
  
  
}
