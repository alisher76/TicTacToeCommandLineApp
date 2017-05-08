//
//  BoardState.swift
//  ticTacToeCL
//
//  Created by TJ Usiyan on 2017/04/20.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

struct BoardState : CustomStringConvertible {
    typealias Storage = [Int:Symbol]
    var storage: Storage



    init(_ moves: Storage) {
        let validMoves = moves.filter { (key, _) in
            return key >= 0 && key <= 8
        }
        precondition(validMoves.count == moves.count, "invalid move given")

        self.storage = moves
    }

    var description: String {
        var rows: [String] = []

        //   0 | 1 | 2
        //  ---+---+---
        //   3 | 4 | 5
        //  ---+---+---
        //   6 | 7 | 8
        for row in 0..<3 {
            let rowOffset = row * 3
            let leftKey     = rowOffset + 0
            let centerKey   = rowOffset + 1
            let rightKey    = rowOffset + 2

            let left = storage[leftKey]
            let center = storage[centerKey]
            let right = storage[rightKey]

            let leftString = left?.description ?? " "
            let centerString = center?.description ?? " "
            let rightString = right?.description ?? " "

            rows.append(" \(leftString) | \(centerString) | \(rightString) \n")
        }

        return rows.joined(separator: "---+---+---\n")
    }
}
