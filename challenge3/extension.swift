//
//  extension.swift
//  challenge3
//
//  Created by Ivan Pavic on 3.3.22..
//

import Foundation
import UIKit

extension UIScreen {
    func isPortrait() -> Bool {
        return self.bounds.height > self.bounds.width
    }
}
