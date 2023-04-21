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
    var post:CodableWrapper<Post>
    @State var comments: [CodableWrapper<Comment>] = []
    @State var comment:Comment = Comment()
    
    @State var page_token:String = ""
    @State var can_comment = false
    @State var comment_loading = false
    @State var posted = false
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                if(can_comment){
                    VStack(alignment: .leading) {
                        HStack{Picker("Rating", selection: $comment.rating){
                            Image(systemName: "star.fill").tag(1)
                            Image(systemName: comment.rating >= 2 ? "star.fill" : "star").tag(2)
                            Image(systemName: comment.rating >= 3 ? "star.fill" : "star").tag(3)
                            Image(systemName: comment.rating >= 4 ? "star.fill" : "star").tag(4)
                            Image(systemName: comment.rating >= 5 ? "star.fill" : "star").tag(5)
                        }.pickerStyle(.segmented)}
                        TextField("Review", text: $comment.content)
                        Button {
                            addComment()
                        } label: {
                            ZStack {
                                Rectangle().cornerRadius(45).frame(width: 100, height: 50)
                                Text("Post").foregroundColor(.white)
                            }
                        }.disabled(comment_loading)
                        
                    }}
                ListView<Comment>(path: "posts/\(post.author.uid!)/\(post.wrapped.uuid)/comments", max_results_from_same_user: 2)
                
            }.padding()
        }.padding().alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your review has been posted."),dismissButton: .default(Text("Ok")){
            comment = Comment()})}.task{
                can_comment = try! await canComment()
            }
    }
    func canComment() async throws-> Bool {
        return await try withCheckedThrowingContinuation{
            continuation in
            guard let uid = Auth.auth().currentUser?.uid else{return}
            Storage.storage().reference(withPath:"users/\(uid)/comments/\(post.wrapped.uuid)/item").downloadURL{
                data, error in
                if(error == nil){
                    continuation.resume(returning:false);
                }else{
                    continuation.resume(returning: true)
                }
                
            }
        }
    }
    func addComment() {
        if(comment.content.isEmpty){
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let encoder = JSONEncoder();
        let encoded = (try? encoder.encode(comment))!;
        comment_loading = true
        
        Storage.storage().reference(withPath:"posts/\(post.author.uid!)/\(post.wrapped.uuid)/comments/\(uid)/comment/item").putData(encoded){  data,error in
            if error == nil{
                Storage.storage().reference(withPath:"users/\(uid)/comments/\(post.wrapped.uuid)/item").putData(encoded){  data,error in
                    if error == nil{
                        Task {
                            
                            let count = try await Storage.storage().reference(withPath:"posts/\(post.author.uid!)/\(post.wrapped.uuid)/comments").listAll().prefixes.count
                            post.wrapped.rating = (post.wrapped.rating + comment.rating) /  max(count - 1,1) * count
                            let encoded_post = (try? encoder.encode(post.wrapped))!
                            Storage.storage().reference(withPath:"posts/\(post.author.uid!)/\(post.wrapped.uuid)/item").putData(encoded_post){  data,error in
                                if error == nil{
                                    posted = true
                                    can_comment = false
                                    comment_loading = false
                                }else{
                                    comment_loading = false
                                    
                                    print(error!.localizedDescription)
                                }}
                        }
                        
                    }else{
                        comment_loading = false
                        
                        print(error!.localizedDescription)
                    }
                }
            }else{
                
                comment_loading = false
                print(error!.localizedDescription)
            }
        }
        
    }}




struct CommentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSectionView(post:CodableWrapper<Post>(wrapped: Post(), author: User()))
    }
}
