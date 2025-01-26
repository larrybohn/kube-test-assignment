package main

import (
	"fmt"
	"log"
	"net/http"
)

// Main function to set up routes and start the server
func main() {
	http.HandleFunc("/is-prime/", isPrimeHandler)
	http.HandleFunc("/next-prime/", nextPrimeHandler)

	port := ":8080"
	fmt.Printf("Starting server on port %s...\n", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
