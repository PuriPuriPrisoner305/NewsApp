//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 03/08/23.
//

import UIKit
import SkeletonView
import Kingfisher

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
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
        configure(imageView)
        newsTitleLabel.skeletonTextNumberOfLines = 3
    }
    
    func configure(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 15
    }
    
    func setupCell(data: ArticleEntity) {
        setupImage(url: data.urlToImage ?? "-")
        newsTitleLabel.text = data.title ?? "-"
        newsSourceLabel.text = data.source?.name ?? "-"
        newsTimeLabel.text = data.publishedAt ?? "-"
    }

    func setupImage(url: String) {
        let url = URL(string: url)
        imageView.kf.setImage(with: url)
    }
}
