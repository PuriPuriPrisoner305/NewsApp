//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 03/08/23.
//

import UIKit
import SkeletonView

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        configure(imageVIew)
    }
    
    func configure(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 15
    }

}
