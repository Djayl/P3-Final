//
//  Weapon.swift
//  Projet-3
//
//  Created by MacBook DS on 17/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

// Weapon is a superclass, all classes relating to weapons (Ax, Lightning, Mace, Sword and Wand) inherit from Weapon class

class Weapon {
    var damage: Int // The damage caused by the weapon of a character
    var cure: Int // The cure applied by the magus
    init(damage: Int, cure: Int) {
        self.damage = damage
        self.cure = cure
    }
}
