//
//  BaseViewModel.swift
//  YooSpend
//
//  Created by Artak on 12/24/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    let isLoading = Variable<Bool>(false)
    let showError = Variable<Error?>(nil)
    
    func responseHendler<T>(response: Response<T>) -> T? {
        switch response {
        case .error(let error):
            showError.value = error
        case .success(let data):
            return data
        }
        
        return nil
    }
    
    open func fetch() {
        isLoading.value = true
    }
}
