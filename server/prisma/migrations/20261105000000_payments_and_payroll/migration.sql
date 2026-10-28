CREATE TYPE "PaymentPurpose" AS ENUM ('ORDER', 'RESERVATION');
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'PAID', 'FAILED', 'CANCELLED');
CREATE TYPE "PayoutMethod" AS ENUM ('BANK', 'BKASH', 'NAGAD', 'ROCKET', 'CASH');

ALTER TABLE "users" ADD COLUMN "monthly_salary" DECIMAL(10,2);
ALTER TABLE "orders" ADD COLUMN "advance_paid" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "reservations" ADD COLUMN "advance_paid" BOOLEAN NOT NULL DEFAULT false;

CREATE TABLE "payments" (
  "id" TEXT NOT NULL,
  "tran_id" TEXT NOT NULL,
  "purpose" "PaymentPurpose" NOT NULL,
  "status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
  "amount" DECIMAL(10,2) NOT NULL,
  "currency" TEXT NOT NULL DEFAULT 'BDT',
  "gateway" TEXT NOT NULL DEFAULT 'SSLCOMMERZ',
  "customer_id" TEXT NOT NULL,
  "order_id" TEXT,
  "reservation_id" TEXT,
  "val_id" TEXT,
  "bank_tran_id" TEXT,
  "card_type" TEXT,
  "failure_reason" TEXT,
  "paid_at" TIMESTAMP(3),
  "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP(3) NOT NULL,
  CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "payments_tran_id_key" ON "payments"("tran_id");
CREATE INDEX "payments_order_id_idx" ON "payments"("order_id");
CREATE INDEX "payments_reservation_id_idx" ON "payments"("reservation_id");
ALTER TABLE "payments" ADD CONSTRAINT "payments_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "payments" ADD CONSTRAINT "payments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "payments" ADD CONSTRAINT "payments_reservation_id_fkey" FOREIGN KEY ("reservation_id") REFERENCES "reservations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE "salary_payments" (
  "id" TEXT NOT NULL,
  "staff_id" TEXT NOT NULL,
  "period" TEXT NOT NULL,
  "amount" DECIMAL(10,2) NOT NULL,
  "method" "PayoutMethod" NOT NULL,
  "reference" TEXT,
  "note" TEXT,
  "paid_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "paid_by_id" TEXT NOT NULL,
  "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "salary_payments_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "salary_payments_staff_id_period_key" ON "salary_payments"("staff_id", "period");
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_staff_id_fkey" FOREIGN KEY ("staff_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_paid_by_id_fkey" FOREIGN KEY ("paid_by_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
