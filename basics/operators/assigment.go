package main

import "fmt"

func main() {
	//assignment operators 

    var a, b int = 10, 5
    var c, d string = "Tech with Bansikah", "Tech with Bansikah"

    a += b
    fmt.Println("a += b: ", a)

    a -= b
    fmt.Println("a -= b: ", a)

    a *= b
    fmt.Println("a *= b: ", a)

    a /= b
    fmt.Println("a /= b: ", a)

    a %= b
    fmt.Println("a %= b: ", a)

    c += d
    fmt.Println("c += d: ", c)
}