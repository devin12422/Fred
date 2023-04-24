//
//  Wrappable.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/23/23.
//

import Foundation
import SwiftUI
protocol Wrappable:Codable,Identifiable{
    
}
protocol Feedable:Wrappable{
    associatedtype WrappableView: View
    func getView(author:User) -> WrappableView;
}
