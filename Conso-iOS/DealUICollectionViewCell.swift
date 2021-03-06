//
//  DealUICollectionViewCell.swift
//  Conso-iOS
//
//  Created by Bilal Karim Reffas on 07.11.15.
//  Copyright © 2015 Quantum. All rights reserved.
//

import UIKit

class DealUICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var voteImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()    
    }
    
    
    
    @IBAction func heartPressed(sender: AnyObject) {
        if self.heartButton.imageView?.image == UIImage(named: "heartunFill"){
           self.heartButton.imageView?.image = UIImage(named: "heartFill")
        }
        
        if self.heartButton.imageView?.image == UIImage(named: "heartFill") {
            self.heartButton.imageView?.image = UIImage(named: "heartunFill")
        }
    }
    
    
}
