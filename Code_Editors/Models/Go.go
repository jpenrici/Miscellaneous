// main.go

package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	cmd := exec.Command("uname", "-a")
	output, err := cmd.Output()

	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	res := string(output)
	fmt.Println("Kernel:", strings.ToUpper(res))
}

// Formatter
// go fmt main.go

// Run script
// go run main.go
