package main

import "fmt"

func main() {
	p:= 64
	q:= 32

	result:= p+q
	fmt.Println("Sum of p and q: ", result)
	result= p-q
	fmt.Println("Difference of p and q: ", result)
	result= p*q
	fmt.Println("Product of p and q: ", result)
	result= p/q
	fmt.Println("Quotient of p and q: ", result)
	result= p%q
	fmt.Println("Remainder of p and q: ", result)
	// result= p<<q
	// fmt.Println("Left shift of p by q: ", result)
	// result= p>>q
	// fmt.Println("Right shift of p by q: ", result)
	// result= ^p
	// fmt.Println("Bitwise NOT of p: ", result)
	// result= p&q
	// fmt.Println("Bitwise AND of p and q: ", result)
}