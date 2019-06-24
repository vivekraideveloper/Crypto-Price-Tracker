//
//  CoinDataProtocol.swift
//  Crypto Price Tracker
//
//  Created by Vivek Rai on 23/06/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import Foundation

@objc protocol CoinDataDelegate {
    @objc optional func newPrices()
    @objc optional func newHistory()
}

