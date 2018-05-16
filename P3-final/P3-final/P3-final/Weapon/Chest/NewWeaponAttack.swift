//
//  NewWeaponAttack.swift
//  P3-final
//
//  Created by MacBook DS on 16/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

// This weapon is in the chest that appears randomly for all the characters except the magus

class NewWeaponAttack: Weapon {
    init() {
        super.init(damage: 50, cure: 0)
    }
}
