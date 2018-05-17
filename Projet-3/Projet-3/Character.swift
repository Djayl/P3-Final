//
//  Character.swift
//  Projet-3
//
//  Created by MacBook DS on 17/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

// Enumeration for the type of the characters

enum CharacterType : String {
    case Dwarf = "Nain"
    case Colossus = "Colosse"
    case Magus = "Mage"
    case Fighter = "Combattant"
    case Spectrum = "Spectre"
    
}

class Character {
    
    
    var type: CharacterType
    var weapon: Weapon
    var life: Int
    var name: String
    var chest: Weapon // The chest contains the new weapon which appears randomly thanks to the method Random in the Game Class
    var initialLife: Int // This property is necessary for some magus methods in the Game class
    
    
    init(name: String, type: CharacterType){
        self.type = type
        self.name = name
        
        switch self.type {
        case .Fighter:
            self.life = 100
            self.weapon = Sword()
            self.chest = NewWeaponAttack()
            self.initialLife = 100
            
        case .Colossus:
            self.life = 150
            self.weapon = Mace()
            self.chest = NewWeaponAttack()
            self.initialLife = 150
            
        case .Dwarf:
            self.life = 50
            self.weapon = Ax()
            self.chest = NewWeaponAttack()
            self.initialLife = 50
            
        case .Magus:
            self.life = 50
            self.weapon = Wand()
            self.chest = NewWeaponCure()
            self.initialLife = 50
            
        case .Spectrum:
            self.life = 1
            self.weapon = Lightning()
            self.chest = NewWeaponAttack()
            self.initialLife = 1
            
        }
    }
    
    // The attack method, one for all the characters except the magus
    
    func attack(opponent: Character){
        if type != .Spectrum {
            opponent.life -= weapon.damage
            
            // To avoid having a negative health points we add this condition
            
            if opponent.life < 0 {
                opponent.life = 0
                print("\(opponent.name) est mort.")
            }
            if opponent.life > 0 {
                print("Vous avez attaqué \(opponent.name), \(opponent.name) a désormais \(opponent.life) points de vie")
            }
        }
        // The spectrum is a particular character, so when he attacked, he disappears
        
        if type == .Spectrum {
            opponent.life -= weapon.damage
            life = 0
            if opponent.life < 0 {
                opponent.life = 0
            }
            print("Votre spectre a foudroyé \(opponent.name). \(opponent.name) est mort et \(name) s'en est allé.")
        }
    }
    
    // This method is reserved for the magus, so that he can heal his comrades
    
    func Healing(comrade: Character) {
        if comrade.life > 0 {
            comrade.life += weapon.cure
            print("\(name) guéris \(comrade.name), son niveau de vie est de \(comrade.life) points.")
        } else if comrade.life <= 0{
            print("Vous êtes mort, je ne peux pas vous réanimer.")
        }
    }
    
}
