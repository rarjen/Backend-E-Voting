/*
  Warnings:

  - You are about to drop the column `vice_presidential_partner_id` on the `Presidental_candidate` table. All the data in the column will be lost.
  - Added the required column `presidental_partner_id` to the `Vice_presidental_candidate` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Presidental_candidate" DROP CONSTRAINT "Presidental_candidate_vice_presidential_partner_id_fkey";

-- AlterTable
ALTER TABLE "Presidental_candidate" DROP COLUMN "vice_presidential_partner_id";

-- AlterTable
ALTER TABLE "Vice_presidental_candidate" ADD COLUMN     "presidental_partner_id" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Vice_presidental_candidate" ADD CONSTRAINT "Vice_presidental_candidate_presidental_partner_id_fkey" FOREIGN KEY ("presidental_partner_id") REFERENCES "Presidental_candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;
