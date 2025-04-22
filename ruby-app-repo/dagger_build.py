import dagger
import asyncio
from pathlib import Path

async def main():
    async with dagger.Connection() as client:
        # 1. Concourse modülünü yükle
        concourse_mod = await client.module("github.com/vito/daggerverse/concourse")

        # 2. Postgres ve Concourse container'larını başlat
        concourse = await concourse_mod.concourse(
            image="concourse/concourse:7.9.1",
            postgres_image="postgres:15",
            port=8080,
            runtime="containerd"  # Alternatif: "houdini"
        )

        # 3. Concourse container logunu göster
        logs = await concourse.container().stdout()
        print("📜 Concourse Container Log:\n", logs)

        # 4. Pipeline config.yaml dosyasını oku
        config_file = await client.host().directory(".").file("pipeline.yaml")

        # 5. Pipeline dosyasını yükle
        pipeline = await concourse_mod.load_pipeline(config_file=config_file)

        # 6. Pipeline'daki job isimlerini ve konfigürasyonlarını göster
        print("✅ Pipeline içindeki işler:")
        for job_def in await pipeline.jobs():
            job_name = await job_def.name()
            job_config = await job_def.config()
            print(f"🔧 Job: {job_name}")
            print(f"📄 Config:\n{job_config}")

            # 7. Job'u çalıştır
            print(f"🚀 Job '{job_name}' çalıştırılıyor...")
            await job_def.run()
            print(f"✅ Job '{job_name}' tamamlandı.\n")

if __name__ == "__main__":
    asyncio.run(main())
