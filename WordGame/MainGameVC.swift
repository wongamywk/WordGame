//
//  MainGameVC.swift
//  WordGame
//
//  Created by Max Lampert on 12/20/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import Foundation
import UIKit

class MainGameVC: UIViewController  {

    @IBOutlet weak var m_gameContainerView: UIView!
    private var m_charGrid: [String] = []
    var m_gameBoard: LetterBlockCollectionVC!
    @IBOutlet weak var m_successText: UILabel!
    @IBOutlet weak var m_scoreText: UILabel!

    override func viewDidLoad() {
        resetBoard()
        clearBoard()
        m_successText.hidden = true
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "EmbedGameBoardSegue") {
            let gameBoardVC = segue.destinationViewController as? LetterBlockCollectionVC
            m_gameBoard = gameBoardVC
            gameBoardVC?.m_answerText = m_successText
            gameBoardVC?.m_scoreText = m_scoreText
        }
    }

    @IBAction func checkWord(sender: UIButton) {
        if(WordList.s_wordList.isChosenWordCorrect()) {
            m_successText.text = "SUCCESS"
        } else {
            m_successText.text = "FAILURE"
        }
        m_successText.hidden = false
    }

    @IBAction func resetBoard(sender: UIButton) {
        resetBoard()
        m_successText.hidden = true
    }

    func resetBoard() {
        m_charGrid.removeAll()
        var charGridCount: Int = 10 * 6
        while(charGridCount > 0) {
            m_charGrid.append(Letters.getNewLetter())
            charGridCount -= 1
        }
        m_gameBoard.m_charGrid = m_charGrid
        m_gameBoard.m_letterButtonArray.removeAll()
        m_gameBoard.m_currentScore = 0
        m_scoreText.text = "Score: \(m_gameBoard.m_currentScore)"
        m_gameBoard.clearBoard()
        m_gameBoard.collectionView?.reloadData()
    }

    func clearBoard() {
        m_gameBoard.m_letterButtonArray.removeAll()
        m_gameBoard.clearBoard()
        m_gameBoard.collectionView?.reloadData()
    }
}