CREATE TYPE "MilkLevel" AS ENUM ('NONE', 'LITTLE', 'MORE', 'FOAM');

ALTER TABLE "foods" ADD COLUMN "coffee_strength" INTEGER;
ALTER TABLE "foods" ADD COLUMN "milk_level" "MilkLevel";
