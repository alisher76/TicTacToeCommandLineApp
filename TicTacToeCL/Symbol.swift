//
//  Symbol.swift
//  ticTacToeCL
//
//  Created by TJ Usiyan on 2017/04/20.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

enum Symbol : CustomStringConvertible {
    case x
    case o
    
    init?(space: Space) {
        switch space {
        case .e:
            return nil
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
        }
    }


}

