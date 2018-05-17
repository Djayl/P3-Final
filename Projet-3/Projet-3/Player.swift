//
//  Player.swift
//  Projet-3
//
//  Created by MacBook DS on 17/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

class Player {
    var playerName: [String] = []
    var team: [Character] = []
    var teamName: [String] = []
    var numberOfCharacter = 0
    var selectedCharacter: Character?
    
    
    // The player names himself
    
    func playerNamesHimSelf() {
        
        if let yourName = readLine() {
            playerName.append(yourName)
            print("Bienvenue, \(playerName[0]).")
        }
    }
    // The player names his team
    
    func playerNamesHisTeam(){
        
        if let yourTeam = readLine() {
            teamName.append(yourTeam)
            print("Votre équipe se nomme: \(teamName[0]), vous allez choisir 3 personnages:")
        }
    }
    
    // The player creates his team, choosing three characters in a list of five types of characters
    
    func createTeam () -> [Character]  {
        let characterType = ["combattant", "nain", "colosse", "mage", "Spectre"]
        var numberOfCharacter = 0
        
        
        print("Bonjour, entrez votre nom:")
        playerNamesHimSelf()
        print("\(playerName[0]), nommez votre équipe:")
        playerNamesHisTeam()
        
        // The description of each character is presented to the player
        
        print("\(playerName[0]) - Choisissez un personnage:"
            
            + "\n1. Le combattant est un excellent guerrier. Rapide et puissant, il est armé d'une épée qui fera perdre à votre adversaire 10 points de vie à chaque coup. Son niveau de vie de départ est de 100 points."
            
            
            + "\n2. Le nain est un guerrier redoutable. Particulièrement puissant, sa hache est redoutée par tous. Elle ôtera 25 points de vie à votre adversaire. Son point faible? Sa faible résistance. En effet, il ne part qu'avec 50 points de vie."
            
            
            + "\n3. Le Colosse est un guerrier légendaire. Imposant et très résistant, son niveau de vie de départ est de 150 points. Cependant, la massue dont il est armé n'infligera que 5 points de dégâts à votre adversaire."
            
            
            + "\n4. Le mage n'a rien d'un guerrier. Son talent: guérir ses camarades. Choisissez-le et vous pourrez redonner 10 points de vie à l'un des membres de votre équipe. Mais souvenez-vous! Il n'a rien d'un guerrier et son niveau de vie n'est que de 50 points."
            
            
            + "\n5. Le spectre est un guerrier d'un autre monde. Invoquez-le et il apparaitra pour foudroyer son adversaire. Sa particularité? Il n'apparait qu'une fois. Une seule et unique attaque pour terrasser son opposant et il disparait aussitôt.")
        
        repeat{
            for (index, value) in characterType.enumerated() {
                print("\(index + 1): \(value)")
            }
            
            if let choice = readLine(){
                switch choice {
                    
                case "1":
                    
                    print(" \(playerName[0]), nommez votre personnage: ")
                    while let name = readLine() {
                        let uniqueName = Game.verifyUniqueName(name)
                        if uniqueName == true {
                            let fighter = Character(name: name, type: .Fighter)
                            numberOfCharacter += 1
                            team.append(fighter)
                            break
                        }
                    }
                case "2":
                    
                    print("\(playerName[0]), nommez votre personnage:")
                    while let name = readLine() {
                        let uniqueName = Game.verifyUniqueName(name)
                        if uniqueName == true {
                            let dwarf = Character(name: name, type: .Dwarf)
                            numberOfCharacter += 1
                            team.append(dwarf)
                            break
                        }
                    }
                case "3":
                    
                    print("\(playerName[0]), nommez votre personnage:")
                    while let name = readLine() {
                        let uniqueName = Game.verifyUniqueName(name)
                        if uniqueName == true {
                            let colossus = Character(name: name, type: .Colossus)
                            numberOfCharacter += 1
                            team.append(colossus)
                            break
                        }
                    }
                case "4":
                    
                    print("\(playerName[0]), nommez votre personnage:")
                    while let name = readLine() {
                        let uniqueName = Game.verifyUniqueName(name)
                        if uniqueName == true {
                            let magus = Character(name: name, type: .Magus)
                            numberOfCharacter += 1
                            team.append(magus)
                            break
                        }
                    }
                case "5":
                    
                    print("\(playerName[0]), nommez votre personnage:")
                    while let name = readLine() {
                        let uniqueName = Game.verifyUniqueName(name)
                        if uniqueName == true {
                            let spectrum = Character(name: name, type: .Spectrum)
                            numberOfCharacter += 1
                            team.append(spectrum)
                            break
                        }
                    }
                default: print("Je ne comprends pas")
                }
                
            }
            if numberOfCharacter < 3{
                print("\(playerName[0]) - Choisissez un autre personnage:")
            }
            
          
            
        } while numberOfCharacter < 3
        
        return team
    }
    
    // This is the method to choose a character for fighting or healing
    
    func selectCharacter(in team: [Character]) -> Character {
        var selectedCharacter: Character?
        var validChoice = false
        var team = team
        
        
        for i in 0..<team.count {
            if team[i].life > 0 {
                print("\(i+1). \(team[i].name), type: \(team[i].type.rawValue), niveau de vie: \(team[i].life), puissance d'attaque: \(team[i].weapon.damage), niveau de guérison: \(team[i].weapon.cure)")
                
            }
        }
        repeat{
            if let choiceNumber = Int(readLine()!){
                if choiceNumber <= team.count {
                    selectedCharacter = team[choiceNumber - 1]
                    if (selectedCharacter?.life)! > 0 {
                        validChoice = true
                    }else {
                        print("Choisissez un chiffre valide")
                        validChoice = false
                    }
                }
            }
            
        } while validChoice == false
        
        return selectedCharacter!
    }
    
    
}

