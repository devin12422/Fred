//
//  ContentView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseAuth

func getIndices(states:[ViewState])->[ViewState:Float]{
    var state_dict:[ViewState:Float] = [:]
    for x in 0...states.count-1{
        state_dict[states[x]] = Float(x+1) / Float(states.count+1)
    }
    return state_dict;
}
struct ContentView: View {
    @StateObject var user:User = User(uid:Auth.auth().currentUser?.uid)
    @StateObject var view_stack:ViewStack = ViewStack(first_layer: ViewLayer(layer:[ViewState(name:"Post Create",image:UIImage(systemName: "doc.text")!,view:PostCreateView()),ViewState(name:"Home",image:UIImage(systemName: "house")!,view:NavigationView{ListView<Post>(path: "posts", max_results_from_same_user: 2)}),ViewState(name:"Settings",image:UIImage(systemName: "gear")!,view:SettingsView())]))
    @State var view_state_index:Int = 1
    @State var radians:CGFloat = 0.0
    @State var top_offset:CGFloat = 0.0
    
    let height_offset = UIScreen.main.bounds.width * 0.8 + UIScreen.main.bounds.height * 1;
    var body: some View {
        
        if (user.uid == nil){
            NavigationView{
                VStack{
                    NavigationLink{
                        SignUp()
                    }label:{
                        Text("Sign Up")
                    }
                    NavigationLink{
                        SignIn()
                    }label:{
                        Text("Sign In")
                    }
                }
            }
            .environmentObject(user)
            
        }else{
            ZStack{
//                ForEach($view_stack.stack){stack in
//                    stack.layer[stack.currentIndex].view.body
//                }
                view_stack.stack.last?.layer[view_state_index].view.body
                
                ZStack{
                    Circle().trim(from:0.65,to:0.85).frame(width:UIScreen.main.bounds.width * 2,height:UIScreen.main.bounds.width * 2).foregroundColor(Color.blue).clipShape(Circle())
                    ForEach(view_stack.stack){stack in
                        let offset_multiplier:CGFloat = UIScreen.main.bounds.width * -1 + (CGFloat(view_stack.stack.firstIndex(of: stack)! - (view_stack.stack.count - 1)) * -32)
                        ForEach(stack.layer){
                            state in
                            let index:CGFloat = getCenteredCircularIndex(layer: stack, state: state)
                            let image:Image = state.image
                            image.padding().background(Color.white).cornerRadius(32).rotationEffect(Angle(radians: (view_stack.stack.firstIndex(of:stack) == view_stack.stack.count - 1) ? Double(-radians) : 0)).offset(x:offset_multiplier * cos(index),y: offset_multiplier * sin(index) - ((view_stack.stack.firstIndex(of:stack) == view_stack.stack.count - 1) ? top_offset : 0))
                        }.rotationEffect((view_stack.stack.firstIndex(of:stack) == view_stack.stack.count - 1) ? Angle(radians:Double(radians)) : Angle(radians:0),anchor: UnitPoint.center)
                        
                    }
                    
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: CoordinateSpace.local).onChanged(onChanged(value:)).onEnded(onEnded(value:))).position(x:UIScreen.main.bounds.width / 2 ,y:height_offset)
                
            }
            .task{
                do{
                    if Auth.auth().currentUser?.uid != nil{
                        user.copyTo(from: await try User.get_async(uid: user.uid!))
                    }
                }
                catch{
                    print(error)
                }
            } .environmentObject(user)
                .environmentObject(view_stack)
            
        }
        
    }
    func getCenteredCircularIndex(layer:ViewLayer,state:ViewState) -> CGFloat{
        return CGFloat(layer.layer.firstIndex(of: state)! + 1) / CGFloat(layer.layer.count + 1) + 1.07
    }
    func onChanged(value:DragGesture.Value){
        //        (CGFloat(view_state_index) + 1.07) +
        radians = -CGFloat(view_state_index + 1) / CGFloat(view_stack.stack.last!.layer.count + 1) + 0.5 + atan2(value.location.x / UIScreen.main.bounds.width - 1,(value.location.y / UIScreen.main.bounds.width - 1) * -1) - atan2(value.startLocation.x / UIScreen.main.bounds.width - 1,(value.startLocation.y / UIScreen.main.bounds.width - 1) * -1)
        if(view_stack.stack.count > 1 ){top_offset = max(min(64,sin(-radians + .pi / 2) - value.location.y),0)}
    }
    func onEnded(value:DragGesture.Value){
        
        if(top_offset > 32 && view_stack.stack.count > 1){
            view_stack.stack.removeLast()
            radians = -CGFloat(view_stack.stack.last!.current_index + 1) / CGFloat(view_stack.stack.last!.layer.count + 1) + 0.5 - radians
            view_state_index = view_stack.stack.last!.start_index
        }else{
            var closest = -CGFloat(view_state_index + 1) / CGFloat(view_stack.stack.last!.layer.count + 1) + 0.5 - radians
            for state in view_stack.stack.last!.layer{
                let dist = -CGFloat(view_stack.stack.last!.layer.firstIndex(of: state)! + 1) / CGFloat(view_stack.stack.last!.layer.count + 1) + 0.5 - radians
                if(abs(dist) < abs(closest)){
                    closest = dist

                    view_state_index = view_stack.stack.last!.layer.firstIndex(of: state)!
                }
            }
            view_stack.stack.last!.current_index = view_state_index
            radians = closest + radians
        }
        top_offset = 0
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
