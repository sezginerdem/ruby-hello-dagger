import dagger
import asyncio

async def main():
    async with dagger.Connection() as client:
        # Dagger task: örneğin bir build, test ya da echo
        ctr = (
            client.container()
            .from_("alpine")
            .with_exec(["echo", "Hello from Dagger inside Concourse!"])
        )

        out = await ctr.stdout()
        print(out)

if __name__ == "__main__":
    asyncio.run(main())