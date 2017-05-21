//
//  Game.swift
//  ticTacToeCL
//
//  Created by Alisher Abdukarimov on 5/8/17.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

import Foundation

struct Game {
    
    var playerXname = getStringFromUser(prompt: "What is player X's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
    var playerOname = getStringFromUser(prompt: "What is player O's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
    
    var board = BoardState([:])
    var turn: Bool = true
    var spot: Bool = true
    
    mutating func play() {
        
        if winner(moves: board.storage) == .x {
            print("\(playerXname): \(Symbol.x.description.capitalized) wins. \n\(board.description)")
            restart()
        }else if winner(moves: board.storage) == .o {
            print("\(playerOname): \(Symbol.o.description.capitalized) wins. \n\(board.description)")
            restart()
        }else{
            if turn == true {print("\(playerXname)'s turn please choose a move")
            }else if turn == false && checkDraw() != (true, "Game tied"){
                print("\(playerOname)'s turn please choose a move")
            }
        }
        
        guard checkDraw() != (true, "Game tied") else {
            print("Game between \(playerXname) & \(playerOname) tied.\n\(board.description)")
            restart()
            return
        }
        
        
        
        let choice = getChoiceFromUser(prompt: "\(board.description)\n",
            choices: [
                "for the left top corner",
                "for upper middle",
                "for the right top corner",
                "for the middle left corner",
                "for the center",
                "for the middle right corner",
                "for the left lower corner",
                "for the lower middle",
                "for the lower right"
            ])
        
        
        switch choice {
        case "for the left top corner":
            putInputOnABoard("for the left top corner")
            return play()
        case "for upper middle":
            putInputOnABoard("for upper middle")
            return play()
        case "for the right top corner":
            putInputOnABoard("for the right top corner")
            return play()
        case "for the middle left corner":
            putInputOnABoard("for the middle left corner")
            return play()
        case "for the center":
            putInputOnABoard("for the center")
            return play()
        case "for the middle right corner":
            putInputOnABoard("for the middle right corner")
            return play()
        case "for the left lower corner":
            putInputOnABoard("for the left lower corner")
            return play()
        case "for the lower middle":
            putInputOnABoard("for the lower middle")
            return play()
        case "for the lower right":
            putInputOnABoard("for the lower right")
            return play()
        default:
            return print("This should not happen")
        }
        
    }
    
    mutating func putInputOnABoard(_ choice: String) {
        
        let selectedChoice = getTheChoosenNumber(choice)
        checkTheGridSpot(selectedChoice - 1)
        var symbol: Symbol
        
        switch turn {
        case true:
            symbol = .x
        case false:
            symbol = .o
        }
        if spot == true {
            self.board.storage[selectedChoice - 1] = symbol
            if turn == true {turn = false}else{turn = true}
        }
        
    }
    
    mutating func checkTheGridSpot(_ spot: Int) {
        
        if self.board.storage[spot] == .x || self.board.storage[spot] == .o  {
            print("please enter another spot this one is taken")
            if turn == true {turn = true}else{turn = false}
            self.spot = false
        }else{
            self.spot = true
        }
        
    }
    
    func evaluate(_ moveSet: Set<Int>) -> Bool {
        
        let winningCombos: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        return winningCombos.contains { winner in
            moveSet.isSuperset(of: winner)
        }
    }
    
    func splitMoves(_ allMoves: [Int: Symbol]) -> (x: Set<Int>, o: Set<Int>) {
        let seed: (x: Set<Int>, o: Set<Int>) = ([], [])
        
        return allMoves.reduce(seed) { (accum, element) in
            let (location, symbol) = element
            switch symbol {
            case .x:
                let newX = accum.x.union([location])
                return (newX, accum.o)
            case .o:
                let newO = accum.o.union([location])
                return (accum.x, newO)
            }
        }
    }
    
    func winner(moves: [Int: Symbol]) -> Symbol? {
        
        let (xMoves, oMoves) = splitMoves(moves)
        if evaluate(xMoves) {
            return .x
        } else if evaluate(oMoves) {
            return .o
        } else {
            return nil
        }
    }
    
    func checkDraw() -> (Bool,String) {
        
        if self.board.storage.count == 9 {
            return (true,"Game tied")
        }else{
            return (false,"Game is still on")
        }
    }
    
    mutating func restart() {
        let choice = getChoiceFromUser(prompt: "Would you like to play again? \nChoose no if you want to change names.\n", choices: [ "yes", "no"])
        switch choice {
        case "yes":
            self.board.storage = [:]
            turn = true
            play()
        case "no":
            self.board.storage = [:]
            turn = true
            playerXname = getStringFromUser(prompt: "What is player X's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
            playerOname = getStringFromUser(prompt: "What is player O's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
            play()
        default:
            print("Should not happen")
        }
    }
    
    
    
    func getTheChoosenNumber(_ input: String) -> Int {
        
        var num = 0
        
        switch input {
        case "for the left top corner":
            num += 1
        case "for upper middle":
            num += 2
        case "for the right top corner":
            num += 3
        case "for the middle left corner":
            num += 4
        case "for the center":
            num += 5
        case "for the middle right corner":
            num += 6
        case "for the left lower corner":
            num += 7
        case "for the lower middle":
            num += 8
        case "for the lower right":
            num += 9
        default:
            break
        }
        return num
    }
    
}
