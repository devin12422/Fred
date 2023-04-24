////
////  StackPickerView.swift
////  Fred
////
////  Created by Devin Kramer (student LM) on 4/15/23.
////
//import Foundation
//import SwiftUI
//import FirebaseStorage
//import FirebaseAuth
//protocol StackableObject:Hashable,Comparable,Codable{
//    static var ALL:Set<Self> {get}
//    var children:Set<Self> { get }
//    var name:String{get}
//}
//class StackableObjectStack<StackObject:StackableObject>:Hashable,Codable,ObservableObject{
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(stack)
//        hasher.combine(picker_index)
//    }
//    static func == (lhs: StackableObjectStack<StackObject>, rhs: StackableObjectStack<StackObject>) -> Bool {
//        return lhs.stack == rhs.stack && lhs.picker_index == rhs.picker_index
//    }
//    private var first_layer:Set<StackObject>
//    var stack:[Set<StackObject>]{get{picker_index.reduce([first_layer]){
//        first,second in
//        [first,first.sorted()[second].children]
//    }}}
//    var picker_index:[Int]
//    init(first_layer:Set<StackObject> = StackObject.ALL,picker_index:Int = -1){
//        self.first_layer = first_layer
//        self.picker_index = [picker_index]
//    }
//    func getCurrentObject() -> StackObject{
//        return stack.last!.sorted()[picker_index[stack.count - 1]]
//    }
//}
//struct StackPickerView<StackObject:StackableObject>: View{
//    @ObservedObject var stack:StackableObjectStack<StackObject>
//    var picker_text:String
//    mutating func reset(){
//        stack = StackableObjectStack<StackObject>()
//    }
//    var body: some View {
//        HStack{
//            Text(picker_text)
//            ForEach($stack.stack.indices,id:\.self){stack_index in
//                Text("\(stack.picker_index[stack_index])")
//                Picker(picker_text,selection:$stack.picker_index[stack_index]){
//                    ForEach(stack.stack[stack_index].sorted().indices,id:\.self){
//                        Text(" \($0) \(stack.stack[stack_index].sorted()[$0].name)").tag($0)
//                    }
//                    Text("SELECT").tag(-1)
//
//                }.pickerStyle(.menu)
//            }
//
//        }
//    }
//}
