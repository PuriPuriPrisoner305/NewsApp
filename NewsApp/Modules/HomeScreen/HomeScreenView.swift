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
    
    var presenter = HomeScreenPresenter()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    cell.categoryLabel.text = item.name
                }.disposed(by: bag)
        newsCategoryCollection.rx.setDelegate(self).disposed(by: bag)
    }

}
