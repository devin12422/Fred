//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
class Post{
    var title:String;
    var description:String;
    var instructions:[String];
    var author:User;
    init(title:String,description:String,author:User,instructions:[String]){
        self.title = title
        self.description = description
        self.instructions = instructions
        self.author = author
    }
    init(){
        self.title = ""
        self.description = ""
        self.author = User.current!
        self.instructions = []
    }
}
