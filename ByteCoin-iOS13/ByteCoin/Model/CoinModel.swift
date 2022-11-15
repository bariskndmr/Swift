//
//  CoinModel.swift
//  ByteCoin
//
//  Created by BarisKandemir on 14.11.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
  let currencyName: String
  let coinValue: Double
  
  var coinValueString: String {
    return String(format: "%.3f", coinValue)
  }
}
