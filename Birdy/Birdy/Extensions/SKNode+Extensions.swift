//
//  SKNode+Extensions.swift
//  Birdy
//
//  Created by Леонід Шевченко on 04.04.2022.
//

import SpriteKit

extension SKNode {
    
    func aspectScale(to size: CGSize, width: Bool, multiplier: CGFloat) {
        let scale = width ? (size.width * multiplier) / self.frame.size.width : (size.height * multiplier) / self.frame.size.height
        self.setScale(scale)
    }
    
}
