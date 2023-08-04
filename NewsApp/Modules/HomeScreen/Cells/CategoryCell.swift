//
//  CategoryCell.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import UIKit
import RxSwift
import RxGesture

protocol CategoryCellDelegate {
    func didTap(category: NewsCategory)
}

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: NewsCategory = .general {
        didSet {
            self.categoryLabel.text = category.name
        }
    }
    var delegate: CategoryCellDelegate?
    var bag = DisposeBag()
    
    static let identifier = String(describing: CategoryCell.self)
    static let nib = {
        return UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        setupCell()
        setupAction()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }
    
    func setupAction() {
        self.contentView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.didTap(category: category)
            }).disposed(by: bag)
    }
    
}
