-- AlterTable
ALTER TABLE "reservations" ADD COLUMN "order_id" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "reservations_order_id_key" ON "reservations"("order_id");

-- AddForeignKey
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;
