-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `nik` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` VARCHAR(255) NOT NULL DEFAULT 'VOTER',
    `isVoted` BOOLEAN NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Presidental_candidate` (
    `id` VARCHAR(191) NOT NULL,
    `political_party_id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `age` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `img_url` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Vice_presidental_candidate` (
    `id` VARCHAR(191) NOT NULL,
    `political_party_id` VARCHAR(191) NOT NULL,
    `presidental_partner_id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `age` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `img_url` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Political_party` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `abbreviation` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `img_url` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Candidate_pair_number` (
    `id` VARCHAR(191) NOT NULL,
    `presidental_candidate_id` VARCHAR(191) NOT NULL,
    `vice_presidental_candidate_id` VARCHAR(191) NOT NULL,
    `number` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Supporting_party` (
    `id` VARCHAR(191) NOT NULL,
    `candidate_pair_number_id` VARCHAR(191) NOT NULL,
    `political_party_id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Voting_log` (
    `id` VARCHAR(191) NOT NULL,
    `encrypted_user_id` VARCHAR(191) NOT NULL,
    `encrypted_candidate_number` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Voting_result` (
    `id` VARCHAR(191) NOT NULL,
    `candidate_pair_number_id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Presidental_candidate` ADD CONSTRAINT `Presidental_candidate_political_party_id_fkey` FOREIGN KEY (`political_party_id`) REFERENCES `Political_party`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Vice_presidental_candidate` ADD CONSTRAINT `Vice_presidental_candidate_political_party_id_fkey` FOREIGN KEY (`political_party_id`) REFERENCES `Political_party`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Vice_presidental_candidate` ADD CONSTRAINT `Vice_presidental_candidate_presidental_partner_id_fkey` FOREIGN KEY (`presidental_partner_id`) REFERENCES `Presidental_candidate`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Candidate_pair_number` ADD CONSTRAINT `Candidate_pair_number_presidental_candidate_id_fkey` FOREIGN KEY (`presidental_candidate_id`) REFERENCES `Presidental_candidate`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Candidate_pair_number` ADD CONSTRAINT `Candidate_pair_number_vice_presidental_candidate_id_fkey` FOREIGN KEY (`vice_presidental_candidate_id`) REFERENCES `Vice_presidental_candidate`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Supporting_party` ADD CONSTRAINT `Supporting_party_candidate_pair_number_id_fkey` FOREIGN KEY (`candidate_pair_number_id`) REFERENCES `Candidate_pair_number`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Supporting_party` ADD CONSTRAINT `Supporting_party_political_party_id_fkey` FOREIGN KEY (`political_party_id`) REFERENCES `Political_party`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Voting_result` ADD CONSTRAINT `Voting_result_candidate_pair_number_id_fkey` FOREIGN KEY (`candidate_pair_number_id`) REFERENCES `Candidate_pair_number`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
