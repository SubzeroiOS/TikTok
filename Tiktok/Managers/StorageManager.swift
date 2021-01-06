//
//  StorageManager.swift
//  Tiktok
//
//  Created by Bhaskar Rajbongshi on 1/4/21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    public static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    private init() {
        
    }
    
    // Public
    public func getVideoURL(with identifier: String, completion: ([URL]) -> Void) {
    }
    
    public func uploadVideo(from url: URL) {
    }
}
