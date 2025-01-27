package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

// Main function to set up routes and start the server
func main() {
	http.HandleFunc("/is-prime/", isPrimeHandler)
	http.HandleFunc("/next-prime/", nextPrimeHandler)
	http.HandleFunc("/healthz", healthCheckHandler)

	port := ":8080"
	fmt.Println("Starting to sleep 30 seconds")
	time.Sleep(30 * time.Second)
	fmt.Printf("Starting server on port %s...\n", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
