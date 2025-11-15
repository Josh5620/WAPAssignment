/**
 * Maps frontend numeric chapter IDs to database GUIDs
 * This bridges the garden path UI (1-10) with database chapters
 * --- UPDATED to match the new database seed script ---
 */

export const chapterIdMapping = {
  // These GUIDs now match your new SQL INSERT script
  1: 'a174faa7-02b8-4d5d-8c98-9ba1cb6a0445', // Basics (Syntax, Variables, Data Types, I/O)
  2: '4ff8d615-3666-4311-82f9-ee1a0e92a2c9', // Control Flow (if/elif, loops, comprehensions)
  3: '01f3739c-27ea-4156-9010-b783291a1fa8', // Functions & Modules
  4: 'dc7ac71b-5111-4e79-a5a0-5f1d4a75985b', // Data Structures (Lists, Tuples, Dicts, Sets)
  5: 'b2ec6ebd-c44c-4f2c-b397-a65240c517b1', // OOP & Exceptions
  6: 'a370e0b9-1d9b-4842-a153-1e4703e4b6a1', // File Handling and Exceptions
  7: '62544299-ee99-4cc1-8c1b-c18b6b7ce52e', // Using Python Libraries (Math, Random, and NumPy)
  8: '3623e7c0-270e-45e8-949a-ba7c2a50f791', // Advanced Object-Oriented Programming (OOP)
  9: '2c5a4390-d024-4291-aa1f-074d1048e5c9', // Working with Data (JSON, CSV, and APIs)
  10: '88e2d775-9a23-4616-b76c-8a5a8925af82'  // GUI and Game Basics
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