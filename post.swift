//
//  post.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/3/23.
//

import Foundation

struct Post: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var content: String
    var comments: Int
}
