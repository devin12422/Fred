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
class Post:Codable,Identifiable{
    var title:String;
    var description:String;
    var instructions:[Instruction];
    var author:User;
    let uuid = UUID();
    init(title:String,description:String,author:User,instructions:[Instruction]){
        self.title = title
        self.description = description
        self.instructions = instructions
        self.author = author
        self.author.get()
    }
    convenience init(user:User){
        self.init(title:"",description:"",author:user,instructions:[])
    }
    convenience init(uid:String){
        self.init(user:User(uid: uid))
    }
    convenience init(){
        self.init(uid:Auth.auth().currentUser!.uid)
    }
    func isComplete() -> Bool{
        return !title.isEmpty && !description.isEmpty
    }
}
