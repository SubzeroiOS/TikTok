//
//  PostModel.swift
//  Tiktok
//
//  Created by Bhaskar Rajbongshi on 1/5/21.
//

import Foundation

struct PostModel {
    let identifier: String
}

func mockModels() -> [PostModel] {
    var posts = [PostModel]()
    for _ in 1...100 {
        posts.append(PostModel(identifier: UUID().uuidString))
    }
    return posts
}
