package main

import "fmt"

func main() {
	//comparison operators
	var a, b int = 10, 5
    var c, d string = "Tech with Bansikah", "Tech with Bansikah"

    result := a == b
    result1 := a != b
    result2 := a < b
    result3 := a <= b
    result4 := a > b
    result5 := a >= b
    result6 := c == d
    result7 := c != d

    fmt.Println(result)
    fmt.Println(result1)
    fmt.Println(result2)
    fmt.Println(result3)
    fmt.Println(result4)
    fmt.Println(result5)
    fmt.Println(result6)
    fmt.Println(result7)
}