//
//  AppDelegate.swift
//  TicTacToeCL
//
//  Created by Alisher Abdukarimov on 5/8/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var game = Game()
    
    
    let hasNonWhitespaceCharacters: (String) -> Bool = { input in
        
        let whitespaceCharacters = CharacterSet.whitespacesAndNewlines
        
        let filtered = input.unicodeScalars.filter { char in
            whitespaceCharacters.contains(char) == false
        }
        
        return filtered.isEmpty == false
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Insert code here to initialize your application
       game.play()
    }

   


}

