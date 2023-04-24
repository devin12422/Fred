//
//  InstructionListEditingView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/23/23.
//

import Foundation

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct InstructionListEditingView: View {
    @ObservedObject var post:Post
    @State var isEditable = false
    @State private var new_instruction:Instruction = Instruction()
    @State private var instruction_view_is_showing = false
    
    var body: some View {
        
        VStack{
            List{
                VStack{
                    TextField("Instruction",text: $new_instruction.string)
                    Button{
                        post.instructions.append(new_instruction)
                        new_instruction = Instruction()
                    }label:{
                        Text("Add Instruction")
                    }.disabled(!new_instruction.isComplete())
                    
                }
                ForEach($post.instructions){instruction in
                    TextField("Instruction",text: instruction.string)
                }.onMove{source,destination in
                    post.instructions.move(fromOffsets: source, toOffset: destination)
                }.onDelete{
                    index in
                    post.instructions.remove(atOffsets: index)
                    if post.instructions.isEmpty {
                        isEditable = false
                    }
                }.onLongPressGesture{
                    isEditable.toggle()
                }
                
                
            }
        }
        .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
    }
}
