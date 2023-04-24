//
//  Post.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import Foundation
import FirebaseAuth
import SwiftUI
class CodableWrapper<Wrapped:Wrappable>:Wrappable{
    var wrapped:Wrapped
    var author:User
    init(wrapped:Wrapped,author:User){
        self.wrapped = wrapped
        self.author = author
    }
}

class Post:Feedable,ObservableObject{
    func getView(author: User) -> PostView {
        return PostView(post: CodableWrapper<Post>(wrapped: self, author: author))
    }
    
    typealias WrappableView = PostView
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case instructions
        case uuid
        case rating
        case tags
    }
    var title:String;
    var description:String;
    var uuid:UUID;
    @Published var instructions:[Instruction];
    @Published var rating:Int
    @Published var tags:Set<TagInstance>
    
    init(title:String = "",description:String = "",instructions:[Instruction] = [],tags:Set<TagInstance> = [], rating:Int = 1){
        
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
    func reset(){
        self.title = ""
        self.description = ""
        self.instructions = []
        self.tags = []
        self.rating = 1
        self.uuid = UUID()
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        uuid = try values.decode(UUID.self, forKey: .uuid)
        instructions = try values.decode([Instruction].self, forKey: .instructions)
        rating = try values.decode(Int.self, forKey: .rating)
        description = try values.decode(String.self, forKey: .description)
        tags = try values.decode(Set<TagInstance>.self, forKey: .tags)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(rating, forKey: .rating)
        try container.encode(tags, forKey: .tags)
    }
}
