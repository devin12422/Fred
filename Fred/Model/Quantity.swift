////
////  Quantity.swift
////  Fred
////
////  Created by Devin Kramer (student LM) on 4/15/23.
////
//
//import Foundation
//
//
//struct Quantity:Codable,Hashable,Equatable{
//    var unit:StackableObjectStack<Unit>
//    var raw_quantity:Double
//    static func == (lhs: Quantity, rhs: Quantity) -> Bool {
//        return lhs.getRawQuantity() == rhs.getRawQuantity()
//    }
//    func getRawQuantity() -> Double {
//        return self.raw_quantity
//    }
//    mutating func setQuantity(value:Double){
//        self.raw_quantity = value * self.unit.getCurrentObject().coefficient
//    }
//    func getQuantityAs(unit:Unit) -> Double{
//        return self.raw_quantity / unit.coefficient
//    }
//    func getQuantity() -> Double{
//        return self.raw_quantity / self.unit.getCurrentObject().coefficient
//    }
//    mutating func addQuantity(other:Quantity){
//        self.raw_quantity += other.raw_quantity
//    }
//    init(unit:StackableObjectStack<Unit>,raw_quantity:Double = 1.0){
//        self.unit = unit
//        self.raw_quantity = raw_quantity
//    }
//}
