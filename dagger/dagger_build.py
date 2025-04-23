import dagger
import asyncio

async def main():
    # Dagger istemcisine bağlan
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        # Dagger ortamında basit bir işlem: Python container'ı oluştur ve bir komut çalıştır
        python_container = (
            client.container()
            .from_("python:3.11-slim")
            .with_exec(["python", "-c", "print('Merhaba Dagger! 🎯')"])
        )

        # Çıktıyı al ve yazdır
        output = await python_container.stdout()
        print("🖨️ Çıktı:")
        print(output)

if __name__ == "__main__":
    asyncio.run(main())
