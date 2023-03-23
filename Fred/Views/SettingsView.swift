//
//  SettingsView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
struct SettingsView: View {
    @Binding var uid:String?
    @State var user = User()
    @State var image:UIImage = UIImage(systemName: "person.crop.circle")!
    @State var bimage = false
    var body: some View {
        VStack{
            Button{
                bimage.toggle()
            }label:{
                Image(uiImage: image).resizable().frame(width: 200, height:200).cornerRadius(100)
            }
            Text(user.email)
            VStack{
                Text("Username")
                TextField("Username",text: $user.username).onSubmit{
                    user.send()
                    
                }
        }
            Button{
                try? Auth.auth().signOut()
                uid = .none
            }label:{Text("sign out")}
        }.sheet(isPresented:$bimage){
            user.image = image.jpegData(compressionQuality: 0.5)!
            user.send()
        }content:{
            ImagePicker(selectedImage: $image)
        }.task{
            do{
                user = await try User.get_async(uid: uid!)
                image = UIImage(data:user.image)!
            }
            catch{
                print(error)
            }
            
        }
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(uid:Binding.constant(""))
    }
}
