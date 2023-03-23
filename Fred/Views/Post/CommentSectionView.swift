//
//  CommentSectionView.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import SwiftUI

struct CommentSectionView: View {
    @State var commentsection: [Comment]
    @State var newCommentUser: String = ""
    @State var newCommentContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Comments").font(.headline).padding(.top)
            
            
            Divider()
            ForEach(commentsection) { comment in
                VStack(alignment: .leading) {
                    Text(comment.user).font(.subheadline).bold()
                    Text(comment.content).font(.body)
                    Divider()
                }}
        }.padding()
        
        VStack(alignment: .leading) {
            Text("Add a comment").font(.subheadline).bold()
            TextField("Name", text: $newCommentUser)
            TextField("Comment", text: $newCommentContent)
            Button {
                addComment()
            } label: {
                ZStack {
                Text("Submit")
                Rectangle().cornerRadius(45)
                }
            }

        }
    }
    
func addComment() {
    let newComment = Comment(user: newCommentUser, content: newCommentContent)
    commentsection.append(newComment)
    newCommentUser = ""
    newCommentContent = ""
    }

}

struct CommentSectionView_Previews: PreviewProvider {
    static var comments = [
        Comment(user: "User1", content: "Comment 1"),
        Comment(user: "User2", content: "Comment 2"),
        Comment(user: "User3", content: "Comment 3")
    ]
    static var previews: some View {
        CommentSectionView(commentsection: comments)
    }
}
