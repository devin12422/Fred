//
//  CreatePostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct PostCreateView: View {
    @State var post:Post = Post()
    @State var tag_view: AnyView = AnyView(EmptyView())
    @State var posted = false
    @State var tag_is_showing  = false
    var body: some View {
        VStack{
            VStack{
                Group{
                    Text("New Recipe")
                    TextField("Name",text: $post.title)
                }
                ScrollView(.horizontal){
//                $post.tags.forEach()
                    HStack{tag_view
                    Button{
                        tag_is_showing.toggle()
                    }label:{
                        Text("Add Tags").padding().background(Color.gray)
                    }
                        
                    }
                }
               
            Text("Please make a description for the post")
            TextField("Description",text: $post.description)
            
                
            }
            HStack{
                Button{
                    if(post.isComplete()){
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    let encoder = JSONEncoder();
                    let encoded = try? encoder.encode(post);
                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)").putData(encoded!){
                        _, error in
                        if error == nil{
                            posted = true
                        }else{
                            print(error!.localizedDescription)
                        }
                    }
                        
                    }
                }label:{Text("Post")}
            }
        }.sheet(isPresented: $tag_is_showing){
            List(getTagList()){tag in
            Button{
                post.tags.append(tag)
                tag_view = AnyView(generateTagView())
                tag_is_showing.toggle()
            }label:{Text(tag.string)

            }
            }
            
        }
        .alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your post has been created."),dismissButton: .default(Text("Ok")){
            tag_view = AnyView(EmptyView())
            post = Post()})}
        }
    func getTagList() -> [Tags]{
        var return_tags:[Tags] = []
        Tags.allCases.forEach{ tag in
            var t = false
            post.tags.forEach{owned_tag in
                if(tag.isSameCase(as: owned_tag)){
                    t = true
                }
            }
            if(!t){
                return_tags.append(tag)
            }
        }
        return return_tags
    }
    func generateTagView() -> some View{
        return HStack{
            ForEach(post.tags){tag in
            Button{
                if let index = post.tags.firstIndex(of: tag){
                    post.tags.remove(at:index)
                    tag_view = AnyView(generateTagView())
                }
            }label:{Text(tag.string)}
        }
        }
    }
    }
struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView()
    }
}
