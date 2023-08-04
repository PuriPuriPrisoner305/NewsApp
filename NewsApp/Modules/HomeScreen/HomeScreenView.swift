//
//  HomeScreenView.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import UIKit
import RxSwift


class HomeScreenView: UIViewController {

    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var newsCategoryCollection: UICollectionView!
    
    var category: NewsCategory = .general
    
    var presenter = HomeScreenPresenter()
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        registerDataBinding()
    }
    
    func registerDataBinding() {
        newsCategoryCollection.register(CategoryCell.nib, forCellWithReuseIdentifier: CategoryCell.identifier)
        presenter.categoryList.bind(
            to: newsCategoryCollection.rx.items(
                cellIdentifier: CategoryCell.identifier,
                cellType: CategoryCell.self)) { (index, item, cell) in
                    cell.category = item
                    cell.delegate = self
                }.disposed(by: bag)
        newsCategoryCollection.rx.setDelegate(self).disposed(by: bag)
    }
    
}

extension HomeScreenView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = 30 + (flowLayout.minimumInteritemSpacing * CGFloat(1))
        var size = Int((collectionView.bounds.width - totalSpace) / CGFloat(2))
        size = size <= 0 ? 0 : size
        return CGSize(width: size, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension HomeScreenView: CategoryCellDelegate {
    func didTap(category: NewsCategory) {
        guard let navigation = navigationController else { return }
        presenter.navigateToHeadlines(navigation: navigation, category: category)
    }
}
