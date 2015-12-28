//
//  LetterScore.swift
//  WordGame
//
//  Created by Max Lampert on 12/22/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import Foundation

class Letters{

    class func getLetterScore(character: Character) -> Int {
        let charString = String(character)
        switch(charString.lowercaseString) {
        case "e", "a", "i", "o", "n", "r", "t", "l", "s", "u":
            return 100
        case "d","g":
            return 200
        case "b", "c", "m", "p":
            return 300
        case "f", "h", "v", "w", "y":
            return 400
        case "k":
            return 500
        case "j", "x":
            return 800
        case "q", "z":
            return 1000
        default:
            return 0

        }
    }

    class func getWordScore(word: String) -> Int {
        var score: Int = 0
        for _char in word.characters {
            score = score + getLetterScore(_char)
        }
        return score
    }

    class func getNewLetter() -> String {
        let rand: Int = Int.random(0...99)

        if(rand < 5) {
            // return Z Q X J K
            return ["Z","Q","X","J","K"].chooseOne()
        } else if(rand < 23) {
            // return B C M P F H V W Y
            return ["B","C","M","P","F", "H", "V", "W", "Y"].chooseOne()
        } else if(rand < 26) {
            // return G
            return "G"
        } else if(rand < 42) {
            // return D U S L
            return ["D", "U", "S", "L"].chooseOne()
        } else if(rand < 60) {
            // return T R N
            return ["T", "R", "N"].chooseOne()
        } else if(rand < 68) {
            // return O
            return "O"
        } else if(rand < 86) {
            // return I A
            return ["I","A"].chooseOne()
        } else {
            // return E
            return "E"
        }
    }


}