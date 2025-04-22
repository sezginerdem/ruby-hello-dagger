# dagger_build.py
import dagger
import asyncio

async def main():
    cfg = dagger.Config(runtime="houdini")  # sadece bu önemli
    async with dagger.Connection(cfg) as client:
        # örnek bir işlem: bir image ile container çalıştır
        container = client.container().from_("alpine").with_exec(["echo", "Hello from Dagger!"])
        output = await container.stdout()
        print("📦 Dagger Output:\n", output)

if __name__ == "__main__":
    asyncio.run(main())
