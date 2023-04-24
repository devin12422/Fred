//
//  Unit.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/15/23.
//

import Foundation

//struct Unit:Codable,StackableObject,Identifiable,Comparable,Equatable,Hashable{
//    var children: Set<Unit>
//    
//    static func < (lhs: Unit, rhs: Unit) -> Bool {
//        return lhs.coefficient < rhs.coefficient
//    }
//    static func == (lhs: Unit, rhs: Unit) -> Bool {
//        return lhs.coefficient == rhs.coefficient
//    }
//    static var ALL:Set<Unit>{get{
//        return [
//            Unit(name:"Weight",children:[Unit(name:"Gram",children:[Unit(name:"Milligram",relative_coefficient:1)],relative_coefficient:1000),Unit(name:"Pound",relative_coefficient: 453592)]),
//            Unit(name:"Volume",children:
//                    [Unit(name:"Cup",relative_coefficient:236.59),
//                     Unit(name:"Gallon",relative_coefficient:3785.41),
//                     Unit(name:"Pint",relative_coefficient:473.18),
//                     Unit(name:"Quart",relative_coefficient:946.35),
//                     Unit(name:"Fluid Ounce",relative_coefficient:29.57),
//                     Unit(name:"Teaspoon",relative_coefficient:4.93),
//                     Unit(name:"Tablespoon",relative_coefficient:14.79),
//                     Unit(name:"Liter",children:
//                            [Unit(name:"Milliliters",relative_coefficient:1.0)],
//                          relative_coefficient:1000)])]
//    }}
//    var name:String
//    var coefficient:Double
//    init(name:String = "Quantity",children:Set<Unit> = [],relative_coefficient:Double = 1.0){
//        self.name = name
//        self.coefficient = relative_coefficient
//        self.children = []
//        for unit in children{
//            var new_unit = unit
//            new_unit.coefficient *= coefficient
//            self.children.insert(new_unit)
//        }
//        
//    }
//    var id:String{get{return name}}
//    
//}
