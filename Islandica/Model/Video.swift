//
//  Audio.swift
//  Islandica
//
//  Created by Luis Franco R on 08/01/2019.
//  Copyright © 2019 Luis Franco R. All rights reserved.
//

import Foundation

struct Video {
    
    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideos() -> [Video] {
        
        let v1 = Video(authorName: "Bienvenida", videoFileName: "v1", description: "This is an example of a local video", thumbnailFileName: "v1")
        
        let v2 = Video(authorName: "Instrucciones de Seguridad", videoFileName: "v2", description: "This is an example of a local video", thumbnailFileName: "v2")
        
        let v3 = Video(authorName: "Islandica", videoFileName: "v3", description: "This is an example of a local video", thumbnailFileName: "v3")
        
        
        return [v1, v2, v3]
    }
    
    static func fetchPaidVideos() -> [Video] {
        
        let v4 = Video(authorName: "Islandica", videoFileName: "v4", description: "This is an example of a local video", thumbnailFileName: "v4")
        
        let v5 = Video(authorName: "Islandica", videoFileName: "v5", description: "This is an example of a local video", thumbnailFileName: "v5")
        
        let v6 = Video(authorName: "Agradecimientos", videoFileName: "v6", description: "This is an example of a local video", thumbnailFileName: "v6")
        
        return [v4, v5, v6]
    }
    
}
