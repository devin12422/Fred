//
//  Comment.swift
//  Fred
//
//  Created by Shivesh Reddy Dundumalla (student LM) on 3/21/23.
//

import Foundation

struct Comment: Identifiable {
    let id = UUID()
    let user: String
    let content: String
}
