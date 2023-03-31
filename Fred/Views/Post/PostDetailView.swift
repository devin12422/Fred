//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI


struct PostDetailView: View {
    let post:Post
    var comments: [Comment]
    var body: some View {
        VStack{
            Text(post.title)
            NavigationLink{
                
            }label:{
            Text(post.author.username)
            }
            NavigationLink(destination: CommentSectionView(commentsection: comments))
                {
                Text("Comments")
                }
            Text(post.description)
            List(post.instructions){instruction in
                Text(instruction.string)
        Spacer()
        
                }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post(uid:""), comments: [Comment]())
    }
}
