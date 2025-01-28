package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

var version string

// Main function to set up routes and start the server
func main() {
	fmt.Printf("Starting app version %s...\n", version)

	http.HandleFunc("/is-prime/", isPrimeHandler)
	http.HandleFunc("/next-prime/", nextPrimeHandler)
	http.HandleFunc("/version", versionHandler)
	http.HandleFunc("/healthz", healthCheckHandler)

	//hang indefinitely if requested to simulate failure
	if strings.ToLower(os.Getenv("SIMULATE_FAILURE")) == "true" {
		fmt.Println("Hanging forever")
		time.Sleep(1000 * time.Hour)
	}

	port := ":8080"
	fmt.Println("Starting to sleep 15 seconds")
	time.Sleep(15 * time.Second)
	fmt.Printf("Starting server on port %s...\n", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
