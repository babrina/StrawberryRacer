import Foundation


class Settings: Codable {
    var name = ""
    var obstacle = ""
    var carColor = ""
    
    init() {}

    
    
    init(name: String, obstacle: String, carColor: String) {
        self.name = name
        self.obstacle = obstacle
        self.carColor = carColor
         
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case obstacle, name, carColor
    }
    
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.carColor = try container.decode(String.self, forKey: .carColor)
        self.obstacle = try container.decode(String.self, forKey: .obstacle)
    }
    
    public func encode(to encoder: Encoder) throws {
        var contrainer = encoder.container(keyedBy: CodingKeys.self)
        
        try contrainer.encode(self.name, forKey: .name)
        try contrainer.encode(self.carColor, forKey: .carColor)
        try contrainer.encode(self.obstacle, forKey: .obstacle)
    }
    
    
    }
