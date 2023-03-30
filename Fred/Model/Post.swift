//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
import FirebaseAuth
class Instruction:Codable,Identifiable{
    var string:String;
    var uuid = UUID();
}
class PostWrapper:Identifiable{
    var post:Post
    var author:User
    init(post:Post,author:User){
        self.post = post
        self.author = author
    }
}
class Post:Codable,Identifiable{
    var title:String;
    var description:String;
    var instructions:[Instruction];
    let uuid = UUID();
    init(title:String,description:String,instructions:[Instruction]){
        self.title = title
        self.description = description
        self.instructions = instructions
    }
    convenience init(){
        self.init(title:"",description:"",instructions:[])
    }
    func isComplete() -> Bool{
        return !title.isEmpty && !description.isEmpty
    }
}
