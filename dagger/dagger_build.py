import anyio
import dagger

async def main():
    async with dagger.Connection() as client:
        ctr = (
            client.container()
            .from_("python:3.11-slim")
            .with_exec(["echo", "Hello from Dagger!"])
        )
        result = await ctr.stdout()
        print(result)

anyio.run(main)
