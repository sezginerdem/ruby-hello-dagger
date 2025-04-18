import dagger
import asyncio

async def main():
    async with dagger.Connection() as client:
        src = client.host().directory(".")

        # Docker image build
        image = client.container().build(context=src)

        # Run container and capture output
        output = await image.with_exec(["ruby", "app.rb"]).stdout()
        print(f"\n✅ Container Output:\n{output}")

asyncio.run(main())