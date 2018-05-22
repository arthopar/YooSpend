//
//  MainViewModel.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 5/16/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

struct DataManagers {}

class MainViewModel: BaseViewModel {
    let dataManagers: DataManagers

    init(dataManagers: DataManagers) {
        self.dataManagers = dataManagers
    }
}
