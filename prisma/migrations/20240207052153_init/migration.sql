-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "nik" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Presidental_candidate" (
    "id" TEXT NOT NULL,
    "political_party_id" TEXT NOT NULL,
    "vice_presidential_partner_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Presidental_candidate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vice_presidental_candidate" (
    "id" TEXT NOT NULL,
    "political_party_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Vice_presidental_candidate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Political_party" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Political_party_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Candidate_pair_number" (
    "id" TEXT NOT NULL,
    "presidental_candidate_id" TEXT NOT NULL,
    "vice_presidental_candidate_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Candidate_pair_number_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supporting_party" (
    "id" TEXT NOT NULL,
    "candidate_pair_number_id" TEXT NOT NULL,
    "political_party_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Supporting_party_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Voting_log" (
    "id" TEXT NOT NULL,
    "encrypted_user_id" TEXT NOT NULL,
    "encrypted_candidate_number" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Voting_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Voting_result" (
    "id" TEXT NOT NULL,
    "candidate_pair_number_id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Voting_result_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Presidental_candidate" ADD CONSTRAINT "Presidental_candidate_political_party_id_fkey" FOREIGN KEY ("political_party_id") REFERENCES "Political_party"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Presidental_candidate" ADD CONSTRAINT "Presidental_candidate_vice_presidential_partner_id_fkey" FOREIGN KEY ("vice_presidential_partner_id") REFERENCES "Vice_presidental_candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vice_presidental_candidate" ADD CONSTRAINT "Vice_presidental_candidate_political_party_id_fkey" FOREIGN KEY ("political_party_id") REFERENCES "Political_party"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Candidate_pair_number" ADD CONSTRAINT "Candidate_pair_number_presidental_candidate_id_fkey" FOREIGN KEY ("presidental_candidate_id") REFERENCES "Presidental_candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Candidate_pair_number" ADD CONSTRAINT "Candidate_pair_number_vice_presidental_candidate_id_fkey" FOREIGN KEY ("vice_presidental_candidate_id") REFERENCES "Vice_presidental_candidate"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Supporting_party" ADD CONSTRAINT "Supporting_party_candidate_pair_number_id_fkey" FOREIGN KEY ("candidate_pair_number_id") REFERENCES "Candidate_pair_number"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Supporting_party" ADD CONSTRAINT "Supporting_party_political_party_id_fkey" FOREIGN KEY ("political_party_id") REFERENCES "Political_party"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Voting_result" ADD CONSTRAINT "Voting_result_candidate_pair_number_id_fkey" FOREIGN KEY ("candidate_pair_number_id") REFERENCES "Candidate_pair_number"("id") ON DELETE CASCADE ON UPDATE CASCADE;
