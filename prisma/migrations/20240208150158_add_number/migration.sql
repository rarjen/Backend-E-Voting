/*
  Warnings:

  - Added the required column `number` to the `Candidate_pair_number` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Candidate_pair_number" ADD COLUMN     "number" INTEGER NOT NULL;
