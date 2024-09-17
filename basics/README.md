# Go (Golang) Basics

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
   - [Windows](#windows)
   - [macOS](#macos)
   - [Linux](#linux)
3. [Setting Up Your Environment](#setting-up-your-environment)
4. [Basic Concepts](#basic-concepts)
   - [Hello World](#hello-world)
   - [Variables](#variables)
   - [Functions](#functions)
   - [Control Structures](#control-structures)
   - [Data Structures](#data-structures)
5. [Running Your Go Code](#running-your-go-code)
6. [Further Reading](#further-reading)

---

## Introduction

Go, often referred to as Golang, is an open-source programming language developed by Google. It is designed to be simple, efficient, and reliable, with strong support for concurrent programming.

## Installation

### Windows

1. **Download Go Installer**
   - Go to the [Go downloads page](https://golang.org/dl/).
   - Download the Windows installer (`.msi` file) for your system architecture (e.g., `go1.20.4.windows-amd64.msi`).

2. **Run the Installer**
   - Double-click the downloaded `.msi` file and follow the installation prompts.
   - The default installation path is `C:\Go`.

3. **Verify Installation**
   - Open Command Prompt and type `go version`. You should see the Go version information.

### macOS

1. **Install Using Homebrew**
   - Open Terminal and run the following command to install Homebrew if you haven’t already:
     ```sh
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```
   - Install Go with Homebrew:
     ```sh
     brew install go
     ```

2. **Verify Installation**
   - In Terminal, type `go version` to check if Go was installed correctly.

3. **Alternative Installation**
   - Download the macOS binary (`.pkg` file) from the [Go downloads page](https://golang.org/dl/).
   - Open the downloaded `.pkg` file and follow the installation instructions.

### Linux

1. **Download and Extract**
   - Open Terminal and download the latest Go tarball from the [Go downloads page](https://golang.org/dl/):
     ```sh
     wget https://golang.org/dl/go1.20.4.linux-amd64.tar.gz
     ```
   - Extract the tarball:
     ```sh
     sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
     ```

2. **Set Up Environment Variables**
   - Add Go binary to your PATH. Open or create `~/.profile` or `~/.bashrc` and add:
     ```sh
     export PATH=$PATH:/usr/local/go/bin
     ```
   - Reload the profile:
     ```sh
     source ~/.profile
     ```

3. **Verify Installation**
   - Type `go version` in Terminal to verify the installation.

## Setting Up Your Environment

1. **Create a Workspace**
   - Create a directory for your Go projects:
     ```sh
     mkdir -p ~/go/src
     ```
   - Set the `GOPATH` environment variable to this directory. Add the following to `~/.profile` or `~/.bashrc`:
     ```sh
     export GOPATH=$HOME/go
     export PATH=$PATH:$GOPATH/bin
     ```
   - Reload the profile:
     ```sh
     source ~/.profile
     ```

2. **Create a Go Module**
   - Initialize a new Go module in your project directory:
     ```sh
     mkdir myproject
     cd myproject
     go mod init myproject
     ```

## Basic Concepts

### Hello World

1. **Create a New File**
   - Create a file named `main.go` in your project directory with the following content:
     ```go
     package main

     import "fmt"

     func main() {
         fmt.Println("Hello, World!")
     }
     ```

2. **Run the Program**
   - Execute the program by running:
     ```sh
     go run main.go
     ```

### Variables

1. **Declaring Variables**
   - Variables can be declared using the `var` keyword or using shorthand syntax:
     ```go
     var name string = "John"
     age := 30
     ```

2. **Constant Declaration**
   - Constants are declared using the `const` keyword:
     ```go
     const Pi = 3.14
     ```

### Functions

1. **Defining a Function**
   - Functions are defined with the `func` keyword:
     ```go
     func greet(name string) string {
         return "Hello, " + name
     }
     ```

2. **Calling a Function**
   - Call the function in `main`:
     ```go
     func main() {
         message := greet("Alice")
         fmt.Println(message)
     }
     ```

### Control Structures

1. **If Statements**
   - Example of an `if` statement:
     ```go
     if age > 18 {
         fmt.Println("Adult")
     } else {
         fmt.Println("Minor")
     }
     ```

2. **For Loops**
   - Example of a `for` loop:
     ```go
     for i := 0; i < 5; i++ {
         fmt.Println(i)
     }
     ```

### Data Structures

1. **Arrays**
   - Example of an array:
     ```go
     var numbers [5]int
     numbers[0] = 1
     ```

2. **Slices**
   - Slices are more flexible than arrays:
     ```go
     fruits := []string{"apple", "banana", "cherry"}
     ```

3. **Maps**
   - Example of a map:
     ```go
     ages := make(map[string]int)
     ages["Alice"] = 30
     ```

4. **Structs**
   - Example of a struct:
     ```go
     type Person struct {
         Name string
         Age  int
     }

     func main() {
         p := Person{Name: "John", Age: 25}
         fmt.Println(p)
     }
     ```

## Running Your Go Code

1. **Run a Go File**
   - Use the `go run` command followed by the filename:
     ```sh
     go run main.go
     ```

2. **Build an Executable**
   - Build the Go file into an executable:
     ```sh
     go build main.go
     ```
   - Run the generated executable:
     ```sh
     ./main
     ```

## Further Reading

- [The Go Programming Language Documentation](https://golang.org/doc/)
- [Effective Go](https://golang.org/doc/effective_go.html)
- [A Tour of Go](https://tour.golang.org/welcome/1)
- [Go by Example](https://gobyexample.com/)

---

