//
//  IBDesignableView.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 9/14/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class IBDesignableView: UIView {
    private var contentView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupXib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupXib()
    }

    init() {
        super.init(frame: .zero)

        setupXib()
    }

    func setupXib() {
        guard let view = loadViewFromNib() else { return }

        view.frame = self.bounds
        self.addSubview(view)

        backgroundColor = .clear
        contentView = view
        awakeFromNib()
    }

    func loadViewFromNib() -> UIView? {
        let viewType = type(of: self)
        let bundle = Bundle(for: viewType)
        let nib = UINib(nibName: viewType.nibName, bundle: bundle)

        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setupXib()
        contentView.prepareForInterfaceBuilder()
    }
}
