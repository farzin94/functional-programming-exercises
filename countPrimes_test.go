package a1

import (
    "testing"
    "reflect"
    // "fmt"
)

func TestFunctions(t *testing.T) {

	if countPrimes(10000) != 1229 {
    	t.Error("countPrimes: Expected 1229, got ", countPrimes(10000))
	}

    if countPrimes(5) != 3 {
        t.Error("countPrimes: Expected 3, got ", countPrimes(5))
    }

    if countPrimes(-10) > 0 {
        t.Error("countPrimes: Expected 0, got ", countPrimes(-10))
    }

    wordCount := countStrings("dogApple.txt")

    if wordCount["big"] != 3 {
        t.Error("CountStrings: Expected 3, got ", wordCount["big"])
    }

    if wordCount["The"] != 1 {
        t.Error("CountStrings: Expected 1, got ", wordCount["The"])
    }

    if wordCount["apple"] != 1 {
        t.Error("CountStrings: Expected 1, got ", wordCount["apple"])
    }

    if wordCount["ate"] != 1 {
        t.Error("CountStrings: Expected 1, got ", wordCount["ate"])
    }

    if wordCount["the"] != 1 {
        t.Error("CountStrings: Expected 1, got ", wordCount["the"])
    }

    if wordCount["dog"] != 1 {
        t.Error("CountStrings: Expected 1, got ", wordCount["dog"])
    }

    if linearSearch("b", []string{"abc", "a", "b"}) != 2 {
        t.Error("linearSearch: Expected 2, got ", linearSearch("b", []string{"abc", "a", "b"}) )
    }

    if linearSearch(3, []int{4, 2, -1, 5, 0}) != -1 {
        t.Error("linearSearch: Expected 2, got ", linearSearch(3, []int{4, 2, -1, 5, 0}) )
    }

    if linearSearch(2, []int{2, 4, 3}) != 0 {
        t.Error("linearSearch: Expected 0, got ", linearSearch(2, []int{2, 4, 3}) )
    }

    if linearSearch("up", []string{"cat", "nose", "egg"}) != -1 {
        t.Error("linearSearch: Expected 2, got ", linearSearch("up", []string{"cat", "nose", "egg"}) )
    }

    timeA := Time24{hour: 5, minute: 40, second: 4}
    timeB := Time24{hour: 3, minute: 33, second: 8}
    timeC := Time24{hour: 2, minute: 39, second: 6}

    if equalsTime24(timeA, timeB) != false {
        t.Error("equalsTime24: Expected false, got ", equalsTime24(timeA, timeB) )
    }

    if lessThanTime24(timeC, timeB) != true {
        t.Error("lessThanTime24: Expected true, got ", lessThanTime24(timeC, timeB) )
    }

    if timeA.String() != "05:40:04" {
        t.Error("String(): Expected 05:40:04, got ", timeA.String() )

    }

    if timeA.validTime24() != true {
        t.Error("validTime24(): Expected true, got", timeA.validTime24())
    }

    b := []Time24{timeA, timeB, timeC}
    checkMinTime, err := minTime24(b)

    if (err != nil) {
        panic(err)
    }

    if checkMinTime.hour != timeC.hour {
        t.Error("minTime24: Expected 2, got", checkMinTime.hour)
    }

    if checkMinTime.minute != timeC.minute {
        t.Error("minTime24: Expected 39, got", checkMinTime.minute)
    }

    if checkMinTime.second != timeC.second {
        t.Error("minTime24: Expected 6, got", checkMinTime.second)
    }

    // seqs := [2][2]int{}
    // seqs[0][0] = 0
    // seqs[1][0] = 1
    if !reflect.DeepEqual(allBitSeqs(0), [][]int{}) {
        t.Error("allBitSeqs: Expected empty array, got", allBitSeqs(0))
    }

    seq1 := allBitSeqs(1)
    if seq1[0][0] != 0 {
        t.Error("allBitSeqs: Expected 0, got", seq1[0][0])
    }

    if seq1[1][0] != 1 {
        t.Error("allBitSeqs: Expected 1, got", seq1[1][0])
    }

    seq2 := allBitSeqs(2)
    if seq2[0][0] != 0 {
        t.Error("allBitSeqs: Expected 0, got", seq2[0][0])
    }
    if seq2[0][1] != 0 {
        t.Error("allBitSeqs: Expected 0, got", seq2[0][1])
    }
    if seq2[1][0] != 0 {
        t.Error("allBitSeqs: Expected 0, got", seq2[1][0])
    }
    if seq2[1][1] != 1 {
        t.Error("allBitSeqs: Expected 1, got", seq2[1][1])
    }
    if seq2[2][0] != 1 {
        t.Error("allBitSeqs: Expected 1, got", seq2[2][0])
    }
    if seq2[3][1] != 1 {
        t.Error("allBitSeqs: Expected 1, got", seq2[3][1])
    }
}