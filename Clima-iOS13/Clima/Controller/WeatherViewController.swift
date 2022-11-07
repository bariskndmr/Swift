//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    weatherManager.delegate = self
    searchTextField.delegate = self
    // Delegate must be defined at the top (Before the methods)
    locationManager.delegate = self
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
    
    // textField should report back to ViewContoller
    // the main idea is textField can communicate what is going on to ViewController
    
  }
  
}


// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
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
  
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
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

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
  // Must use methods below
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if locations.first != nil {
      print("location:: \(locations[0])")
    }
  }
  
}
