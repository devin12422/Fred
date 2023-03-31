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
    @State var uid:String? = Auth.auth().currentUser?.uid
    @State var user:User = User()
    @State var view_stack:ViewStack = ViewStack()
    @State var view_state_index:Int = 1
    @State var radians:CGFloat = 0.0


    let height_offset = UIScreen.main.bounds.width * 0.8 + UIScreen.main.bounds.height * 1;
    var body: some View {
        if (Auth.auth().currentUser?.uid == nil){
            NavigationView{
                VStack{
                    NavigationLink{
                        SignUp(uid:$uid)
                    }label:{
                        Text("Sign Up")
                    }
                    NavigationLink{
                        SignIn(uid:$uid)
                    }label:{
                        Text("Sign In")
                    }
                }
            }
            
        }else{
            ZStack{
                view_stack.stack.last?.layer[view_state_index].view.body
                
                ZStack{
                    Circle().trim(from:0.65,to:0.85).frame(width:UIScreen.main.bounds.width * 2,height:UIScreen.main.bounds.width * 2).foregroundColor(Color.blue).clipShape(Circle())
                ForEach(view_stack.stack){stack in
                    ForEach(stack.layer){
                        state in
                        let index:CGFloat = getCenteredCircularIndex(layer: stack, state: state)
                        let image:Image = state.image
                        image.padding().background(Color.white).cornerRadius(32).rotationEffect(Angle(radians: Double(-radians))).offset(x:UIScreen.main.bounds.width * -1 * cos(index),y:UIScreen.main.bounds.width * -1 * sin(index))
                    }.rotationEffect((view_stack.stack.firstIndex(of:stack) == 0) ? Angle(radians:Double(radians)) : Angle(radians:0),anchor: UnitPoint.center)
                }
                    
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: CoordinateSpace.local).onChanged(onChanged(value:)).onEnded(onEnded(value:))).position(x:UIScreen.main.bounds.width / 2 ,y:height_offset)
                
            }
            .task{
                do{
                    if Auth.auth().currentUser?.uid != nil{
                        user = await try User.get_async(uid: uid!)
                    }
                }
                catch{
                    print(error)
                }
            }
            .environmentObject(user)
            }
            
    }
    func getCenteredCircularIndex(layer:ViewLayer,state:ViewState) -> CGFloat{
        return CGFloat(layer.layer.firstIndex(of: state)! + 1) / CGFloat(layer.layer.count + 1) + 1.07
    }
    func onChanged(value:DragGesture.Value){
//        (CGFloat(view_state_index) + 1.07) +
        radians = -CGFloat(view_state_index + 1) / CGFloat(view_stack.stack.last!.layer.count + 1) + 0.5 + atan2(value.location.x / UIScreen.main.bounds.width - 1,(value.location.y / UIScreen.main.bounds.width - 1) * -1) - atan2(value.startLocation.x / UIScreen.main.bounds.width - 1,(value.startLocation.y / UIScreen.main.bounds.width - 1) * -1)
    }
    func onEnded(value:DragGesture.Value){
        let layer_count = view_stack.stack.last!.layer.count + 1
        
        var closest = -CGFloat(view_state_index + 1) / CGFloat(layer_count) + 0.5 - radians
        for state in view_stack.stack.last!.layer{
            let dist = -CGFloat(view_stack.stack.last!.layer.firstIndex(of: state)! + 1) / CGFloat(layer_count) + 0.5 - radians
            if(abs(dist) < abs(closest)){
                closest = dist
                view_state_index = view_stack.stack.last!.layer.firstIndex(of: state)!
            }
        }
        radians = closest + radians
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
