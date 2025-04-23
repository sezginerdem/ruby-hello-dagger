package main

import (
	"context"
	"fmt"

	"dagger.io/dagger"
)

func main() {
	ctx := context.Background()

	// Houdini kullanarak bağlantı kur
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(nil))
	if err != nil {
		fmt.Printf("❌ Connection failed: %v\n", err)
		return
	}
	defer client.Close()

	// Bir container oluştur ve komut çalıştır
	out, err := client.Container().
		From("alpine").
		WithExec([]string{"echo", "Hello from Dagger + Houdini!"}).
		Stdout(ctx)
	if err != nil {
		fmt.Printf("❌ Exec failed: %v\n", err)
		return
	}

	fmt.Println("✅ Output:", out)
}
