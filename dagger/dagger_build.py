import dagger
import asyncio

async def main():
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        # Build container from Python image
        python = client.container().from_("python:3.11-slim")

        # Run Python command inside container
        result = await python.with_exec(["python3", "--version"]).stdout()

        print("Python version inside container:", result.strip())

if __name__ == "__main__":
    import sys
    asyncio.run(main())
