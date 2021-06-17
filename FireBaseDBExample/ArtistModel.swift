//
//  ArtistModel.swift
//  FireBaseDBExample
//
//  Created by WonDongHyun on 2021/06/16.
//

class ArtistModel{
    var id: String?
    var name: String?
    var genre: String?
    
    
    init(id:String?, name:String?, genre:String?){
        self.id = id;
        self.name = name;
        self.genre = genre;
    }
}
