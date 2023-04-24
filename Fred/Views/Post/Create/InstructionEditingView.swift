//
//  InstructionEditingView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/23/23.
//

import Foundation

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct InstructionEditingView: View {
//    @Binding var instruction:Instruction
//    var post_ingredients:Set<Ingredient>
//    @State var is_detailed_editing = false
//    @State var add_ingredient = false
//    @State var ingredient:Ingredient = Ingredient()
    var body: some View {
        VStack{
            Text("placeholder")
//            TextField("Instruction",text:$instruction.string).fixedSize()
            
//            StackPickerView<Verb>(stack: instruction.verb,picker_text: "Instruction: ")
//            Text("Ingredients:")
//            VStack{
//                List{
//                    ForEach(instruction.ingredients.shuffled(),id:\.self.name){ingredient in
//                        Text("\(ingredient.name) - \(String(format: "%g",ingredient.quantity.getQuantity()))\(ingredient.quantity.unit.getCurrentObject().name ?? "")\(ingredient.quantity.getQuantity() > 1 ? "s" : "")")
//                    }
//
//                }
//                Button{
//                    add_ingredient.toggle()
//                }label:{
//                    Image(systemName: "plus.circle.fill")
//                }
//            }
            
            
//        }.sheet(isPresented: $add_ingredient){
//            VStack{
//                Text("Ingredient Name:")
//                Picker("Ingredient", selection: $ingredient.name){
//                    ForEach(post_ingredients.filter{
//                        post_ingredient in
//                        return instruction.ingredients.contains{
//                            instruction_ingredient in
//                            return post_ingredient.name == instruction_ingredient.name
//                        }
//                    }){ingredient in
//                        Text(ingredient.name).tag(ingredient.name)
//                    }
//                    Text("Other").tag("")
//                }
//                if(post_ingredients.filter{post_ingredient in
//                    post_ingredient.name == ingredient.name
//                }.isEmpty){
//                    TextField("Ingredient",text:$ingredient.name)
//                }
//                TextField("Quantity",text:Binding(
//                    get: { String(format: "%g", ingredient.quantity.raw_quantity)},
//                    set: { ingredient.quantity.raw_quantity =  Double($0) ?? 0 }
//                )).keyboardType(.numberPad)
//
//                StackPickerView<Unit>(stack:ingredient.quantity.unit, picker_text: "Unit: ")
//                Button{
//                    instruction.ingredients.insert(ingredient)
//                    ingredient = Ingredient()
//                    add_ingredient.toggle()
//                }label:{Text("Add Ingredient")}.disabled(ingredient.name.isEmpty)
//            }
        }
    }
}
