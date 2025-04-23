import dagger
import asyncio

async def main():
    print("🔌 Connecting to Dagger Engine with Houdini runtime")
    async with dagger.Connection() as client:
        # Basit bir echo container örneği çalıştıralım
        ctr = client.container().from_("alpine").with_exec(["echo", "Hello from Dagger with Python!"])

        # Çıktıyı al
        output = await ctr.stdout()
        print("📤 Container Output:", output)

if __name__ == "__main__":
    asyncio.run(main())
