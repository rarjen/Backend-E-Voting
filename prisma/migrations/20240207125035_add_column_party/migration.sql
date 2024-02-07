/*
  Warnings:

  - Added the required column `abbreviation` to the `Political_party` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Political_party` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Political_party" ADD COLUMN     "abbreviation" TEXT NOT NULL,
ADD COLUMN     "description" TEXT NOT NULL;
