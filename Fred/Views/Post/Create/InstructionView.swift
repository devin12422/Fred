////
////  InstructionView.swift
////  Fred
////
////  Created by Devin Kramer (student LM) on 4/14/23.
////
//
//import Foundation
//import SwiftUI
//import FirebaseStorage
//import FirebaseAuth
//struct InstructionDetailView: View {
//    @Binding var instruction:Instruction
//    @Binding var post_ingredients:Set<Ingredient>
//    @State private var ingredient:Ingredient = Ingredient()
//    @State var add_ingredient = false
//    
//    var body: some View {
//        
//        VStack{
//            StackPickerView<Verb>(stack: StackableObjectStack<Verb>(), object: $instruction.verb, picker_text: "Instruction: ")
//            Text("Ingredients:")
//            VStack{
//                List{
//                    ForEach((Binding<[Ingredient]>(get:{
//                        return instruction.ingredients.compactMap{i in return i}
//                    },set:{_ in
//                        
//                    })),id:\.self.name){ingredient in
//                        Text("\(ingredient.wrappedValue.name) - \(String(format: "%g",ingredient.quantity.unit_quantity.wrappedValue)) \(ingredient.quantity.unit.wrappedValue?.name ?? "")\(ingredient.quantity.unit_quantity.wrappedValue > 1 && ingredient.quantity.unit.wrappedValue != nil ? "s" : "")")
//                    }
//                    
//                }
//                Button{
//                    add_ingredient.toggle()
//                }label:{
//                    Image(systemName: "plus.circle.fill")
//                }
//            }
//            
//        }.sheet(isPresented: $add_ingredient){
//            VStack{
//                Text("Ingredient Name:")
//                Picker("Ingredient", selection: $ingredient){
//                    ForEach(post_ingredients.shuffled()){ingredient in
//                        Text(ingredient.name).tag(ingredient)
//                    }
//                    Text("Other").tag("")
//                }
//                if(post_ingredients.filter{post_ingredient in
//                    post_ingredient.name == ingredient.name
//                }.isEmpty){
//                    TextField("Ingredient",text:$ingredient.name)
//                }
//                TextField("Quantity",text:Binding(
//                    get: { String(format: "%g", ingredient.quantity.unit_quantity)},
//                    set: { ingredient.quantity.unit_quantity =  Double($0) ?? 0 }
//                )).keyboardType(.numberPad)
//                
//                var stack = StackPickerView<Unit>(stack: StackableObjectStack<Unit>(),object: $ingredient.quantity.unit, picker_text: "Unit: ")
//                stack
//                Button{
//                    instruction.ingredients.insert(ingredient)
//                    print(instruction.ingredients)
//                    ingredient = Ingredient()
//                    stack.reset()
//                    add_ingredient.toggle()
//                }label:{Text("Add Ingredient")}
//            }
//        }
//    }
//}
