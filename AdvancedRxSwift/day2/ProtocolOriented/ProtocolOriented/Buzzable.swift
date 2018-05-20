//
//  Buzzable.swift
//  ProtocolOriented
//
//  Created by Young Kim on 2018-05-20.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit

protocol Buzzable {
    func buzz()
}

extension Buzzable where Self: UIView {
    func buzz() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
