//
//  UITableView+Extensions.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 6/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

extension UITableView {
    func sizeHeaderToFit() {
        guard let headerView = self.tableHeaderView else { return }

        updateFrame(view: headerView)
        self.tableHeaderView = headerView
    }

    func sizeFooterToFit() {
        guard let headerView = self.tableFooterView else { return }

        updateFrame(view: headerView)
        self.tableFooterView = headerView
    }

    private func updateFrame(view: UIView) {
        view.setNeedsLayout()
        view.layoutIfNeeded()

        let height = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = view.frame
        frame.size.height = height
        view.frame = frame
    }
}
