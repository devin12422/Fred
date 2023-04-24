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
    @State var loading = false
    @State var tag_is_showing  = false
    @State var isEditable = false
    @State private var instruction:Instruction = Instruction()
    @State private var instruction_view_is_showing = false
    @EnvironmentObject var view_stack:ViewStack
    
    var body: some View {
        VStack{
            Group{
                Text("New Recipe")
                TextField("Name",text: $post.title)
            }
            HStack{
                Text("Tags:")
                ScrollView(.horizontal){
                    HStack{
                        tag_view
                        Button{
                            tag_is_showing.toggle()
                        }label:{
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
            
            Text("Please make a description for the post")
            TextField("Description",text: $post.description)
            
            HStack{
                TextField("Instruction",text:$instruction.string).onTapGesture{
                    withAnimation {
                        isEditable = false
                    }
                }
                Button{
                    
                    post.instructions.append(instruction)
                    instruction = Instruction()
                    
                    
                }label:{
                    Image(systemName: "plus.circle.fill")
                }.disabled(!instruction.isComplete())
                
            }
           .sheet(isPresented: $tag_is_showing){
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
                
            }.task{
                view_stack.stack.append(ViewLayer(layer:[ViewState(name:"Description",image:UIImage(systemName: "doc.text")!,view:PostDescriptionEditingView(post: post)),ViewState(name:"Instructions",image:UIImage(systemName: "list.number")!,view:InstructionListEditingView(post:post))]))
                
            }
            .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
            .alert(isPresented: $posted) {Alert(title: Text("Success"), message: Text("Your post has been created."),dismissButton: .default(Text("Ok")){
                tag_view = AnyView(EmptyView())
                post = Post()})}
        }
    }
    func getTagTypes() -> Set<TagType> {
        var existing_types:Set<TagType> = []
        for tag in post.tags{
            if(tag.tag_type.isUnique){
                existing_types.insert(tag.tag_type)
                // print(tag.tag_type.id)
            }
            
        }
        //        print(TagType.ALL_TAGS.subtracting(existing_types))
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
