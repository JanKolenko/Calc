//
//  ViewController.swift
//  Kalkulator
//
//  Created by Jan Kolenko on 18/01/2018.
//  Copyright © 2018 Jan Kolenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel! // Prikaz kalkuliranja - label
    
    private var isUserTypingDigits: Bool = false
    
    // Za lažje pridobivanje in izpsiovanje uporabnikovega tipkanja
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    
    // Če pritisnemo na cifro naredi
    @IBAction private func TouchedDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isUserTypingDigits {
            let displayedText = display.text!
            display.text = displayedText + digit
        } else {
            display.text = digit
        }
        
        isUserTypingDigits = true // Nastavimo na koncu, da se pri kalkuliranju zbrišejo prejšne cifre
    }
    
    private var calculator = Calculator() // Povezava z logiko - kalkuliranjem

    // Če pritisnemo na operacijo naredi
    @IBAction private func PerformCalculation(_ sender: UIButton) {
        // Nastavimo vrednost
        if isUserTypingDigits {
            calculator.setValue(value: displayValue)
        }
        
        isUserTypingDigits = false
        if let symbol = sender.currentTitle {
            calculator.doCalculation(symbol: symbol)
        }
        
        displayValue = calculator.result
        
    }
    
}

