package main
import "fmt"

func main() {
	//bitwise operators
	var a, b int = 10, 5
    fmt.Println("Bitwise AND:", a & b)
    fmt.Println("Bitwise OR:", a | b)
    fmt.Println("Bitwise XOR:", a ^ b)
    fmt.Println("Bitwise NOT:", ^a)
    fmt.Println("Left shift:", a << 2)
    fmt.Println("Right shift:", a >> 2)
    fmt.Println("Bitwise AND with 1111111111111111:", a & 0xFFFF)
    fmt.Println("Bitwise OR with 0000000000000001:", a | 1)
    fmt.Println("Bitwise XOR with 0000000000000001:", a ^ 1)
	// bitwise operators end here
}