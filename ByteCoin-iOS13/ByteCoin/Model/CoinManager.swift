//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import Foundation

protocol CoinManagerDelegate {
  func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
  func didFailWithError(error: Error)
}

struct CoinManager {
  
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
  let apiKey = "4DE86A9E-6847-463E-BD1E-BE6769C59390"
  
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
  var delegate: CoinManagerDelegate?
  
  func getCoinPrice(for currency: String){
    let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    
    if let url = URL(string: urlString){
      let session = URLSession(configuration: .default)
      
      let task = session.dataTask(with: url) {(data, response, error) in
        if error != nil {
          delegate?.didFailWithError(error: error!)
          return
        }
        
        if let safeData = data {
          if let coin = parseJSON(safeData){
            delegate?.didUpdateCurrency(self, coin: coin)
          }
        }
        
      }
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) -> CoinModel? {
    let decoder = JSONDecoder()
    
    do {
      let decodedData = try decoder.decode(CoinData.self, from: data)
      let value = decodedData.rate
      let currency = decodedData.asset_id_quote
      let coin = CoinModel(currencyName: currency, coinValue: value)
      
      return coin
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
}
