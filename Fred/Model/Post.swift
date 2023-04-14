//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
import FirebaseAuth
//protocol TagEnum{
//    func allCases<T:TagEnum>(case:T){
//        T.
//    }
//}
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
    let uuid:UUID;
    var tags:Set<TagInstance>
    
    init(title:String,description:String,instructions:[Instruction],tags:Set<TagInstance>){

        self.title = title
        self.description = description
        self.instructions = instructions
        self.tags = tags
        self.uuid = UUID()
    }
    convenience init(){
        self.init(title:"",description:"",instructions:[],tags:[])
    }
    func isComplete() -> Bool{
        return !title.isEmpty && !description.isEmpty
    }
}
