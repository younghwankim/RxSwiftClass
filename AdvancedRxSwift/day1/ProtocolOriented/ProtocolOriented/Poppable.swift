//
//  Poppable.swift
//  ProtocolOriented
//
//  Created by Young Kim on 2018-05-20.
//  Copyright © 2018 Young Kim. All rights reserved.
//

import UIKit

protocol Poppable {
    func pop()
}

extension Poppable where Self: UIView {
    func pop() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.alpha = 1.0 }) { (animationCompleted) in
                        if animationCompleted == true {
                            UIView.animate(withDuration: 0.3,
                                           delay: 2.0,
                                           options: .curveEaseOut,
                                           animations: { self.alpha = 0.0 },
                                           completion: nil)
                        }
        }
    }
}
