package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"strings"
)

func isPrimeHandler(w http.ResponseWriter, r *http.Request) {
	numStr := strings.TrimPrefix(r.URL.Path, "/is-prime/")
	num, err := strconv.Atoi(numStr)
	if err != nil {
		http.Error(w, "Invalid number", http.StatusBadRequest)
		return
	}
	result := isPrime(num)
	response := map[string]bool{"prime": result}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

// Handler to get the next prime after a given number
func nextPrimeHandler(w http.ResponseWriter, r *http.Request) {
	numStr := strings.TrimPrefix(r.URL.Path, "/next-prime/")
	num, err := strconv.Atoi(numStr)
	if err != nil {
		http.Error(w, "Invalid number", http.StatusBadRequest)
		return
	}
	next := nextPrime(num)
	response := map[string]int{"next_prime": next}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
