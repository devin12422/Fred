//
//  Instruction.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

import Foundation
import SwiftUI

struct Instruction:Equatable,Wrappable,Hashable,Identifiable{
    
    func hash(into hasher: inout Hasher) {
//        hasher.combine(ingredients)
//        hasher.combine(verb)
        hasher.combine(string)
    }
    static func == (lhs: Instruction, rhs: Instruction) -> Bool {
        return lhs.string == rhs.string
    }
//    enum CodingKeys: String, CodingKey {
//         case string
//         case uuid
//     }
    var string:String;
    var id:UUID;
//    @Published var verb: StackableObjectStack<Verb>
//    @Published var ingredients: Set<Ingredient>
    init(string:String = ""){
        self.string = string
        self.id = UUID();
//        self.ingredients = ingredients
//        self.verb = StackableObjectStack<Verb>()
    }
    func isComplete()->Bool{
        return !string.isEmpty
    }
//    func reset(){
//        self.string = ""
//        self.uuid = UUID();
//        self.ingredients = []
//        self.verb = StackableObjectStack<Verb>()
//    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        string = try values.decode(String.self, forKey: .string)
//        uuid = try values.decode(UUID.self, forKey: .uuid)
//        ingredients = try values.decode(Set<Ingredient>.self, forKey: .ingredients)
//        verb = try values.decode(StackableObjectStack<Verb>.self, forKey: .verb)
//    }

//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(uuid, forKey: .uuid)
//        try container.encode(string, forKey: .string)
//        try container.encode(ingredients, forKey: .ingredients)
//        try container.encode(verb, forKey: .verb)
//    }
}
