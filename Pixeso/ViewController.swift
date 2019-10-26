//
//  ViewController.swift
//  Pixeso
//
//  Created by Mohammed Hamendi on 28/09/2019.
//  Copyright © 2019 Mohammed Hamendi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairs: (cardsColl.count + 1) / 2)

    var flipCount = 0 {
        didSet{
            flipsLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardsColl: [UIButton]!
    @IBOutlet weak var flipsLabel: UILabel!
    
    @IBAction func newGameBtn(_ sender: UIButton) {
        print("Starting new game...")
        theme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        colorFore = theme.colorFore
        colorBack = theme.colorBack
        emoji.removeAll()
        emojisChoices = theme.emo
        view.backgroundColor = colorBack
        flipsLabel.textColor = colorFore
        sender.backgroundColor = colorFore
        sender.setTitleColor(colorBack, for: UIControl.State.normal)
        game.reset()
        flipCount = 0
        updateViewFromModel()
    }
    
    @IBAction
    func touchedCard(_ sender: UIButton) {
        if sender.backgroundColor == colorFore {
           flipCount += 1
        }
        if let cardId = cardsColl.index(of: sender) {
            game.chooseCard(at: cardId)
            updateViewFromModel()
        } else {
            print("Chosen card \(sender) was not in cardsColl")
        }
    }
    
    func updateViewFromModel() {
        for idx in cardsColl.indices {
            let btn = cardsColl[idx]
            let card = game.cards[idx]
            if (card.isFaceUp) {
                btn.setTitle(emoji(for: card), for: UIControl.State.normal)
                btn.backgroundColor =  UIColor.white
            } else {
                btn.setTitle("", for: UIControl.State.normal)
                btn.backgroundColor = card.isMatched ? colorBack : colorFore
            }
        }
    }
    
    var themeHalloween = (emo: ["👻","🕷","🎃","🧛‍♂️","👽","💀"], colorFore: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), colorBack: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    var themeFlags = (emo: ["🇺🇸","🇷🇺","🇯🇲","🇩🇪","🇨🇦","🇨🇳"], colorFore: #colorLiteral(red: 0.5924016497, green: 0.5569833456, blue: 0.09144155235, alpha: 1), colorBack: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var themeSmiley = (emo: ["😀","☹️","😉","😛","😉","😎"], colorFore: #colorLiteral(red: 0.4787765332, green: 0.169928175, blue: 0.4968075825, alpha: 1), colorBack: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
    var themeGestures = (emo: ["👊","🤛","🤞","✌️","👍","🤟"], colorFore: #colorLiteral(red: 0.960878014, green: 0.7842732944, blue: 0.5994443049, alpha: 1), colorBack: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
    var themeJobs = (emo: ["👷‍♂️","👩‍⚕️","👨‍🎓","👩‍✈️","👨‍🚒","👩‍🍳"], colorFore: #colorLiteral(red: 0.6812708684, green: 1, blue: 0.6804883862, alpha: 1), colorBack: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    var themeAnimals = (emo: ["🦍","🐪","🦒","🐑","🐅","🦃"], colorFore: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), colorBack: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    
    lazy var themes = [themeHalloween, themeFlags, themeSmiley,
                         themeGestures, themeJobs, themeAnimals]
    
    var theme : (emo: [String], colorFore: UIColor, colorBack: UIColor)!
    var colorFore = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    var colorBack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var emojisChoices = ["👻","🕷","🎃","🧛‍♂️","👽","💀"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if (emoji[card.id] == nil && emojisChoices.count > 0) {
            let randomIndex = Int(arc4random_uniform(UInt32(emojisChoices.count)))
            print("random idx: \(randomIndex) and Card ID \(card.id)")
            emoji[card.id] = emojisChoices.remove(at: randomIndex)
        }
        print("Card ID \(card.id)")
        return emoji[card.id] ?? "?"
    }
    
}

