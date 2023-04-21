//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
import FirebaseAuth
import SwiftUI
//protocol TagEnum{
//    func allCases<T:TagEnum>(case:T){
//        T.
//    }
//}

class Instruction:Wrappable{
    var string:String;
    var uuid = UUID();
}

class CodableWrapper<Wrapped:Wrappable>:Wrappable{
    var wrapped:Wrapped
    var author:User
    init(wrapped:Wrapped,author:User){
        self.wrapped = wrapped
        self.author = author
    }
}

class Post:Feedable{
    func getView(author: User) -> PostView {
        return PostView(post: CodableWrapper<Post>(wrapped: self, author: author))
    }
    
    typealias WrappableView = PostView
    
    var title:String;
    var description:String;
    var instructions:[Instruction];
    let uuid:UUID;
    var rating:Int
    var tags:Set<TagInstance>
    
    init(title:String = "",description:String = "",instructions:[Instruction] = [],tags:Set<TagInstance> = [], rating:Int = 0){

        self.title = title
        self.description = description
        self.instructions = instructions
        self.tags = tags
        self.rating = rating
        self.uuid = UUID()
    }
    func isComplete() -> Bool{
        return !title.isEmpty && !description.isEmpty
    }
}
