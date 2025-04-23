import dagger
import asyncio

async def main():
    # Houdini kullanımı için bağlantıyı başlat
    async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:
        print("🔗 Dagger bağlantısı kuruldu")

        # Örnek bir işlem: dosya oluştur ve içeriğini yaz
        src = client.host().directory(".")
        readme_file = await src.file("README.md").contents()
        print("📄 README.md içeriği:")
        print(readme_file)

        # Alternatif olarak, bir dosya yazılabilir:
        await client.host().directory("output").file("result.txt").write("Hello from Dagger + Python + Houdini!")

        print("✅ İşlem tamamlandı.")

if __name__ == "__main__":
    import sys
    asyncio.run(main())
