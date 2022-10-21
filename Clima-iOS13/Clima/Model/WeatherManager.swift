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
      let task = session.dataTask(with: url, completionHandler: handle(data:urlResponse:error:))
      
      // 4. Start the task
      task.resume()
    }
  }
  
  func handle(data: Data?, urlResponse: URLResponse?, error: Error?){
    if error != nil {
      print(error!)
      return
    }
    if let safeData = data {
      let dataString = String(data: safeData, encoding: .utf8)
      print(dataString!)
    }
  }
}
