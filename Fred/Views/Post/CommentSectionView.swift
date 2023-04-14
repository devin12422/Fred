//
//  CommentSectionView.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
struct FlippedUpsideDown: ViewModifier {   func body(content: Content) -> some View {    content      .rotationEffect(.degrees(180))      .scaleEffect(x: -1, y: 1, anchor: .center)   }}
extension View{   func flippedUpsideDown() -> some View{     self.modifier(FlippedUpsideDown())   }
}
struct CommentSectionView: View {
    var post:PostWrapper
    @State var comments: [CommentWrapper] = []
    @State var comment_content: String = ""
    @State var page_token:String = ""
    
    @State var posted = false
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                VStack(alignment: .leading) {
                    TextField("Comment", text: $comment_content)
                    Button {
                        addComment()
                    } label: {
                        ZStack {
                            Rectangle().cornerRadius(45).frame(width: 100, height: 50)
                            Text("Submit").foregroundColor(.white)
                        }
                    }
                    
                }.flippedUpsideDown()
                ForEach(comments ) { comment in
                    VStack(alignment: .leading) {
                        UserView(user:comment.user)
                        Text(comment.comment.content).font(.body)
                        Divider()
                    }.flippedUpsideDown()}
                
            }.flippedUpsideDown().padding()
        }.padding().alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your comment has been posted."),dismissButton: .default(Text("Ok")){
            comment_content = ""})}.task{
                Storage.storage().reference(withPath: "posts/\(post.author.uid)/\(post.post.uuid)/comments/").list(maxResults:8,pageToken: page_token){(result,error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }else{
                        if result?.pageToken != .none{
                            page_token = (result?.pageToken!)!
                        }
                        let decoder = JSONDecoder()
                        print("decoding comments")
                        for item in result!.items {
                            item.getData(maxSize: Int64.max){
                                (result,error)in
                                if let error = error {
                                    print(error.localizedDescription)
                                }else{
                                    guard let comment = try? decoder.decode(Comment.self, from: result!)else{
                                        print("error decoding post");
                                        return;
                                    }
                                    User.get(uid: comment.user_id) { user in
                                        comments.append(CommentWrapper(comment:comment,user:user))
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
    }
    func addComment() {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let comment = Comment(user_id: uid, content: comment_content)
        let encoder = JSONEncoder();
        let encoded = (try? encoder.encode(comment))!;
        Storage.storage().reference(withPath:"posts/\(post.author.uid)/\(post.post.uuid)/comments/\(comment.id)").putData(encoded){  data,error in
            if error == nil{
                posted = true
            }else{
                print(error!.localizedDescription)
            }
        }
    }}




struct CommentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSectionView(post:PostWrapper(post: Post(), author: User()))
    }
}
