//
//  HashTest.swift
//  HashTest
//
//  Created by hyunsu on 2021/05/27.
//

import XCTest
@testable import CustomHashMap

class HashTest: XCTestCase {

    func test_10개사이즈로_key로1에넣으면_index1에_key1가있어야한다() throws {
        var dict = CustomHashMap<Int>(10)
        dict[1] = 1
        XCTAssertTrue(dict.storage[1]?.key == 1)
    }
    
    func test_10개사이즈로_key로1에넣고_key11를넣는다면_index2에_key11가있어야한다() throws {
        var dict = CustomHashMap<Int>(10)
        dict[1] = 1
        dict[11] = 11
        XCTAssertTrue(dict.storage[2]?.key == 11)
    }
    
    func test_10개사이즈로_key로1에넣고_key11를넣고_key11를삭제하고_key2를넣는다면_index3에_key2가있어야한다() {
        var dict = CustomHashMap<Int>(10)
        dict[1] = 1
        dict[11] = 11
        dict[11] = nil
        dict[2] = 2
        XCTAssertTrue(dict.storage[3]?.key == 2)
    }

    func test_10개사이즈로_key로1에넣고_key11를넣고_key11를삭제하면_index2에_key가_nil이여야한다() {
        var dict = CustomHashMap<Int>(10)
        dict[1] = 1
        dict[11] = 11
        dict[11] = nil
        XCTAssertNotNil(dict.storage[2]!.key == nil )
    }
    
    func test_10개사이즈로_key0에넣고_key9에넣고_key99를넣는다면_index1에_key99가있어야한다() {
        let size = 10
        var dict = CustomHashMap<Int>(size)
        dict[0] = 0
        dict[9] = 9
        dict[99] = 99
        XCTAssertTrue(dict.storage[1]!.key == 99)
    }
    
    func test_10개사이즈로_6개를넣었다면_resizing되어_capacity가_2배되어야한다() {
        let size = 10
        var dict = CustomHashMap<Int>(size)
        dict[1] = 1
        dict[2] = 2
        dict[3] = 3
        dict[4] = 4
        dict[5] = 5
        dict[6] = 6
        XCTAssertTrue(dict.capacity == size*2)
    }

    func test_10개사이즈로_삽입21번한다면_resizing2번되어_capacity가_80이되어야한다() {
        let size = 10
        var dict = CustomHashMap<Int>(size)
        for i in 0..<21 {
            dict[i] = i
        }
        XCTAssertTrue(dict.capacity == 80, "\(dict.capacity)")
    }

}
