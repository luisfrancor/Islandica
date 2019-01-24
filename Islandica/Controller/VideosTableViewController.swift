//
//  VideosTableViewController.swift
//  Islandica
//
//  Created by Luis Franco R on 08/01/2019.
//  Copyright © 2019 Luis Franco R. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import StoreKit

class VideosTableViewController: UITableViewController, SKPaymentTransactionObserver {
    
    let productID = "com.luisfrancor.Islandica.PremiumGuide"
    
    var videos: [Video] = Video.fetchVideos()
    var paidVideos: [Video] = Video.fetchPaidVideos()
    
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
        
        if isPurchased() {
            showPaidVideos()
        }
        
    }
    
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isPurchased() {
            return videos.count
            
        } else {
            
            return videos.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        
        if indexPath.row < videos.count {
            let video = videos[indexPath.row]
            cell.video = video
        } else {
            cell.locationNameLabel.text = "Mas VideoGuias?"
            cell.descriptionLabel.text = "Adquiere TODAS las video guias para complementar tu experiencia!"
            cell.descriptionLabel.numberOfLines = 0
            cell.thumbnailImageView.layer.cornerRadius = 8.0
        }
        
        return cell
    }
    
    
    // MARK: - TableView Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == videos.count {
            buyAllTheVideos()
        }
        else {
            playVideo(at: indexPath)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //
    func playVideo(at indexPath: IndexPath) {
        
        let selectedVideo = videos[indexPath.row]
        
        if let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4") {
            
            let videoPathURL = URL(fileURLWithPath: videoPath)
            
            player = AVPlayer(url: videoPathURL)
            playerViewController.player = player
            
            self.present(playerViewController, animated: true, completion: {
                self.playerViewController.player?.play()
            })
        }
    }
    
    
    // MARK: - Cell Animations
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    
    // MARK: - Buy Premium Videos
    
    func buyAllTheVideos() {
        
        if SKPaymentQueue.canMakePayments() {
          
            // Can make payments
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            // Can't make payments
            print("User can't make payments")
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                // User payment succesful
                print("Transaction succesful")
                
                showPaidVideos()
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                
                // Payment failed
                print("Transaction failed")
                
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to: \(errorDescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .restored {
                
                showPaidVideos()
                print("Transaction restored")
                
                navigationItem.setRightBarButton(nil, animated: true)
                
                UserDefaults.standard.set(true, forKey: productID)
            }
            
        }
    }
    
    
    func showPaidVideos() {
        
        UserDefaults.standard.set(true, forKey: productID)
        
        videos.append(contentsOf: paidVideos)
        tableView.reloadData()
    }
    
    func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        
        if purchaseStatus {
            print("Previously purchased")
            return true
        } else {
            print("Never purchased")
            return false
        }
        
    }
    
    // MARK: - Restore
    
    @IBAction func restoreButtonTapped(_ sender: UIBarButtonItem) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
