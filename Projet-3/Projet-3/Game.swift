//
//  Game.swift
//  Projet-3
//
//  Created by MacBook DS on 17/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

class Game {
    
    
    var selectedCharacter: Character?
    var opponent: Character?
    var team : Character?
    var assailant: Character?
    var comrade: Character?
    var team1: [Character] = []
    var team2: [Character] = []
    static var names = [String]()
    
    // This method checks whether the name is unique or not
    
    static func verifyUniqueName(_ name : String) -> Bool {
        var unique = true
        for chosenName in names {
            if chosenName.capitalized == name.capitalized {
                unique = false
                print("Ce nom est déjà pris, choisis-en un autre.")
                break
            }
        }
        if unique {
            names.append(name)
        }
        return unique
    }
    
    // This is the combat method, after an assailant has been chosen
    
    func fight() {
        
        assailant?.attack(opponent: opponent!)
    }
    
    // This is the method that makes a chest appear randomly
    
    func random() {
        let randomNumber = Int(arc4random_uniform(2))
        if randomNumber == 1 {
            
            if assailant?.type != CharacterType.Spectrum {
                assailant?.weapon = (assailant?.chest)!
                if assailant?.type != CharacterType.Magus {
                    print("Félicitations \(String(describing: assailant?.name)), vous recevez le coffre de la gloire! Il contient l'arme de la destruction. Votre adversaire n'a aucune chance!")
                } else {
                    print("Félicitations, le coffre de la gloire offre à votre Mage une baguette plus puissante, son pouvoir de guérison est multiplié.")
                }
            }
        }
    }
    
    // This is the method that checks whether the health points of all the characters of the same team is at the maximum or not
    
    func checkIfMyTeamIsAtMaxLife (for player: Player, in team: [Character]) {
        
        if assailant?.type == CharacterType.Magus && team[0].life >= team[0].initialLife && team[1].life >= team[1].initialLife && team[2].life >= team[2].initialLife {
            repeat {
                print("Tes personnages sont tous au niveau de vie maximum, choisis plutôt un autre personnage:")
                assailant = player.selectCharacter(in: team)
            } while assailant?.type == CharacterType.Magus
        }
    }
    
    // This is the method that checks certain conditions before a healing of the magus
    
    func checkBeforeCure (for player: Player, in team: [Character]) {
        
        if (assailant?.type == CharacterType.Magus && comrade?.name == assailant?.name) {
            
            repeat{
                if comrade?.type == CharacterType.Magus {
                    print("Tu ne peux pas te guérir toi-même.")
                    print("Choisis qui tu veux guérir:")
                    comrade = player.selectCharacter(in: team)
                }
                
            } while (assailant?.type == CharacterType.Magus && comrade?.name == assailant?.name)
        }
        
        // If the condition is excluded then the magus heals his comrade
        
        if (assailant?.type == CharacterType.Magus && comrade?.name != assailant?.name) {
            assailant?.Healing(comrade: comrade!)
        }
    }
    
    // The method relating to the course of the game
    
    func runGame() {
        
        let player1 = Player()
        let player2 = Player()
        
        // Both players make up their team
        
        team1 = player1.createTeam()
        team2 = player2.createTeam()
        
        repeat{
            if team1[0].life > 0 || team1[1].life > 0 || team1[2].life > 0 {
                
                print("\(player1.playerName[0]) - Choisissez avec qui vous voulez jouer.")
                // The player choses an assailant
                
                assailant = player1.selectCharacter(in: team1)
                
                // It checks, if the selected character is a magus, that his comrades do not have the maximum of health points
                
                checkIfMyTeamIsAtMaxLife(for: player1, in: team1)
                
                // If the selected character is a magus, then the player choses a comrade to heal
                
                if assailant?.type == CharacterType.Magus{
                    print("Choisissez un camarade à guérir:")
                    comrade = player1.selectCharacter(in: team1)
                    
                    checkBeforeCure(for: player1, in: team1)
                    
                } else {
                    
                    // If the selected character is not a magus, then the player choses an opponent to fight
                    
                    random()
                    print("\(player1.playerName[0]) - Choisissez celui que vous souhaitez attaquer:")
                    opponent = player1.selectCharacter(in: team2)
                    fight()
                }
                
            } else {
                
                // When the health points of all characters is zero, the game ends and the opposing player wins
                
                if team1[0].life == 0 && team1[1].life == 0 && team1[2].life == 0 {
                    print("\(player2.playerName[0]) a gagné")
                    break
                }
            }
            
            
            if team2[0].life > 0 || team2[1].life > 0 || team2[2].life > 0 {
                print("\(player2.playerName[0]) - Choisissez avec qui vous voulez jouer.")
                assailant = player2.selectCharacter(in: team2)
                
                checkIfMyTeamIsAtMaxLife(for: player2, in: team2)
                
                if assailant?.type == CharacterType.Magus {
                    print("\(player2.playerName[0]) - Choisissez un camarade à guérir:")
                    comrade = player2.selectCharacter(in: team2)
                    
                    checkBeforeCure(for: player2, in: team2)
                    
                } else {
                    random()
                    print("\(player2.playerName[0]) - Choisissez celui que vous souhaitez attaquer:")
                    opponent = player2.selectCharacter(in: team1)
                    fight()
                }
            } else {
                if team2[0].life == 0 && team2[1].life == 0 && team2[2].life == 0 {
                    print("\(player1.playerName[0]) a gagné")
                    break
                }
            }
            
        } while (team1[0].life > 0 || team1[1].life > 0 || team1[2].life > 0) && (team2[0].life > 0 || team2[1].life > 0 || team2[2].life > 0)
    }
}

