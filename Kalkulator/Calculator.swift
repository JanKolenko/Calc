//
//  Calculator.swift
//  Kalkulator
//
//  Created by Jan Kolenko on 18/01/2018.
//  Copyright © 2018 Jan Kolenko. All rights reserved.
//

import Foundation

// Tukaj se izvajajo vse operacije kalkulatorja
class Calculator {
    
    private var collector: Double = 0.0 // V currentValue se pošle cifra s katero računamo
    private var prevNumber: Double?
    private var checkIfCalculate: Bool = false
    
    // Nastavimo vrednost s katero računamo
    func setValue(value: Double) {
        collector = value
    }
    
    func Plus(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }
    
    func Minus(op1: Double, op2: Double) -> Double {
        return op1 - op2
    }
    
    func Divison(op1: Double, op2: Double) -> Double {
        return op1 / op2
    }
    
    func Multiplication(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    
    /*
     Le ta funkcija se kliče ko pride do kalkuliranja, kot argument se prenese le simbol
     Številka katero računamo se vnese prej v 'collector'
     */
    func doCalculation(symbol: String) {
        switch symbol {
        case "e": collector = M_E
        case "√": collector = sqrt(collector)
        case "+":
            executePendingBinaryOperation()
            pending = PendingSymbol(function: Plus, prevNumber: collector)
        case "-":
            executePendingBinaryOperation()
            pending = PendingSymbol(function: Minus, prevNumber: collector)
        case "/":
            executePendingBinaryOperation()
            pending = PendingSymbol(function: Divison, prevNumber: collector)
        case "*":
            executePendingBinaryOperation()
            pending = PendingSymbol(function: Multiplication, prevNumber: collector)
        case "=":
            executePendingBinaryOperation()
        default:
            break
        }
    }
    
    // Če pending obstaja, izvedi operacijo, saj ni nujno da se je izvedla
    private func executePendingBinaryOperation() {
        if pending != nil {
            collector = pending!.function(pending!.prevNumber, collector)
            pending = nil
        }
    }
    
    // Obstaja če so operacije +,-,*,/ v teku, v nasprotnem primeru ne obstaja - deduje struct
    private var pending: PendingSymbol?
    
    // Shranimo prejšno cifro (potrebno za računanje) in strukturo računanja (dve cifri z returnom)
    struct PendingSymbol {
        var function: (Double, Double) -> Double
        var prevNumber: Double
    }
    
    
    // Pridobimo rezultat - read only (nastavljamo ga v doCalculation)
    var result: Double {
        get {
            return collector
        }
    }
}
