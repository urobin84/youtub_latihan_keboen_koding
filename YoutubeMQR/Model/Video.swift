//
//  video.swift
//  YoutubeMQR
//
//  Created by Pungs on 01/03/19.
//  Copyright © 2019 Pungs. All rights reserved.
//

import UIKit

//class objek video yang terdiri dari berbagai macam komponen(variabel)
class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews : NSNumber?
    var uploadDate: NSDate?
    
    // didalam class video terdapat variabel array yang bernama channel
    var channel: Channel?
}

//class channel menggambarkan objek yang berisi nama dan profil
class Channel: NSObject{
    var name: String?
    var profileImageName: String?
}
