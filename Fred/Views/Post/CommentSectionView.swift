//
//  CommentSectionView.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
struct CommentSectionView: View {
    @State var commentsection: [Comment]
    @State var newCommentUser: String = ""
    @State var newCommentContent: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Comments").font(.headline).padding(.top)
            
            VStack(alignment: .leading) {
                Text("Add a comment").font(.subheadline).bold()
                TextField("Name", text: $newCommentUser)
                TextField("Comment", text: $newCommentContent)
                Button {
                    addComment()
                } label: {
                    ZStack {
                        Rectangle().cornerRadius(45).frame(width: 100, height: 50)
                        Text("Submit").foregroundColor(.white)
                    }
                }

            }
            ForEach(commentsection) { comment in
                VStack(alignment: .leading) {
                    Text(comment.user).font(.subheadline).bold()
                    Text(comment.content).font(.body)
                    Divider()
                }}
        }.padding()
        
        
    }
    
func addComment() {
guard let user = Auth.auth().currentUser else {
        return
    }
    
    let storageRef = Storage.storage().reference()
    let commentsRef = storageRef.child("comments")
    let commentRef = commentsRef.child(UUID().uuidString)
    let metadata = StorageMetadata()
    metadata.contentType = "text/plain"
    
    let commentData = ["user": user.uid, "content": newCommentContent, "timestamp": Date().timeIntervalSince1970, "rating": 0] as [String : Any]
    
    commentRef.putData(newCommentContent.data(using: .utf8)!, metadata: metadata) { (metadata, error) in
        if let error = error {
            return
        }
    }
    
    commentRef.downloadURL { (url, error) in
        if let error = error {
            print("Error getting comment URL: \(error.localizedDescription)")
        return
        }
        guard let url = url else {
            print("Error getting comment URL")
            return
        }
        
        let newComment = Comment(id: commentRef.name, user: user.uid, content: url.absoluteString, timestamp: commentData["timestamp"] as! TimeInterval, rating: commentData["rating"] as! Int)
    
        commentsection.append(newComment)
        newCommentUser = ""
        newCommentContent = ""
    }
        
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
