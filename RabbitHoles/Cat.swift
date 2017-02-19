//
//  Cat.swift
//  RabbitHoles
//
//  Created by Victor Huang on 2/19/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import Foundation
import SpriteKit

class Cat: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
    }
}
