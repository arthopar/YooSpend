//
//  BaseViewController.swift
//  YooSpend
//
//  Created by Artak on 12/24/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T: BaseViewModel>: UIViewController, ActivityLoading {
    var activityIndicator: UIView?
    
    var viewModel: T!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func bindViewModel() {
        bindLoader()
        bindError()
    }
    
    private func bindLoader() {
        viewModel.isLoading.asDriver()
            .drive(onNext: {[weak self] isLoading in
                isLoading ? self?.showLoader() : self?.hideLoader()
            }).disposed(by: disposeBag)
    }
    
    private func bindError() {
        viewModel.showError.asDriver()
            .filter { $0 != nil }
            .drive(onNext: {[weak self] error in
                self?.hideLoader()
                let alert = UIAlertController(title: "Oops Error", message: error?.localizedDescription, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cencel", style: .cancel) { action in
                    // perhaps use action.title here
                })
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}
