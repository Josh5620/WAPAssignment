/**
 * Maps frontend numeric chapter IDs to database GUIDs
 * This bridges the garden path UI (1-10) with database chapters
 */

export const chapterIdMapping = {
  // Python Course - Seedling Path (from 04-python-flashcards.sql)
  1: 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', // Intro to Python
  2: 'b8b24cad-1860-4bb1-86da-7a66351a5c39', // Conditionals & Loops
  3: 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', // Functions & Modules
  4: '007ccfb7-e6f4-493f-85ae-66520c4231c5', // Data Structures
  5: 'f47f15f7-9d05-4509-9d5f-0926793c429e', // File I/O & Exceptions
  // Add more chapters as they're added to the database
};

/**
 * Get database GUID for a numeric chapter ID
 */
export const getDatabaseChapterId = (numericId) => {
  const guid = chapterIdMapping[numericId];
  if (!guid) {
    console.warn(`No database mapping found for chapter ${numericId}`);
  }
  return guid;
};

/**
 * Get numeric ID from database GUID (reverse lookup)
 */
export const getNumericChapterId = (guid) => {
  const entry = Object.entries(chapterIdMapping).find(([_, value]) => value === guid);
  return entry ? parseInt(entry[0]) : null;
};
