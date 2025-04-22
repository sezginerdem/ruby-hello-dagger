package main

import (
	"context"
	"fmt"
	"log"

	"dagger.io/dagger"
)

func main() {
	ctx := context.Background()

	fmt.Println("🔌 Connecting to Dagger Engine (Houdini)...")
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(log.Writer()))
	if err != nil {
		log.Fatalf("❌ Connection failed: %v", err)
	}
	defer client.Close()

	// Örnek: basit bir alpine container oluştur ve echo çalıştır
	output, err := client.Container().
		From("alpine").
		WithExec([]string{"echo", "Merhaba, Dagger Go!"}).
		Stdout(ctx)
	if err != nil {
		log.Fatalf("❌ Container execution failed: %v", err)
	}

	fmt.Println("✅ Output:")
	fmt.Println(output)
}
