//
//  SettingsView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import AVFoundation
struct SettingsView: View {
    @EnvironmentObject var user:User
    @State var image:UIImage = UIImage(systemName: "person.crop.circle.fill")!
    @State var bimage = false
    var body: some View {
        VStack{
            Button{
                bimage.toggle()
            }label:{
                ZStack{
                    Image(uiImage: image).resizable().frame(width: 128, height:128).cornerRadius(100)
                    Image(systemName: "pencil.circle.fill").offset(x: 100, y: 100)
                }
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
            }label:{Text("sign out")}
        }.sheet(isPresented:$bimage){
            let maxSize = CGSize(width: 128, height: 128)
            let availableRect = AVFoundation.AVMakeRect(aspectRatio: image.size, insideRect: .init(origin: .zero, size: maxSize))
            let targetSize = availableRect.size
            let format = UIGraphicsImageRendererFormat()
            format.scale = 1
            let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
            let resized = renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            user.image = resized.jpegData(compressionQuality: 1.0)!
            user.send()
        }content:{
            ImagePicker(selectedImage: $image)
        }.task{
            self.image = UIImage(data:user.image)!
        }
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
