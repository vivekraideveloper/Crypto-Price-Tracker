//
//  CryptoTableVC.swift
//  Crypto Price Tracker
//
//  Created by Vivek Rai on 23/06/19.
//  Copyright © 2019 Vivek Rai. All rights reserved.
//

import UIKit
import LocalAuthentication

private let headerHight: CGFloat = 100.0
private let networthHeight: CGFloat = 45.0
private let amountLabelFontSize: CGFloat = 50.0

class CryptoTableVC: UITableViewController, CoinDataDelegate {
    
    var amountLabel = UILabel()
    let prices = Prices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoinData.shared.getPrices()
        tableView.rowHeight = 100.0
        
        navigationItemLeftSetup(title: "Share")
        navigationItem.title = "Crpto Price Tracker"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 218, green: 165, blue: 32, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoinData.shared.delegate = self
        tableView.reloadData()
        displeyNetworth()
    }
    
    func newPrices() {
        displeyNetworth()
        tableView.reloadData()
    }
    
    //MARK: Header View setup
    fileprivate func headerView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHight))
        headerView.backgroundColor = .white
        
        networthLabelSetup(with: headerView)
        amountLabelSetup(with: headerView)
        displeyNetworth()
        
        return headerView
    }
    
    //MARK: - Label setup and logic
    fileprivate func networthLabelSetup(with headerView: UIView) {
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: networthHeight))
        networthLabel.text = "My Net Cryto Worth"
        networthLabel.textAlignment = .center
        headerView.addSubview(networthLabel)
    }
    
    fileprivate func amountLabelSetup(with headerView: UIView) {
        amountLabel.frame = CGRect(x: 0, y: networthHeight, width: view.frame.size.width, height: headerHight - networthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: amountLabelFontSize)
        headerView.addSubview(amountLabel)
    }
    
    fileprivate func displeyNetworth() {
        amountLabel.text = CoinData.shared.networthAsString()
    }
    
    //MARK: - Share button
    @objc fileprivate func shareButtonTapped() {
        let text = "This is the text....."
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func navigationItemLeftSetup(title: String) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(shareButtonTapped))
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinData.shared.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let coin = CoinData.shared.coins[indexPath.row]
        
        if coin.amount == 0.0 {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString()) - \(coin.amount)"
            cell.imageView?.image = coin.image
            
        } else {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
            cell.imageView?.image = coin.image
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = CoinVC()
        coinVC.coin = CoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }
}
