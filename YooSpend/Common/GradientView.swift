//
//  GradientView.swift
//  YooSpend
//
//  Created by Artak Tsatinyan on 6/2/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

@IBDesignable open class GradientView: UIView {

    @IBInspectable open var startColor: UIColor = UIColor.white
    @IBInspectable open var endColor: UIColor = UIColor.black

    @IBInspectable open var startLocation: Double = 0.0
    @IBInspectable open var endLocation: Double = 1.0

    @IBInspectable open var horizontalMode: Bool = false

    override open class var layerClass : AnyClass { return CAGradientLayer.self }

    override open func layoutSubviews() {
        super.layoutSubviews()
        guard let layer = layer as? CAGradientLayer else { return }
        if horizontalMode {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint   = CGPoint(x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint   = CGPoint(x: 0.5, y: 1)
        }
        layer.locations = [NSNumber(value: startLocation), NSNumber(value: endLocation)]
        layer.colors    = [startColor.cgColor, endColor.cgColor]
    }
}
