//
//  PostsViewController.swift
//  Tiktok
//
//  Created by Bhaskar Rajbongshi on 1/4/21.
//

import UIKit

class PostsViewController: UIViewController {
    
    let model: PostModel
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        let colors: [UIColor] = [.red, .gray, .green, .blue, .white, .systemPink]
        view.backgroundColor = colors.randomElement()
    }
}
