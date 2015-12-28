//
//  ViewController.swift
//  WordGame
//
//  Created by Max Lampert on 12/20/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import UIKit

class LetterBlockCell: UICollectionViewCell {
    @IBOutlet weak var m_letterBlock: UIButton!
    var m_index: Int?
}

class LetterBlockCollectionVC: UICollectionViewController {

    private let m_cellWidth = 50
    private let m_cellHeight = 50
    var m_charGrid: [String]!
    var m_letterButtonArray: [UIButton] = []
    var m_chosenString: String {
        var ret: String = ""
        for _letterButton in m_letterButtonArray {
            ret = ret + _letterButton.titleLabel!.text!
        }
        return ret
    }
    var m_answerText: UILabel!
    var m_scoreText: UILabel!
    var m_currentScore: Int! = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Got memory warning")
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: LetterBlockCell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("LetterBlockCell", forIndexPath: indexPath) as! LetterBlockCell
        cell.m_letterBlock.setTitle(self.m_charGrid[indexPath.row], forState: .Normal)
        cell.m_letterBlock.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cell.m_letterBlock.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor()), forState: .Normal)
        cell.m_letterBlock.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        cell.m_letterBlock.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor()), forState: .Selected)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.grayColor().CGColor
        //        cell.layer.cornerRadius = 5
        cell.m_index = indexPath.row
        return cell
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_charGrid.count
    }

    func clearBoard() {
        var cellCount: Int = self.collectionView!.numberOfItemsInSection(0)
        while(cellCount >= 0) {
            if let _cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow: cellCount, inSection: 0)) as? LetterBlockCell {
                _cell.m_letterBlock.selected = false
            }
            cellCount -= 1
        }
        WordList.s_wordList.setChosenWord("")
        m_letterButtonArray.removeAll()
        self.collectionView?.reloadData()
    }

    func checkChosenWord() {
        m_answerText.hidden = false
        if(WordList.s_wordList.isChosenWordCorrect()) {
            m_answerText.text = "\(m_chosenString): SUCCESS"
            m_currentScore = m_currentScore + Letters.getWordScore(m_chosenString)
            m_scoreText.text = "Score: \(m_currentScore)"
            for _letterButton in m_letterButtonArray {
                if let _letterCell = _letterButton.superview?.superview as? LetterBlockCell {
                    m_charGrid[_letterCell.m_index!] = Letters.getNewLetter()
                    _letterButton.setBackgroundImage(UIImage.imageWithColor(UIColor.greenColor()), forState: .Selected)
                    UIView.transitionWithView(_letterButton, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
                        _letterButton.setTitle(self.m_charGrid[_letterCell.m_index!], forState: .Normal)
                        }, completion: { (_) in
                            self.clearBoard()
                    })
                }
            }
        } else {
            m_answerText.text = "\(m_chosenString): FAILURE"
            for _letterButton in m_letterButtonArray {
                _letterButton.setBackgroundImage(UIImage.imageWithColor(UIColor.redColor()), forState: .Selected)
            }
            NSTimer.schedule(delay: 0.25) { (_) in
                // show red for 0.25 sec then clear board
                self.clearBoard()
            }
        }
    }

    func selectedLetter(sender: UIButton) {
        if(sender.selected == false) {
            sender.selected = true
            m_letterButtonArray.append(sender)
            WordList.s_wordList.setChosenWord(m_chosenString)
        }
    }

    @IBAction func panGestureMoved(sender: UIGestureRecognizer) {

        if(sender.state == UIGestureRecognizerState.Ended) {
            checkChosenWord()
        } else {
            let view = sender.view
            let touchPos = sender.locationInView(view)
            let subView = view?.hitTest(touchPos, withEvent: nil)

            if let _button = subView as? UIButton {
                selectedLetter(_button)
            }
        }
    }

    @IBAction func letterBlockCallback(sender: UIButton, withEvent: UIEvent) {
        print("crossing \(sender.titleLabel!.text!) for \(withEvent.type)")
    }
}

