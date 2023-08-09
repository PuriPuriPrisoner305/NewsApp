//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 03/08/23.
//

import UIKit
import SkeletonView
import Kingfisher
import RxSwift

protocol NewsCellDelegate {
    func didTap(url: String)
}

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsTimeLabel: UILabel!
    
    var delegate: NewsCellDelegate?
    var url: String = ""
    var bag = DisposeBag()
    
    static let identifier = String(describing: NewsCell.self)
    static let nib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        setupAction()
        configure(imageView)
        newsTitleLabel.skeletonTextNumberOfLines = 3
    }
    
    func setupAction() {
        self.contentView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.didTap(url: self.url)
            }).disposed(by: bag)
    }
    
    func configure(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 15
    }
    
    func setupCell(data: ArticleEntity) {
        setupImage(url: data.urlToImage ?? "-")
        newsTitleLabel.text = data.title ?? "-"
        newsSourceLabel.text = data.source?.name ?? "-"
        newsTimeLabel.text = calculateDate(date: data.publishedAt ?? "")
        url = data.url ?? ""
    }

    func setupImage(url: String) {
        let url = URL(string: url)
        imageView.kf.setImage(with: url)
    }
    
    func calculateDate(date: String) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let dateFormatted = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.hour], from: dateFormatted, to: Date())
            
            if let hour = dateComponents.hour {
                if hour < 24 {
                    return "\(hour)h"
                } else {
                    let day = floor((Double(hour) / 24))
                    return "\(Int(day))d"
                }
            }
        }
        return "-"
    }
}
