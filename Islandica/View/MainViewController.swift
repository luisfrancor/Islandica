//
//  MainViewController.swift
//  Islandica
//
//  Created by Luis Franco R on 08/01/2019.
//  Copyright © 2019 Luis Franco R. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var videoGuidesAccess: UIButton!
    @IBOutlet weak var whaleImage: UIImageView!
    @IBOutlet weak var whaleImage2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarSetup()
        
        videoGuidesAccess.layer.cornerRadius = 8.0
        whaleImage.layer.cornerRadius = 8.0
        whaleImage2.layer.cornerRadius = 8.0
        
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func navigationBarSetup() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.537, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
    }
    
    
    @IBAction func accessTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToVideoGuides", sender: self)
        
    }
    
}
