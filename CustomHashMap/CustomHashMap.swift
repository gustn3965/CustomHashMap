//
//  CustomHashMap.swift
//  CustomHashMap
//
//  Created by hyunsu on 2021/05/27.
//


struct CustomHashMap<Value> {

    typealias Key = Int
    
    struct Bucket {
        var key: Key?
        var value: Value?
    }
    
    // MARK: - Property
    var storage = [Bucket?]()
    var capacity: Int
    var usage = 0
    var totalUsage: Int = 0
    
    // MARK: - Method
    init(_ capacity: Int ) {
        self.capacity = capacity
        self.storage = Array(repeating: nil, count: capacity)
    }
    
    subscript(key: Key) -> Value? {
        mutating get {
            let (found, hashedKey) = find(&storage, key)
            if found {
                return storage[hashedKey]?.value
            } else {
                return nil
            }
        }
        set {
            let (found, hashedKey) = find(&storage, key)
            if let value = newValue {
                if found {
                    update(hashedKey, value)
                } else {
                    insert(hashedKey: hashedKey, Bucket(key: key, value: value))
                }
            } else {
                if found {
                    remove(hashedKey)
                }
            }
        }
    }
    
    // Find hashedKey.
    // if found is true, hashedKey is that
    // if found is false, hashedKey is empty key.
    func find(_ storage: inout [Bucket?], _ key: Key) -> (found: Bool, hashedKey: Int) {
        var hashed = getKey(key: key)
        var findKey: Int = 0
        var count = 0
        
        while count < capacity {
            if storage[hashed]?.key == key ||
                storage[hashed] == nil {
                findKey = hashed
                break
            }
            hashed = hashed == capacity-1 ? 0 : hashed+1
            count += 1
        }

        let find = storage[hashed]?.key == key
        return (find, findKey)
    }
    
    mutating func remove(_ hashedKey: Int) {
        storage[hashedKey]?.key = nil
        usage -= 1
        totalUsage += 1 
    }
    
    mutating func update(_ hashedKey: Int, _ value: Value ) {
        storage[hashedKey]?.value = value
    }
    
    mutating func insert( hashedKey: Int, _ bucket: Bucket ) {
        storage[hashedKey] = bucket
        usage += 1
        totalUsage += 1
        if totalUsage > capacity/2 {
            resize()
        }
    }
    
    func getKey(key: Int) -> Int {
        return key%capacity
    }
    
    mutating func resize() {
        var new: [Bucket?] = Array(repeating: nil, count: capacity*2)
        let before = capacity
        capacity*=2
        for i in 0..<before {
            if let key = storage[i]?.key {
                let (_, hashed) = find(&new, key)
                new[hashed] = storage[i]
            }
        }
        storage = new
        totalUsage = usage
    }
}
