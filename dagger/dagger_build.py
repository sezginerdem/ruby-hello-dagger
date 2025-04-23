import dagger
import asyncio

async def main():
    # Houdini motoru ile bağlantı kur
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        # Basit bir build örneği (örnek olarak bir 'alpine' konteyneri çalıştırıyoruz)
        ctr = (
            client.container()
            .from_("alpine")
            .with_exec(["echo", "✅ Dagger Houdini Python ile çalıştı!"])
        )

        output = await ctr.stdout()
        print("📦 Çıktı:", output)

if __name__ == "__main__":
    import sys
    asyncio.run(main())
