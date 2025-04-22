import dagger
import asyncio

async def main():
    async with dagger.Connection() as client:
        # Git reposundaki kodu al
        src = client.host().directory(".")

        # Bir container'da kodu çalıştır
        out = await client.container().from_("alpine:latest")\
            .with_exec(["echo", "Dagger Concourse entegrasyonu başarılı!"])\
            .stdout()

        print(out)

if __name__ == "__main__":
    asyncio.run(main())
