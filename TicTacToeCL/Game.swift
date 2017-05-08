//
//  Game.swift
//  ticTacToeCL
//
//  Created by Alisher Abdukarimov on 5/8/17.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

import Foundation

struct Game {
    
    let playerXname = getStringFromUser(prompt: "What is player X's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
    let playerOname = getStringFromUser(prompt: "What is player O's name?", failureMessage: "Please Enter you name", predicate: { $0.isEmpty == false } )
    
    var board = BoardState([:])
    var lastMove: Symbol?
    var turn: Bool = true
    
    
    mutating func play() {
        
        if winner(moves: board.storage) == .x {
            print("\(playerXname):\(Symbol.x.description) wins")
            restart()
        }else if winner(moves: board.storage) == .o {
            print("\(playerOname):\(Symbol.o.description) wins")
            restart()
        }else{
            if turn == true {print("\(playerXname)'s turn please choose a move")
            }else{
            print("\(playerOname)'s turn please choose a move")
            }
        }
        
        guard checkDraw() != (true, "Game tied") else {
            print(board.description)
            restart()
            return print("Game Tied want to play again")
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
            if turn == true{
                self.board.storage[0] = (.x); self.turn = false }
            else{ self.board.storage[0] = (.o); self.turn = true}
            return play()
        case "for upper middle":
            if turn == true{
                self.board.storage[1] = (.x); self.turn = false }
            else{ self.board.storage[1] = (.o); self.turn = true}
            return play()
        case "for the right top corner":
            if turn == true{
                self.board.storage[2] = (.x); self.turn = false }
            else{ self.board.storage[2] = (.o); self.turn = true}
            return play()
        case "for the middle left corner":
            if turn == true{
                self.board.storage[3] = (.x); self.turn = false }
            else{ self.board.storage[3] = (.o); self.turn = true}
            return play()
        case "for the center":
            if turn == true{
                self.board.storage[4] = (.x); self.turn = false }
            else{ self.board.storage[4] = (.o); self.turn = true}
            return play()
        case "for the middle right corner":
            if turn == true{
                self.board.storage[5] = (.x); self.turn = false }
            else{ self.board.storage[5] = (.o); self.turn = true}
            return play()
        case "for the left lower corner":
            if turn == true{
                self.board.storage[6] = (.x); self.turn = false }
            else{ self.board.storage[6] = (.o); self.turn = true}
            return play()
        case "for the lower middle":
            if turn == true{
                self.board.storage[7] = (.x); self.turn = false }
            else{ self.board.storage[7] = (.o); self.turn = true}
            return play()
        case "for the lower right":
            if turn == true{
                self.board.storage[8] = (.x); self.turn = false }
            else{ self.board.storage[8] = (.o); self.turn = true}
            return play()
        default:
            return print("This should not happen")
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
    
    mutating func restart() -> Bool {
        
        let choice = getChoiceFromUser(prompt: "Would you like to play again?\n",
                                       choices: [
                                        "yes",
                                        "no"
            ])
        
        switch choice {
        case "Yes":
            self.board.storage.removeAll()
            return true
        case "No":
            self.board.storage.removeAll()
            print("Thank you for playing TicTacToe")
            return true
        default:
            print("Should not happen")
        }
        //this could go wrong
        return false
    }
    
}
