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
        showSkeletonView(isShow: true)
        setupAction()
        fetchNews()
    }
    
    func registerDataBinding() {
        headlinesCollectionView.register(NewsCell.nib, forCellWithReuseIdentifier: NewsCell.identifier)
        headlinesCollectionView.delegate = self
        headlinesCollectionView.dataSource = self
        
        headlinesCollectionView.rx.willDisplayCell
            .subscribe { _, indexPath in
                let lastSection = self.headlinesCollectionView.numberOfSections - 1
                let lastRow = self.headlinesCollectionView.numberOfItems(inSection: lastSection) - 1
                if indexPath.section == lastSection && indexPath.row == lastRow {
                    self.presenter.fetchNews(category: self.category.rawValue)
                }
            }.disposed(by: bag)
    }
    
    func setupAction() {
        presenter.onSuccessFetchData
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.contentView.isHidden = !value
                self.headlinesCollectionView.reloadData()
                self.errorView.isHidden = value
                self.showSkeletonView(isShow: false)
            }).disposed(by: bag)
    }
    
    func fetchNews() {
        presenter.fetchNews(category: category.rawValue)
    }
    
    func showSkeletonView(isShow: Bool) {
        if isShow {
            headlinesCollectionView.showGradientSkeleton()
            
        } else {
            headlinesCollectionView.hideSkeleton()
        }
    }
    
}

extension HeadlinesView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = 30 + (flowLayout.minimumInteritemSpacing * CGFloat(1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(1))
        return CGSize(width: size, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension HeadlinesView: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        cell.setupCell(data: presenter.newsData.value[indexPath.row])
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return NewsCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.newsData.value.count
    }
    
    
}
