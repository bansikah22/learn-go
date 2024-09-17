package main

import "fmt"

func main() {
	//logical operators
	var a, b bool = true, false
    fmt.Println("Logical AND:", a && b)
    fmt.Println("Logical OR:", a || b)
    fmt.Println("Logical NOT:", !a)
    fmt.Println("Logical XOR:", a != b)
}