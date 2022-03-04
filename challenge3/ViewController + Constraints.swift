//
//  ViewController + Constraints.swift
//  challenge3
//
//  Created by Ivan Pavic on 3.3.22..
//

import Foundation
import UIKit


extension ViewController {
    
    func activatePortraitConstraints() {
        NSLayoutConstraint.deactivate(landscapeConstraints)
        NSLayoutConstraint.activate(portraitConstraints)
    }
    func activateLandscapeConstraints() {
        NSLayoutConstraint.deactivate(portraitConstraints)
        NSLayoutConstraint.activate(landscapeConstraints)
    }
}
