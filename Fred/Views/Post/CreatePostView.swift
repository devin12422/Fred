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
                    HStack{
                        tag_view
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
                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)/post").putData(encoded!){
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
            ScrollView{
                ForEach(getTagTypes().shuffled()){type in
                    VStack{
                        Text(type.name)
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(type.cases.shuffled(),id:\.self){ instance in
                                    Button{
                                        post.tags.insert(instance)
                                        tag_is_showing.toggle()
                                        tag_view = AnyView(generateTagView())
                                    }label:{
                                        Text(instance.tag)
                                
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
        .alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your post has been created."),dismissButton: .default(Text("Ok")){
            tag_view = AnyView(EmptyView())
            post = Post()})}
        }
    func getTagTypes() -> Set<TagType> {
        var existing_types:Set<TagType> = []
        for tag in post.tags{
            if(tag.tag_type.isUnique){
                existing_types.insert(tag.tag_type)
                print(tag.tag_type.id)
            }
            
        }
        print(TagType.ALL_TAGS.subtracting(existing_types))
        return TagType.ALL_TAGS.subtracting(existing_types)
    }
    func generateTagView() -> some View{
        return ForEach(post.tags.shuffled(),id:\.self.tag){tag in
                VStack{
            Button{
                    post.tags.remove(tag)
                    tag_view = AnyView(generateTagView())
            }label:{Text(tag.tag)}}
        }
        }
    }
struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView()
    }
}
