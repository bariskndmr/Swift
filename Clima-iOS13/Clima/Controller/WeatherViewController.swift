//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // textField should report back to ViewContoller
    // the main idea is textField can communicate what is going on to ViewController
    weatherManager.delegate = self
    searchTextField.delegate = self
  }
  
  @IBAction func searchPressed(_ sender: UIButton) {
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Type something"
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // Use searchTextField.text to get the weather for that city.
    if let cityName = searchTextField.text{
      weatherManager.fetchWeather(cityName: cityName)
    }
  }
  
  // weatherManager triggers didUpdateWeather func
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
      // we should use self first because this is a closure
      self.temperatureLabel.text = weather.temperatureString
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
      self.cityLabel.text = weather.cityName
    }
    
  }
  
  func didFailWithError(error: Error) {
    print(error)
  }
  
}
