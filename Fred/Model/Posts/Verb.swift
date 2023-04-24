//
//  Verb.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

//import Foundation

//struct Verb:Codable,StackableObject,Identifiable,Comparable{
//    static func < (lhs: Verb, rhs: Verb) -> Bool {
//        return lhs.name < rhs.name
//    }
//
//    var name:String
//    var children:Set<Verb>
//    static var ALL:Set<Verb>{get{return [Verb(name: "Cook", children:[ "Grill","Boil","Barbecue","Gratin","StirFry","Bake","Roast","Stew","Caramelize","Steam","Fry","Toast","Poach","Microwave","Simmer","Scramble","Glaze"]),Verb(name: "Prepare", children:[ "Add","Slice","Drain","Dice","Pour","Mix","Beat","Break","Grease","Carve", "Combine", "Knead", "Chop","Measure","Stir", "Mince", "Peel", "Dissolve","Crush", "Pour","Whisk"])]}}
//    init(name:String,children:Set<Verb> = []){
//        self.name = name
//        self.children = children
//    }
//    init(name:String,children:Set<String>){
//        self.name = name
//        self.children = []
//        for child in children{
//            self.children.insert(Verb(name: child))
//        }
//    }
//    var id:  String {get{return name}}
//}
