//
//  Comment.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import Foundation

struct Comment: Identifiable,Codable {
    let id = UUID()
    let user_id: String
    let content: String
}
struct CommentWrapper:Identifiable{
    let comment:Comment
    var user:User
    var id:UUID{get{return comment.id}}
}
