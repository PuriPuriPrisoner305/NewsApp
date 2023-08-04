//
//  HeadlinesView.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import UIKit
import SkeletonView
import RxSwift
import Kingfisher

class HeadlinesView: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var headlinesCollectionView: UICollectionView!
    
    var category: NewsCategory = .general
    
    var presenter = HeadlinesPresenter()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        registerDataBinding()
        setupAction()
        fetchNews()
    }
    
    func registerDataBinding() {
        headlinesCollectionView.register(NewsCell.nib, forCellWithReuseIdentifier: NewsCell.identifier)
        headlinesCollectionView.rx.setDelegate(self).disposed(by: bag)
        presenter.newsData.bind(
            to: headlinesCollectionView.rx.items(
                cellIdentifier: NewsCell.identifier,
                cellType: NewsCell.self)) { (index, item, cell) in
                    cell.setupCell(data: item)
                }.disposed(by: bag)
    }
    
    func setupAction() {
        presenter.onSuccessFetchData
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.contentView.isHidden = !value
                self.errorView.isHidden = value
            }).disposed(by: bag)
    }
    
    func fetchNews() {
        presenter.fetchNews(category: category.rawValue)
    }
    
    func showSkeletonView() {
        
    }
    
}

extension HeadlinesView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = 30 + (flowLayout.minimumInteritemSpacing * CGFloat(1))
        var size = Int((collectionView.bounds.width - totalSpace) / CGFloat(1))
        size = size <= 0 ? 0 : size
        return CGSize(width: size, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
