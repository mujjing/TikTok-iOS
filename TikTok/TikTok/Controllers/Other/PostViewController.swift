//
//  PostViewController.swift
//  TikTok
//
//  Created by Jh's Macbook Pro on 2021/02/23.
//

import UIKit

class PostViewController: UIViewController {
    
    let model: PostModel
    let color: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.randomElement()
    }

}
