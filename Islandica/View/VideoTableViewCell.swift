//
//  VideoTableViewCell.swift
//  Islandica
//
//  Created by Luis Franco R on 08/01/2019.
//  Copyright © 2019 Luis Franco R. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var video: Video! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        thumbnailImageView.image = UIImage(named: video.thumbnailFileName)
        
        locationNameLabel.text = video.authorName
        descriptionLabel.text = video.description
        
        thumbnailImageView.layer.cornerRadius = 8.0
        thumbnailImageView.layer.masksToBounds = true
    }
    
}
