package main

import (
	"context"
	"fmt"
	"log"

	"dagger.io/dagger"
)

func main() {
	ctx := context.Background()

	// Houdini runtime kullanarak Dagger client'ı başlat
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(log.Writer()))
	if err != nil {
		log.Fatalf("❌ Failed to connect to Dagger: %v", err)
	}
	defer client.Close()

	// Alpine container ile basit bir echo çalıştır
	container := client.Container().
		From("alpine").
		WithExec([]string{"echo", "Hello from Dagger inside Concourse
