//
//  Space.swift
//  ticTacToeCL
//
//  Created by TJ Usiyan on 2017/04/20.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

enum Space {
    case x
    case o
    case e // for 'empty'

    init(symbol: Symbol) {
        switch symbol {
        case .x:
            self = .x
        case .o:
            self = .o
        }
    }

    var description: String {
        switch self {
        case .x:
            return "x"
        case .o:
            return "o"
        case .e:
            return " "
        }
    }
}
