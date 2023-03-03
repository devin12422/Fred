//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
class Instruction:Codable,Identifiable{
    var string:String;
    var uuid = UUID();
}
class Post:Codable,Identifiable{
    var title:String;
    var description:String;
    var instructions:[Instruction];
    var author:User;
    let uuid = UUID();
    init(title:String="",description:String = "",author:User = User.current,instructions:[Instruction]=[]){
        self.title = title
        self.description = description
        self.instructions = instructions
        self.author = author
    }
    func isComplete() -> Bool{
        return !title.isEmpty && !description.isEmpty
    }
}
