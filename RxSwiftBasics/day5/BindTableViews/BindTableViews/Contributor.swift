//
//  Contributor.swift
//  BindTableViews
//
//  Created by Scott Gardner on 6/3/16.
//  Copyright © 2016 Scott Gardner. All rights reserved.
//

import UIKit

struct Contributor {
    
    let name: String
    let gitHubID: String
    var image: UIImage?
    
    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }
    
}

extension Contributor: CustomStringConvertible {
    
    var description: String {
        return "\(name): github.com/\(gitHubID)"
    }
    
}
