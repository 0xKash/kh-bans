-- CreateTable
CREATE TABLE "public"."Ban" (
    "id" TEXT NOT NULL,
    "reason" TEXT NOT NULL DEFAULT 'Default ban reason',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "ip" TEXT,
    "hardware" TEXT,
    "steam" TEXT,
    "discord" TEXT,
    "xbl" TEXT,
    "license" TEXT,
    "license2" TEXT,
    "fivem" TEXT,

    CONSTRAINT "Ban_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Ban_ip_key" ON "public"."Ban"("ip");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_hardware_key" ON "public"."Ban"("hardware");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_steam_key" ON "public"."Ban"("steam");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_discord_key" ON "public"."Ban"("discord");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_xbl_key" ON "public"."Ban"("xbl");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_license_key" ON "public"."Ban"("license");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_license2_key" ON "public"."Ban"("license2");

-- CreateIndex
CREATE UNIQUE INDEX "Ban_fivem_key" ON "public"."Ban"("fivem");
