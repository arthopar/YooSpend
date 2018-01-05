//
//  BaseViewController.swift
//  YooSpend
//
//  Created by Artak on 12/24/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoader()
    }
    
    private func bindLoader() {
        viewModel.isLoading.asObservable().subscribe(onNext: {[weak self] isLoading in
            isLoading ? self?.showLoader() : self?.hideLoader()
        }).disposed(by: disposeBag)
    }
    
    open func showLoader() {
        
    }
    
    open func hideLoader() {
        
    }
}
