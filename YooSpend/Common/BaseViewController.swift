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

    //let errorView = ErrorView.loadNib() as! ErrorView
    //let emptyView = ErrorView.loadNib() as! ErrorView

    var navigation: Navigation?

    var withBackground: Bool {
        return false
    }

    private let retryNotificationName = NSNotification.Name(rawValue: "retry")

    open var infoViewContainer: UIView {
        return self.view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear

//        errorView.setupNoInternetConnectionView(buttonAction: {[weak self] in
//            self?.retryDataAction()
//        })

        setupInfoViews()

        NotificationCenter.default.addObserver(self, selector: #selector(retryNotification), name: retryNotificationName, object: nil)

        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            setupBackButton()
        }
    }

    private func setupInfoViews() {
//        emptyView.setupEmptyView()
//
//        infoViewContainer.addSubviewWithBoarder(view: emptyView)
//        infoViewContainer.addSubviewWithBoarder(view: errorView)
//        errorView.isHidden = true
//        emptyView.isHidden = true
    }

    open func setupBackButton() {
        let backItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action:  #selector(back))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.backBarButtonItem = nil
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func retryNotification() {
        //errorView.isHidden = true
        viewModel.fetch() //TODO
    }

    func retryDataAction() {
        NotificationCenter.default.post(name: retryNotificationName, object: nil)
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
            .drive(onNext: {[weak self] error in
                self?.hideLoader()

                guard error != nil else {
                    //self?.errorView.isHidden = true

                    return
                }

                if let code = error?.code {
                    switch URLError.Code(rawValue: code) {
                    case .notConnectedToInternet:
                        //self?.errorView.isHidden = false
                        //self?.errorView.bringSubview(toFront: self!.view)
                        return
                    default: break
                    }
                }

                let alert = UIAlertController(title: "Oops Error", message: error?.errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel) { action in
                    // perhaps use action.title here
                })
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
