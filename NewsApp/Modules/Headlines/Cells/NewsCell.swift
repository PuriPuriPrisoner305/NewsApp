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
    
    static let identifier = String(describing: NewsCell.self)
    static let nib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        configure(imageVIew)
    }
    
    func configure(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 15
    }
    
    func setupCell(data: ArticleEntity) {
        newsTitleLabel.text = data.title ?? "-"
        newsSourceLabel.text = data.source?.name ?? "-"
        newsTimeLabel.text = data.publishedAt ?? "-"
        print("setup")
    }

}
