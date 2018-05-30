//
//  Game.swift
//  Projet-3
//
//  Created by MacBook DS on 17/05/2018.
//  Copyright © 2018 Djilali Sakkar. All rights reserved.
//

import Foundation

// This class contains the methods and properties for the running of the game

internal class Game {
    
    var selectedCharacter: Character? // The selected character is the one chosen fot the running of the game, fighting or healing
    fileprivate var opponent: Character? // The opponent is the one we're fighting
    var team : Character? // The team the player will have created for himself
    fileprivate var assailant: Character? // The assailant is the one who is chosen to attack or heal
    fileprivate var comrade: Character? // The comrade is the one who is cured
    fileprivate var team1: [Character] = [] // This is the player 1's team
    fileprivate var team2: [Character] = [] // This is the player 2's team
    static var names = [String]() // The names chosen by the players
    
    // This method checks whether the name is unique or not
    
    static func verifyUniqueName(_ name : String) -> Bool {
        var unique = true
        for chosenName in names {
            if chosenName.capitalized == name.capitalized {
                unique = false
                print("Ce nom est déjà pris, choisissez-en un autre.")
                break
            }
        }
        if unique {
            names.append(name)
        }
        return unique
    }
    
    // This is the combat method, after an assailant has been chosen
    
    fileprivate func fight() {
        
        assailant?.attack(opponent: opponent!)
    }
    
    // This is the cure method, after a comrade has been chosen
    
    fileprivate func cure() {
        
        assailant?.Healing(comrade: comrade!)
    }
    
    // This is the method that makes a chest appear randomly
    
    fileprivate func random() {
        let randomNumber = Int(arc4random_uniform(2))
        if randomNumber == 1 {
            
            if assailant?.type != CharacterType.Spectrum && assailant?.weapon.damage != assailant?.chest.damage {
                assailant?.weapon = (assailant?.chest)!
                if assailant?.type != CharacterType.Magus {
                    if let name = assailant?.name {
                    print("Félicitations \(name), vous recevez le coffre de la gloire! Il contient l'arme de la destruction. Votre adversaire n'a aucune chance!")
                    }
                } else {
                    if let name = assailant?.name {
                    print("Félicitations \(name), le coffre de la gloire vous offre une baguette plus puissante, votre pouvoir de guérison est multiplié.")
                    }
                }
            }
        }
    }
    
    
    // The method relating to the course of the game
    
    internal func runGame() {
        
        // Two players are created
        
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
                
                // If the selected character is a magus, then the player choses a comrade to heal
                
                if assailant?.type == CharacterType.Magus{
                    random()
                    print("Qui voulez-vous soigner ?")
                    comrade = player1.selectCharacter(in: team1)
                    cure()
                    
                } else {
                    
                    // If the selected character is not a magus, then the player choses an opponent to fight
                    
                    random()
                    print("\(player1.playerName[0]) - Choisissez celui que vous souhaitez attaquer:")
                    opponent = player1.selectCharacter(in: team2)
                    fight()
                }
            }
                // When the health points of all characters is zero, the game ends and the opposing player wins
                
                if team1[0].life <= 0 && team1[1].life <= 0 && team1[2].life <= 0 {
                    print("Félicitations \(player2.playerName[0]), vous avez gagné!")
                    break
                }
            
            
            if team2[0].life > 0 || team2[1].life > 0 || team2[2].life > 0 {
                print("\(player2.playerName[0]) - Choisissez avec qui vous voulez jouer.")
                assailant = player2.selectCharacter(in: team2)
                
                if assailant?.type == CharacterType.Magus {
                    random()
                    print("\(player2.playerName[0]) - Qui voulez-vous soigner ?")
                    comrade = player2.selectCharacter(in: team2)
                    cure()
                  
                } else {
                    random()
                    print("\(player2.playerName[0]) - Choisissez celui que vous souhaitez attaquer:")
                    opponent = player2.selectCharacter(in: team1)
                    fight()
                }
            }
                if team2[0].life <= 0 && team2[1].life <= 0 && team2[2].life <= 0 {
                    print("Félicitations \(player1.playerName[0]), vous avez gagné!")
                    break
                }
            
            
        } while (team1[0].life > 0 || team1[1].life > 0 || team1[2].life > 0) && (team2[0].life > 0 || team2[1].life > 0 || team2[2].life > 0)
    }
}

