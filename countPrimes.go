package a1

import (
    "math"
    "fmt"
    "io/ioutil"
    "strings"
    "reflect"
    "errors"
)

type Time24 struct {
    hour, minute, second uint8
}

func minTime24(times []Time24) (Time24, error) {

    least := times[0]

    if len(times) <= 0 {
        return Time24{hour: 0, minute: 0, second: 0}, errors.New("No time entered")
    }

    for i:=0; i<len(times); i++ {

        if lessThanTime24(times[i], least) {
            least = times[i]
        }

    }

    return least, nil
}

func (t Time24) String() string {
    return fmt.Sprintf("%02d:%02d:%02d", t.hour, t.minute, t.second)
}

func (t Time24) validTime24() bool {

    if (t.hour > 0 && t.hour < 24) {
        if (t.minute > 0 && t.minute < 60) {
            if (t.second > 0 && t.second < 60) {
                return true
            }
        }
    }
    return false
}

func equalsTime24(a Time24, b Time24) bool {
    if a == b {
        return true
    }
    return false
}

func lessThanTime24(a Time24, b Time24) bool {

    aTimeSecs := a.hour*60*60 + a.minute*60 + a.second
    bTimeSecs := b.hour*60*60 + b.minute*60 + b.second

    if aTimeSecs < bTimeSecs {
        return true
    }

    return false
}

// inspired by Sieve of Eratosthenes
func countPrimes(n int) (int) {
    if (n <= 0) {
        return 0
    }

    sqrtN := math.Sqrt(float64(n))
    allNums := make([]bool, n+1)
    x := 0

    for i := 2; i <= int(sqrtN); i++ {
        if allNums[i] == false {
            for j := i*i; j <= n; j +=i {
                allNums[j] = true
            }
        }
    }

    for k := 2; k <= n; k++ {
        if !allNums[k] {
            x++
        }
    }

    return x
}

//gobyexample.com
func countStrings(fileName string) (map[string]int) {

    fileContent, err := ioutil.ReadFile(fileName)

    if (err != nil) {
        panic(err)
    }

    wordCountMap := map[string]int{}
    fileContentList := strings.Fields(string(fileContent))

    for _,value := range fileContentList {

        wordCountMap[value]++
    }

    return wordCountMap
}

func linearSearch(x interface{}, lst interface{}) (int){

    // TODO: panic if x type not equal to lst

    switch reflect.TypeOf(x).Kind() {
        case reflect.String:
            s := reflect.ValueOf(lst)
            for i := 0; i < s.Len(); i++ {
                if s.Index(i).String() == x {
                    return i
                }
            }
        case reflect.Int:
            s := reflect.ValueOf(lst)
            for i := 0; i < s.Len(); i++ {
                if int(s.Index(i).Int()) == x {
                    return i
                }
            }
    }

    return -1
}

//TODO: Bit sequences
func allBitSeqs(n int) [][]int {

    // return [[][]]

}
