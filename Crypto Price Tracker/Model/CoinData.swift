//
//  CoinData.swift
//  Crypto Price Tracker
//
//  Created by Vivek Rai on 23/06/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//
import UIKit
import Alamofire

class CoinData {
    static let shared = CoinData()
    var coins = [Coin]()
    weak var delegate: CoinDataDelegate?
    let prices = Prices()
    
    private init() {
        let symbols = ["BTC", "ETH", "LTC", "XRP", "BCH", "EOS", "NEO", "TRX", "ZEC", "ETC", "BTG", "ADA", "BSV", "ONT", "QTUM", "XLM", "USDT", "DASH", "TUSD", "PAX", "HSR", "OMG", "XMR", "LINK", "HT", "DOGE", "AE", "BTT", "MIOTA", "ATOM", "BAT", "GXS", "MONA", "KCS", "XEM", "ZIL", "VET", "USDC", "BTM", "RVN", "WAVES", "BTS", "BNB", "SNT", "IOST", "ZRX", "ITC", "ICX", "CTXC", "NULS", "BIX", "ELF", "FUEL", "FUN", "GAME", "DROP", "BURST", "GRIN", "NAS", "MANA", "AION"]
        
        for symbol in symbols {
            let coin = Coin(symbol: symbol)
            coins.append(coin)
        }
    }
    
    func getPrices() {
        var listOfSymbols = ""
        for coin in coins {
            listOfSymbols += coin.symbol
            if coin.symbol != coins.last?.symbol {
                listOfSymbols += ","
            }
            prices.getPrices(symbols: listOfSymbols, coins: coins)
        }
    }
    
    func doubleToMoneyString(double: Double) -> String {
        let formater = NumberFormatter()
        formater.locale = Locale(identifier: "en_US")
        formater.numberStyle = .currency
        if let fancyPrice = formater.string(from: NSNumber(floatLiteral: double)) {
            return fancyPrice
        } else {
            return "ERROR"
        }
    }
    
    func networthAsString() -> String {
        var networth = 0.0
        for coin in coins {
            networth += coin.amount * coin.price
        }
        return doubleToMoneyString(double: networth)
    }
    
    func html() -> String {
        var html = "<h1> Crypto Report </h1>"
        html += "<h2>Net Worth: \(networthAsString()) </h2>"
        for coin in coins {
            if coin.amount != 0 {
                html += "<li>\(coin.symbol) - I won: \(coin.amount) - Valued at: \(doubleToMoneyString(double: coin.amount * coin.price))  </li>"
            }
        }
        return html
    }
}

