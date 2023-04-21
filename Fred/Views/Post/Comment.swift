//
//  Comment.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import Foundation
import SwiftUI

struct CommentView:View{
    var comment:CodableWrapper<Comment>

    var body:some View{
        VStack(alignment: .leading) {
            UserView(user:comment.author)
            HStack{
                Image(systemName: "star.fill")
                Image(systemName: comment.wrapped.rating >= 2 ? "star.fill" : "star")
                Image(systemName: comment.wrapped.rating >= 3 ? "star.fill" : "star")
                Image(systemName: comment.wrapped.rating >= 4 ? "star.fill" : "star")
                Image(systemName: comment.wrapped.rating >= 5 ? "star.fill" : "star")
            }
            Text(comment.wrapped.content).font(.body)
            Divider()
        }
    }
}
struct Comment:Feedable {
    func getView(author: User) -> CommentView {
        return CommentView(comment: CodableWrapper<Comment>(wrapped:self,author:author))
    }
    
    typealias WrappableView = CommentView
    
    var id:UUID
    
    var rating: Int
    var content: String
    init(rating:Int = 1,content:String = ""){
        self.rating = rating
        self.content = content
        self.id = UUID()
    }
}
