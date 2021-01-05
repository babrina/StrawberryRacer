import Foundation


class ScoreList: Codable {
    var score: Int = 0
    var name: String = ""
    var date: String = ""
    
    init() {}


    init(name: String, score: Int, date: String) {
        self.name = name
        self.score = score
        self.date = date
         
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case score, name, date
    }
    
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.score = try container.decode(Int.self, forKey: .score)
        self.date = try container.decode(String.self, forKey: .date)
    }
    
    public func encode(to encoder: Encoder) throws {
        var contrainer = encoder.container(keyedBy: CodingKeys.self)
        
        try contrainer.encode(self.name, forKey: .name)
        try contrainer.encode(self.date, forKey: .date)
        try contrainer.encode(self.score, forKey: .score)
    }
    
    
    }
