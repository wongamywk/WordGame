//
//  WordList.swift
//  WordGame
//
//  Created by Max Lampert on 12/20/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import Foundation

class WordList {

    static var s_wordList: WordList = WordList()
    private var m_wordList: [String]! = []
    private var m_chosenWord: String?

    init() {
        let bundle = NSBundle.mainBundle()
        let file = bundle.pathForResource("wordlist", ofType: "txt")
        //reading
        do {
            let text2 = try NSString(contentsOfFile: file!, encoding: NSUTF8StringEncoding)
            text2.enumerateLinesUsingBlock() { (line, _) in
                self.m_wordList.append(line.lowercaseString)
            }
        }
        catch {
            print("Failed to open and read wordlist.txt")
        }
    }

    func isWord(word: String) -> Bool {
        return m_wordList.contains(word.lowercaseString)
    }

    func isChosenWordCorrect() -> Bool {
        if let _chosenWord = m_chosenWord {
            return m_wordList.contains(_chosenWord.lowercaseString)
        }
        return false
    }

    func setChosenWord(word: String) {
        m_chosenWord = word
    }

    func getChosenWord() -> String? {
        return m_chosenWord
    }
}