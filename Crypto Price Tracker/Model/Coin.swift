//
//  Coin.swift
//  Crypto Price Tracker
//
//  Created by Vivek Rai on 23/06/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit
import Alamofire

class Coin {
    var symbol = ""
    var image = UIImage()
    var price = 0.0
    var amount = 0.0
    var historicalData = [Double]()
    
    init(symbol: String) {
        self.symbol = symbol
        if let image = UIImage(named: symbol) {
            self.image = image
            
        }
        self.price = UserDefaults.standard.double(forKey: symbol)
        self.amount = UserDefaults.standard.double(forKey: symbol + "amount")
        if let history = UserDefaults.standard.array(forKey: symbol + "history") as? [Double] {
            self.historicalData = history
        }
    }
    
    func priceAsString() -> String {
        if price == 0.0 {
            return "Loading . . ."
        }
        return CoinData.shared.doubleToMoneyString(double: price)
    }
    
    func amountAsString() -> String {
        return CoinData.shared.doubleToMoneyString(double: amount * price)
    }
}
