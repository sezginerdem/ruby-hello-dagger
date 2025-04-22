package main

import (
	"context"
	"fmt"
	"log"

	"dagger.io/dagger"
)

func main() {
	ctx := context.Background()

	// Houdini ile bağlantı başlat
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(log.Writer()))
	if err != nil {
		log.Fatalf("❌ Connection failed: %v", err)
	}
	defer client.Close()

	// Ubuntu container oluştur
	ctr := client.Container().
		From("ubuntu:22.04").
		WithExec([]string{"echo", "✅ Dagger + Go (Houdini) başarıyla çalışıyor!"})

	// Sonucu al
	out, err := ctr.Stdout(ctx)
	if err != nil {
		log.Fatalf("❌ Container log alınamadı: %v", err)
	}

	fmt.Println("📦 Çıktı:")
	fmt.Println(out)
}
