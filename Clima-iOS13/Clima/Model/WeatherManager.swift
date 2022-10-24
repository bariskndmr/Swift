//
//  WeatherManager.swift
//  Clima
//
//  Created by BarisKandemir on 20.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=828966dd00e73ffad60098054ebbbb37&units=metric"
  
  func fetchWeather(cityName: String){
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(urlString: urlString)
  }
  
  func performRequest(urlString: String) {
    // 1. Create URL
    if let url = URL(string: urlString){
      // 2. Create a URLSession
      let session = URLSession(configuration: .default)
      
      // 3. Give the session task
      let task = session.dataTask(with: url) { (data, response, error) in
        // if we were use "if let" in here we couldn't return
        if error != nil {
          print(error!)
          return
        }
        if let safeData = data {
          parseJSON(weatherData: safeData)
          
        }
      }
      
      // 4. Start the task
      task.resume()
    }
  }
  
  func parseJSON(weatherData: Data){
    let decoder = JSONDecoder()
    do{
      let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
      print(decodedData.weather[0].description)
    } catch{
      print(error)
    }
    
  }
  
  
}
