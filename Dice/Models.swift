//
//  Models.swift
//  Dice
//
//  Created by Waring, Nicholas S on 5/10/24.
//

import SwiftUI

struct SlotItem: Identifiable{
    var id: UUID = .init()
    var color: Color

}



struct Stock: Identifiable {
    var id: UUID = .init()
    var currentVal: Int
    var name: String
    var description: String
    var prices: [Int]
    var change: [String]
    var equation: (Int, Int, Int) -> Int // equation to calculate current value
    
    init(currentVal: Int, name: String, description: String, equation: @escaping (Int, Int, Int) -> Int) {
        self.currentVal = currentVal
        self.name = name
        self.description = description
        self.prices = [currentVal]
        self.change = []
        self.equation = equation
    }
    
    mutating func updateValue(with intValue1: Int, _ intValue2: Int, _ intValue3: Int) {
        let newValue = equation(intValue1, intValue2, intValue3)
        let changeString = newValue > currentVal ? "Up" : "Down"
        change.append(changeString)
        currentVal = newValue
        prices.append(currentVal)
    }
}

// Example equations for each stock type


struct StockA: Identifiable{
    var id: UUID = .init()
    var currentVal: Int = 100
    var name: String = "Stock A"
    var description: String = ""
    var prices: [Int] = [100]
    var change: [String] = []
    
    
    mutating func updateValue(with intValue1: Int, _ intValue2: Int, _ intValue3: Int) {
          if intValue1 >= 3 {
              currentVal += 10
              change.append("Down")
          } else {
              currentVal -= 10
              change.append("Up")
          }
        
        if intValue2 >= 3 {
            currentVal += 10
            change.append("Down")
        } else {
            currentVal -= 10
            change.append("Up")
        }
        
        if intValue3 >= 3 {
            currentVal += 10
            change.append("Down")
        } else {
            currentVal -= 10
            change.append("Up")
        }
          
          prices.append(currentVal)
      }
}



struct StockB: Identifiable{
    var id: UUID = .init()
    var currentVal: Int = 50
    var description: String = ""
    var name: String = "Stock B"
    var prices: [Int] = [50]
    var change: [String] = []
    
    
    mutating func updateValue(with intValue1: Int, _ intValue2: Int, _ intValue3: Int) {
           if intValue1 % 2 == 1 && intValue2 % 2 == 1 && intValue3 % 2 == 1 {
               currentVal *= 2
           } else if intValue1 % 2 == 0 && intValue2 % 2 == 0 && intValue3 % 2 == 0 {
               currentVal /= 2
           }
           
           prices.append(currentVal)
       }
}


struct StockC: Identifiable{
    var id: UUID = .init()
    var currentVal: Int = 200
    var description: String = ""
    var name: String = "Stock C"
    var prices: [Int] = [200]
    var change: [String] = []
    
    
    mutating func updateValue(with intValue1: Int, _ intValue2: Int, _ intValue3: Int) {
            if intValue1 == intValue2 && intValue2 == intValue3 {
                currentVal /= 3
            } else if intValue1 == intValue2 || intValue2 == intValue3 || intValue1 == intValue3 {
                currentVal *= 3/2
            }
            
            prices.append(currentVal)
        }
}


struct StockD: Identifiable{
    var id: UUID = .init()
    var currentVal: Int = 20
    var description: String = ""
    var name: String = "Stock D"
    var prices: [Int] = [20]
    var change: [String] = []
    
    
    mutating func updateValue(with intValue1: Int, _ intValue2: Int, _ intValue3: Int) {
            if intValue1 == 0 && intValue2 == 0 && intValue3 == 0 {
                currentVal = 0
            } else {
                currentVal += intValue1 + intValue2 + intValue3
            }
            
            prices.append(currentVal)
        }
}






