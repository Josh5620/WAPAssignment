INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('12474ccd-6bee-49cb-972a-6a8e4c4170bb', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('3a42f50c-7e8e-4833-885c-179d289f7d6f', '12474ccd-6bee-49cb-972a-6a8e4c4170bb', N'Which of the following defines a block of code in Python?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9d537ec4-f175-4cc7-a529-878d73967e8e', '3a42f50c-7e8e-4833-885c-179d289f7d6f', N'Braces {}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e903a2e0-c5d0-4c8c-ad37-ac185b1e347c', '3a42f50c-7e8e-4833-885c-179d289f7d6f', N'Indentation', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('35c1d963-62a5-4128-9339-7279eaa463be', '3a42f50c-7e8e-4833-885c-179d289f7d6f', N'Semicolons', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ccd6035a-7bfa-461d-9e8c-56aeb7144376', '3a42f50c-7e8e-4833-885c-179d289f7d6f', N'Parentheses', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('23ef260b-df35-45c7-8aaf-6526b60a906f', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('71a0d3f9-3961-4282-b2a3-4bb201fb1bdd', '23ef260b-df35-45c7-8aaf-6526b60a906f', N'What is the default type of value returned by input()?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fece6126-eb3e-4144-a1e4-0be707aec1cd', '71a0d3f9-3961-4282-b2a3-4bb201fb1bdd', N'int', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('622e05ad-0ebb-4ffe-86d9-fde9bd379ed4', '71a0d3f9-3961-4282-b2a3-4bb201fb1bdd', N'float', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('df1eccf8-79bd-4e87-a75d-2772fa202fb0', '71a0d3f9-3961-4282-b2a3-4bb201fb1bdd', N'str', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('84469d21-ad41-4415-8fd2-a5f7f6ebd316', '71a0d3f9-3961-4282-b2a3-4bb201fb1bdd', N'bool', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('04955482-98fb-41ac-ac26-be4882b5f873', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('394ebb2b-8753-47d4-bdf3-0ff0b0cde95c', '04955482-98fb-41ac-ac26-be4882b5f873', N'Which of the following represents a NoneType object?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5edf4245-4760-484f-a3d9-3ffe5a90d626', '394ebb2b-8753-47d4-bdf3-0ff0b0cde95c', N'0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b67f5b5d-2f6a-45cb-88b5-1402d075beb8', '394ebb2b-8753-47d4-bdf3-0ff0b0cde95c', N'""', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('900fdbad-df22-4b71-8ac2-1176c2a376f8', '394ebb2b-8753-47d4-bdf3-0ff0b0cde95c', N'None', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('38c0cd6b-8e3c-40bf-9133-ddcd5b74bea0', '394ebb2b-8753-47d4-bdf3-0ff0b0cde95c', N'False', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('13af1474-cc93-426b-ab3b-33a0b1e44d4c', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('81583f36-c711-42c5-9848-d0b438c3a12e', '13af1474-cc93-426b-ab3b-33a0b1e44d4c', N'What will print("Hi", "Ali", sep="-") output?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a59ea88d-cc27-4cb9-9084-f982c938918e', '81583f36-c711-42c5-9848-d0b438c3a12e', N'Hi Ali', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f243ddd0-e1a3-49ad-bbf5-e34c4c9ae03d', '81583f36-c711-42c5-9848-d0b438c3a12e', N'HiAli', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('013ff7bb-04ab-42f6-8eec-e273e7fe8969', '81583f36-c711-42c5-9848-d0b438c3a12e', N'Hi-Ali', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4af88cdb-b9e1-42a4-b15a-12c9d17e2422', '81583f36-c711-42c5-9848-d0b438c3a12e', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0a4e6508-bc0c-4527-8025-d882fd4927b0', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('23de1206-f35c-4160-9aa3-440a4ed777d4', '0a4e6508-bc0c-4527-8025-d882fd4927b0', N'Which symbol is used for a single-line comment in Python?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a79115cc-c3cb-4e00-95cb-f11b41be1ac7', '23de1206-f35c-4160-9aa3-440a4ed777d4', N'//', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d8ca92b0-9215-48b2-9101-b87988669896', '23de1206-f35c-4160-9aa3-440a4ed777d4', N'<!-- -->', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5b3edf55-2725-4f8c-b13c-c034d6648599', '23de1206-f35c-4160-9aa3-440a4ed777d4', N'#', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('885fb39d-1edf-433d-abe5-1922fa56b9b4', '23de1206-f35c-4160-9aa3-440a4ed777d4', N'--', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('164846a7-a4ed-4f49-84ec-90bf1046966f', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('9bb85333-937b-41f9-99a0-cc32cedbd4fc', '164846a7-a4ed-4f49-84ec-90bf1046966f', N'What is the output of:  x = "Python"  print(x[2:5])', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fa9e2d89-607f-4dc0-9d21-9c95af0af06e', '9bb85333-937b-41f9-99a0-cc32cedbd4fc', N'Pyt', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5e4c3ed3-bb5d-4f5e-a719-317463b290a7', '9bb85333-937b-41f9-99a0-cc32cedbd4fc', N'tho', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3e54918c-07a0-4744-bdaf-b179ab3149a2', '9bb85333-937b-41f9-99a0-cc32cedbd4fc', N'yth', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dc55d91c-042b-410d-a54a-ccdd3b394639', '9bb85333-937b-41f9-99a0-cc32cedbd4fc', N'hon', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('8f801493-66e9-44de-bb52-233a5cd2371e', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('24d4aa3f-67b0-4230-a6b5-33ba9179f833', '8f801493-66e9-44de-bb52-233a5cd2371e', N'Which function converts "3.14" to a float?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ee93f82d-2d95-4792-ba17-efc82314c753', '24d4aa3f-67b0-4230-a6b5-33ba9179f833', N'str()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7008b08f-63fa-4a7c-bb62-14889d7de7e8', '24d4aa3f-67b0-4230-a6b5-33ba9179f833', N'int()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9d111ade-8704-432e-8f13-1f68689dfd59', '24d4aa3f-67b0-4230-a6b5-33ba9179f833', N'float()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a6c5c646-c269-44d2-8125-78e20e8c94da', '24d4aa3f-67b0-4230-a6b5-33ba9179f833', N'eval()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('a56f22ac-490d-40ac-9fe5-779cf04244c6', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e985d9ec-0fbc-4fdd-83e1-eb805fc88b35', 'a56f22ac-490d-40ac-9fe5-779cf04244c6', N'Which of the following is falsy in Python?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('47a1a00b-96c1-4b94-b24d-e3cc507f7045', 'e985d9ec-0fbc-4fdd-83e1-eb805fc88b35', N'[1,2,3]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c831a539-aa42-4a0a-88be-f5d7738ec09d', 'e985d9ec-0fbc-4fdd-83e1-eb805fc88b35', N'""', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('766289b8-80b2-45eb-b0b5-18f6a6e0b492', 'e985d9ec-0fbc-4fdd-83e1-eb805fc88b35', N'"False"', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('55864ba2-6632-4dd9-a535-d579344ee33a', 'e985d9ec-0fbc-4fdd-83e1-eb805fc88b35', N'10', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('8fba407a-0822-4254-865a-4967fa303c30', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('4f37fc65-377d-452e-bd6f-b0817e717b9f', '8fba407a-0822-4254-865a-4967fa303c30', N'What happens if you run:  int("3.0")', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5194dc07-9eb4-49a7-92d4-1902a84db5ac', '4f37fc65-377d-452e-bd6f-b0817e717b9f', N'Returns 3', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ece38af5-5270-40c0-b08a-052de4b7a045', '4f37fc65-377d-452e-bd6f-b0817e717b9f', N'Returns 3.0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4d93feff-ecba-43c3-aafb-bd06cf1bc13a', '4f37fc65-377d-452e-bd6f-b0817e717b9f', N'Error', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ca6176d8-9304-48e5-bc35-4b3ed98ca403', '4f37fc65-377d-452e-bd6f-b0817e717b9f', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0342787e-28ed-4cd1-b072-1ee6ca1d049e', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('f9396eb4-e6e0-4066-acbf-f3975bc64b58', '0342787e-28ed-4cd1-b072-1ee6ca1d049e', N'Which is a correct f-string usage?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9e40441d-9025-41db-a456-9d0d09af85ca', 'f9396eb4-e6e0-4066-acbf-f3975bc64b58', N'print("Age is {age}")', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6deee486-a1ab-498b-a0af-93d871d7569a', 'f9396eb4-e6e0-4066-acbf-f3975bc64b58', N'print(f"Age is {age}")', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('62c645b5-8a3a-4847-9371-13079fb2f215', 'f9396eb4-e6e0-4066-acbf-f3975bc64b58', N'print(f''Age is age'')', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f9e0acac-9d50-4ac4-b97a-d9645a16a604', 'f9396eb4-e6e0-4066-acbf-f3975bc64b58', N'print(f(Age is age))', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('95bac969-eda5-4bf7-be84-7194a2b42e90', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('973c6186-cf56-4c2f-9f7e-c8d23201ec19', '95bac969-eda5-4bf7-be84-7194a2b42e90', N'Which of the following shows dynamic typing?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d26b99d0-1389-4d2a-859c-0f9ef427db2a', '973c6186-cf56-4c2f-9f7e-c8d23201ec19', N'int x = 10', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('08a99f80-f097-4ae8-9d90-b7d5f9eea1b7', '973c6186-cf56-4c2f-9f7e-c8d23201ec19', N'x = 10; x = "hello"', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('460d8c7c-d422-49fb-8c0b-e95f1498aba7', '973c6186-cf56-4c2f-9f7e-c8d23201ec19', N'float y = 5.6', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f771d91c-78ee-425a-8908-f249b31d1e6d', '973c6186-cf56-4c2f-9f7e-c8d23201ec19', N'def func(): pass', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('e946604a-a3a1-4404-b942-9236e325adce', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('b560146b-f0cc-4058-9a59-09244e5faa4a', 'e946604a-a3a1-4404-b942-9236e325adce', N'What is the output?  print("A","B","C", end="*")', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('19b32864-c52e-43bf-a133-32002623bd77', 'b560146b-f0cc-4058-9a59-09244e5faa4a', N'A B C *', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2f459e05-7caa-4351-bfa4-febd8fb819da', 'b560146b-f0cc-4058-9a59-09244e5faa4a', N'A B C*', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('75a354bd-bfc6-4bde-9b7b-66a4adfaace8', 'b560146b-f0cc-4058-9a59-09244e5faa4a', N'ABC*', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('79887d74-a3f4-4ab3-86ec-33040a5bf177', 'b560146b-f0cc-4058-9a59-09244e5faa4a', N'A-B-C*', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('42795b89-f2b7-4dd9-bc82-5a2174e651bc', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('862cd92f-e4a2-4238-9b8e-ceabcdb000f8', '42795b89-f2b7-4dd9-bc82-5a2174e651bc', N'Which of the following does NOT create a new string "abc"?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6ac9f05d-e51e-4f5d-a363-98225addea97', '862cd92f-e4a2-4238-9b8e-ceabcdb000f8', N'"abc"[0:3]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cc89a814-3ab2-4eb5-8eee-6aa955f8de86', '862cd92f-e4a2-4238-9b8e-ceabcdb000f8', N'"a" + "b" + "c"', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0fdb81f9-5e81-4b40-98fd-becce481bf9e', '862cd92f-e4a2-4238-9b8e-ceabcdb000f8', N'"abc".strip()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bd016b25-bfb4-40c7-a837-345b6b6f3848', '862cd92f-e4a2-4238-9b8e-ceabcdb000f8', N'str("abc")', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('183142ae-c8d2-496a-a453-e698f2105699', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('0a4b79c3-d5ce-4397-a1dc-ec8147017b44', '183142ae-c8d2-496a-a453-e698f2105699', N'Which function shows the exact representation of an object (useful for debugging)?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bd61292c-cac9-4960-a964-d3af35979e94', '0a4b79c3-d5ce-4397-a1dc-ec8147017b44', N'str()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('72433c01-6482-4dc3-b2fd-0c3ab6419d96', '0a4b79c3-d5ce-4397-a1dc-ec8147017b44', N'repr()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('734df518-16e0-4e55-85a5-8444e6957125', '0a4b79c3-d5ce-4397-a1dc-ec8147017b44', N'print()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e5b78598-05be-4fc1-bfeb-b6717c4913df', '0a4b79c3-d5ce-4397-a1dc-ec8147017b44', N'debug()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('8e7468bb-7740-4001-9110-dcd4cf5eb3c8', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8f82ed94-74e2-4af3-a309-8a1edf3256f2', '8e7468bb-7740-4001-9110-dcd4cf5eb3c8', N'Which of these is NOT immutable?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9541f1ad-c582-4a84-83c3-053270bc3143', '8f82ed94-74e2-4af3-a309-8a1edf3256f2', N'str', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dfec8b4a-1579-44de-a7c5-14ae35ef789b', '8f82ed94-74e2-4af3-a309-8a1edf3256f2', N'int', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c3f4733b-e0c8-4c16-a892-32dc8ca460cc', '8f82ed94-74e2-4af3-a309-8a1edf3256f2', N'float', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4aafc9c0-b8f3-4316-96ae-f299443411e0', '8f82ed94-74e2-4af3-a309-8a1edf3256f2', N'list', 1);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('362c2851-1eb8-4733-b853-2e59e7bceeb8', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c74c532a-2882-46d1-833b-cefff4d76526', '362c2851-1eb8-4733-b853-2e59e7bceeb8', N'What will be the result?  print("python"[-2:])', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5aad6d3e-326e-4901-b825-648c57c8b0cf', 'c74c532a-2882-46d1-833b-cefff4d76526', N'py', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5d4305fb-3fa6-4e61-a51a-03e9cf52032d', 'c74c532a-2882-46d1-833b-cefff4d76526', N'on', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2a0e5752-2f78-4099-8f55-69e414b8aa84', 'c74c532a-2882-46d1-833b-cefff4d76526', N'th', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1361eb1b-e417-442b-9a4b-8da4fca029a3', 'c74c532a-2882-46d1-833b-cefff4d76526', N'no', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('13675da3-9e23-4ec7-a851-8c8e125f7dad', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8a5d2cf1-6e7c-4457-b3d1-0b3e7a5e8849', '13675da3-9e23-4ec7-a851-8c8e125f7dad', N'Which method removes whitespace from both ends of a string?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0547a931-33e2-451c-8247-3a25a9bcf495', '8a5d2cf1-6e7c-4457-b3d1-0b3e7a5e8849', N'cut()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5d4559bc-67da-4672-bfd5-9d4305f9b8a7', '8a5d2cf1-6e7c-4457-b3d1-0b3e7a5e8849', N'trim()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('abf63c96-b7ba-4556-b868-7ac21ae2d099', '8a5d2cf1-6e7c-4457-b3d1-0b3e7a5e8849', N'strip()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d1b726fa-f7e3-4b5e-bddf-4ff8a94e19c9', '8a5d2cf1-6e7c-4457-b3d1-0b3e7a5e8849', N'clean()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('6051940f-c469-464d-affb-71fb67966661', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('95076a24-bada-46fa-a128-92d3a8400bb6', '6051940f-c469-464d-affb-71fb67966661', N'What happens if you try to convert float("ten")?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8d5ea912-a4f6-44e1-873d-f3e6d941d0d0', '95076a24-bada-46fa-a128-92d3a8400bb6', N'10.0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6edeb1cf-252c-446f-baa5-53fb7e3c52f1', '95076a24-bada-46fa-a128-92d3a8400bb6', N'Error', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a279523a-80a7-45b6-a56a-97d0d0298b69', '95076a24-bada-46fa-a128-92d3a8400bb6', N'None', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('be2039d3-0510-4c20-80bd-6320fdf2940e', '95076a24-bada-46fa-a128-92d3a8400bb6', N'NaN', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('47f2a1c1-ecbd-4d94-871c-c810f4842b01', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('0673151d-8022-48cc-97e8-93e298cb93db', '47f2a1c1-ecbd-4d94-871c-c810f4842b01', N'Which of the following correctly swaps two variables a and b?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2cb164bc-3487-4cb1-b9c4-07038bb02d6c', '0673151d-8022-48cc-97e8-93e298cb93db', N'a = b; b = a', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('42eb2c57-0f3d-4451-8bad-71183831004b', '0673151d-8022-48cc-97e8-93e298cb93db', N'a, b = b, a', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('88539b37-467f-4327-9986-6276d9947a30', '0673151d-8022-48cc-97e8-93e298cb93db', N'swap(a,b)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cc5431db-4fc0-4c6d-9237-a461ffc1ef88', '0673151d-8022-48cc-97e8-93e298cb93db', N'temp = a; b = a; a = b', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('40ad7956-f094-4ddd-a9a5-9958c7f7a11a', 'bf330b48-f4a6-4e21-9888-0b6a6fe65a78', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8df908e7-f70d-4700-9041-11659c1cc6bc', '40ad7956-f094-4ddd-a9a5-9958c7f7a11a', N'Why is print("Hello", end="") useful?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9c9a2bf3-437c-4f83-b2c5-8e708494194a', '8df908e7-f70d-4700-9041-11659c1cc6bc', N'It skips spaces', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('efc964bd-ddca-4434-863c-d95dda08adb3', '8df908e7-f70d-4700-9041-11659c1cc6bc', N'It prevents newlines', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('76ce66d9-0eeb-48e4-a3e5-5bb02ec3f33c', '8df908e7-f70d-4700-9041-11659c1cc6bc', N'It adds commas', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('423b407c-8ff3-4dc0-a920-4d610d7b1610', '8df908e7-f70d-4700-9041-11659c1cc6bc', N'It repeats output', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0eb1855f-205d-4308-b4f0-db3763cb158a', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('afa75096-dc36-45f4-ba1e-092dda721b0e', '0eb1855f-205d-4308-b4f0-db3763cb158a', N'Which keyword ends a loop immediately?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d326b768-d900-41f3-9494-5e8de58b643c', 'afa75096-dc36-45f4-ba1e-092dda721b0e', N'stop', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d64b83e3-02e4-4702-ae15-f5d19eacf2e3', 'afa75096-dc36-45f4-ba1e-092dda721b0e', N'break', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8f446ca8-271e-41b0-8662-62cd52fa8a43', 'afa75096-dc36-45f4-ba1e-092dda721b0e', N'exit', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0a68e8dc-90cd-40d4-ad88-2f9bd53242dc', 'afa75096-dc36-45f4-ba1e-092dda721b0e', N'continue', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('ca0979b5-6c48-43ea-aade-dd2151a1861c', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('4c8e572e-2ee5-4ffb-870f-a663daf10777', 'ca0979b5-6c48-43ea-aade-dd2151a1861c', N'Which of these is falsy?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('caa705d8-2ce1-4c7d-8fbc-fa507502c8d8', '4c8e572e-2ee5-4ffb-870f-a663daf10777', N'" "', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('34d6a0ac-43b0-4c06-8abb-dd93ab1c8833', '4c8e572e-2ee5-4ffb-870f-a663daf10777', N'[]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1ccd6617-93e8-44e1-971b-96c7b87f135e', '4c8e572e-2ee5-4ffb-870f-a663daf10777', N'[0]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b13cbca2-929c-4e18-9df8-05e680cf906f', '4c8e572e-2ee5-4ffb-870f-a663daf10777', N'"False"', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('782ca434-0694-49a2-8cf5-7115cc1b96fa', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8726dd82-ff3c-44ba-8fd3-2ffda2c5fec1', '782ca434-0694-49a2-8cf5-7115cc1b96fa', N'What does pass do?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f872ac99-0ab1-412b-8dfd-fd9a988f9c45', '8726dd82-ff3c-44ba-8fd3-2ffda2c5fec1', N'Skips a loop iteration', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3ded50da-74eb-43cd-a0a1-0f8d6e268e36', '8726dd82-ff3c-44ba-8fd3-2ffda2c5fec1', N'Placeholder (does nothing)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('af502e9f-72f2-4048-a454-46bdf2b7ae44', '8726dd82-ff3c-44ba-8fd3-2ffda2c5fec1', N'Exits the program', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('acbe4d70-8c89-42f8-a523-ac74c971df84', '8726dd82-ff3c-44ba-8fd3-2ffda2c5fec1', N'Returns from a function', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('9b54fbef-eac5-4349-8fe8-43a65b469bd4', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e24ae58b-414a-4481-8d7c-5e39c0c87713', '9b54fbef-eac5-4349-8fe8-43a65b469bd4', N'Which loop is best for iterating through a list?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('884eb163-832b-40ae-8fdc-a249544c11fe', 'e24ae58b-414a-4481-8d7c-5e39c0c87713', N'while', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4474875b-0d2e-4277-927d-010f6c2a4caa', 'e24ae58b-414a-4481-8d7c-5e39c0c87713', N'repeat', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5b30d75c-28b5-44a6-9ee8-dcc981bc87df', 'e24ae58b-414a-4481-8d7c-5e39c0c87713', N'for', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d17675e7-234a-4ec2-8c1c-a25517b61bab', 'e24ae58b-414a-4481-8d7c-5e39c0c87713', N'goto', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('f7bd6981-d966-4657-a686-41f8ef811f7f', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c3388e34-42b6-4bd2-9538-cf1483403dfa', 'f7bd6981-d966-4657-a686-41f8ef811f7f', N'What is the output?  for i in range(2):      print("Hi")', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f9be58af-891b-4f14-9ece-9b0afdbe28ce', 'c3388e34-42b6-4bd2-9538-cf1483403dfa', N'Hi', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f1b527e4-4357-4c7a-9dde-d1c2b11f4950', 'c3388e34-42b6-4bd2-9538-cf1483403dfa', N'HiHi', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b58b3d49-6a88-4bfc-a349-7ec5c4868bb3', 'c3388e34-42b6-4bd2-9538-cf1483403dfa', N'Hi (printed twice)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('289b78d4-b6dc-4e54-99f2-a1fa27060ef3', 'c3388e34-42b6-4bd2-9538-cf1483403dfa', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('30edb2af-8464-4062-8a5f-3bfd1a1875fd', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('9e3ad7ae-f8fb-40b2-80ce-4d255bd7ac49', '30edb2af-8464-4062-8a5f-3bfd1a1875fd', N'What will this code output?  x = 0  while x < 3:      x += 1  print(x)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('db41d9ad-c088-4ca1-914c-8f1f8f2f3e51', '9e3ad7ae-f8fb-40b2-80ce-4d255bd7ac49', N'0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c998583d-a4a1-4724-bd49-2ac2ee6da1ee', '9e3ad7ae-f8fb-40b2-80ce-4d255bd7ac49', N'2', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0ff29a2d-4e61-4ede-889c-b6ad11f88d85', '9e3ad7ae-f8fb-40b2-80ce-4d255bd7ac49', N'3', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8064e341-a8b1-4b06-bf4b-df31dc762636', '9e3ad7ae-f8fb-40b2-80ce-4d255bd7ac49', N'4', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('e0286b20-1a16-47c1-887a-764aa14e2b5e', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('dac10f2f-4584-49de-8fba-23b6ef2ccb54', 'e0286b20-1a16-47c1-887a-764aa14e2b5e', N'Which statement skips the rest of a loop’s body but keeps looping?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('79ae6282-fc15-4d5c-8e14-9518560ea713', 'dac10f2f-4584-49de-8fba-23b6ef2ccb54', N'break', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('50015a36-f5e0-4aac-bc68-1808828ea8b7', 'dac10f2f-4584-49de-8fba-23b6ef2ccb54', N'continue', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('577b7f65-861b-4f74-835c-24e52b129b57', 'dac10f2f-4584-49de-8fba-23b6ef2ccb54', N'pass', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cf4be729-9651-4039-a82a-ba28da980f22', 'dac10f2f-4584-49de-8fba-23b6ef2ccb54', N'skip', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('6d98b45e-0806-4b1d-b6f0-5bbffa4e8ccb', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('a55e8d9d-5ac4-47fa-8932-6dc59d8ee857', '6d98b45e-0806-4b1d-b6f0-5bbffa4e8ccb', N'Which comprehension creates a list of even numbers up to 10?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4b31c7e4-ad86-4ae1-b3b6-ee7d6dfd21ed', 'a55e8d9d-5ac4-47fa-8932-6dc59d8ee857', N'[n for n in range(11) if n % 2 == 0]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('860aa445-6ec8-44de-820f-ade1e725984e', 'a55e8d9d-5ac4-47fa-8932-6dc59d8ee857', N'{n for n in range(11) if n % 2 == 0}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('467a3ef5-cef0-4258-beaf-d8e78c1156a4', 'a55e8d9d-5ac4-47fa-8932-6dc59d8ee857', N'(n for n in range(11) if n % 2 == 0)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ce951a6f-4d71-4b83-a837-cc723a4d181d', 'a55e8d9d-5ac4-47fa-8932-6dc59d8ee857', N'n for n in range(11) if n % 2 == 0', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('3c130fe8-a0e4-489f-ae75-94f487bcf0d1', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('5fecc8d8-ae06-4a56-95a4-04151ff116d6', '3c130fe8-a0e4-489f-ae75-94f487bcf0d1', N'Which of these is NOT valid?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b21fabc0-e0f0-43b3-b6cb-e8a1b6073fd0', '5fecc8d8-ae06-4a56-95a4-04151ff116d6', N'if condition: print("Hi")', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ed7f7b6d-1500-40ef-967d-f132597adbac', '5fecc8d8-ae06-4a56-95a4-04151ff116d6', N'for i in [1,2,3]: print(i)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('241527f8-9d40-4399-995d-205186296154', '5fecc8d8-ae06-4a56-95a4-04151ff116d6', N'while True print("Hi")', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('142ddeff-22cb-46aa-8244-98cd1b1699f9', '5fecc8d8-ae06-4a56-95a4-04151ff116d6', N'pass', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('589cc99d-d881-4b9b-ab97-d40c77849ca6', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('68045a56-f213-4c5b-9afd-774a3f644411', '589cc99d-d881-4b9b-ab97-d40c77849ca6', N'What is output of:  for i in range(3):      if i == 1:          continue      print(i)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a07a221c-941f-4bf4-bed1-9bc3b741add2', '68045a56-f213-4c5b-9afd-774a3f644411', N'0 1 2', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('323abbe1-1d77-4065-8950-fdce368ef2a1', '68045a56-f213-4c5b-9afd-774a3f644411', N'0 2', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('50791288-c5bd-4703-a9f7-71eec81563f1', '68045a56-f213-4c5b-9afd-774a3f644411', N'1 2', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1ee04ee3-14cf-43fc-b41a-2176ef7dd3c7', '68045a56-f213-4c5b-9afd-774a3f644411', N'2', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('1e542de6-f57d-42b9-952e-84dbcf741291', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('86e97ca8-1dd3-41c5-8bc2-aea56e2f293e', '1e542de6-f57d-42b9-952e-84dbcf741291', N'What will this code print?  for i in range(3):      for j in range(2):          print(i,j)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b0992a2e-ae1c-4409-b4c5-ce2500f7e11f', '86e97ca8-1dd3-41c5-8bc2-aea56e2f293e', N'3 pairs', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('93db7c48-9cb4-4ce2-bb2b-dd50a22bb128', '86e97ca8-1dd3-41c5-8bc2-aea56e2f293e', N'5 pairs', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a6254226-c6ad-441b-812c-64e91f55a74e', '86e97ca8-1dd3-41c5-8bc2-aea56e2f293e', N'6 pairs', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('48e90b96-4021-45f0-a8ff-2997c8852f5e', '86e97ca8-1dd3-41c5-8bc2-aea56e2f293e', N'9 pairs', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('7ddd86b7-4209-4b09-9f57-1128227fde74', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('42fcc5d0-b450-4fc4-b1b0-62b9fcff650a', '7ddd86b7-4209-4b09-9f57-1128227fde74', N'Which of these correctly builds a dict mapping numbers to their squares (1–5)?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a4ac788b-e5d4-45bf-b235-20e64a7794e7', '42fcc5d0-b450-4fc4-b1b0-62b9fcff650a', N'{n:n**2 for n in range(1,6)}', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('614cf7c2-99dd-4000-a9f5-ffd32b3bb1a9', '42fcc5d0-b450-4fc4-b1b0-62b9fcff650a', N'[n:n**2 for n in range(1,6)]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('41d6be64-5aff-48b2-af16-9a1cf4e3f973', '42fcc5d0-b450-4fc4-b1b0-62b9fcff650a', N'{n,n**2 for n in range(1,6)}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ec2ea59a-9818-4e70-b034-160e1933ab4e', '42fcc5d0-b450-4fc4-b1b0-62b9fcff650a', N'(n:n**2 for n in range(1,6))', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('da5fb73d-d9b8-42f7-886f-a5fc5dd5e3c0', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('fcc4848d-1572-48a8-b425-6f33b5e55c86', 'da5fb73d-d9b8-42f7-886f-a5fc5dd5e3c0', N'What is output?  nums = [1,2,3,4]  print([n for n in nums if n>2])', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5f702e76-9eee-4854-8f34-7ae418db69fa', 'fcc4848d-1572-48a8-b425-6f33b5e55c86', N'[1,2]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5412cff0-816e-4115-a73c-66b0f1ec9d88', 'fcc4848d-1572-48a8-b425-6f33b5e55c86', N'[3,4]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ebbf772a-b26e-4dc2-a767-507eb97fe06b', 'fcc4848d-1572-48a8-b425-6f33b5e55c86', N'[2,3,4]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('915e93eb-be4a-4071-af7b-b7fd5cd8022c', 'fcc4848d-1572-48a8-b425-6f33b5e55c86', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('ff46bbf9-30e6-48a3-8c85-c34617e04b04', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('81fa6aeb-301c-464a-a7f4-0a653062b9e6', 'ff46bbf9-30e6-48a3-8c85-c34617e04b04', N'Which while loop will run forever?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7e8e0460-107b-44b0-a03c-6230ca1d7ff1', '81fa6aeb-301c-464a-a7f4-0a653062b9e6', N'while False:', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bae81a2f-d5e8-4ccf-8580-c1aa958cd8b5', '81fa6aeb-301c-464a-a7f4-0a653062b9e6', N'while 0:', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('98541948-fc30-4eb4-953a-296586f96085', '81fa6aeb-301c-464a-a7f4-0a653062b9e6', N'while "":', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c9bf74c1-55c2-48f0-b535-18204d1a0ba6', '81fa6aeb-301c-464a-a7f4-0a653062b9e6', N'while 1:', 1);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('d387af83-3e3a-4ff1-9811-b46905e84d79', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('76f4785a-d092-4c92-b639-b4d717be01d0', 'd387af83-3e3a-4ff1-9811-b46905e84d79', N'Which of these statements is TRUE about comprehensions?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5de58022-1f4b-4dbb-849c-ecd0c0a5e5a4', '76f4785a-d092-4c92-b639-b4d717be01d0', N'They are always faster.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('de301531-f3d6-441f-8a53-a3b1434d6a4c', '76f4785a-d092-4c92-b639-b4d717be01d0', N'They can replace any loop.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cf1df2e1-d645-4245-ba25-abf18ff99d1a', '76f4785a-d092-4c92-b639-b4d717be01d0', N'They create new collections concisely.', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('de38c0e8-5a8e-48d5-a03d-19df24c98c49', '76f4785a-d092-4c92-b639-b4d717be01d0', N'They cannot use conditions.', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('105e1a5f-f2d0-4053-81f9-9425bc8a04e9', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('a969fd87-a9e8-44f0-8fe7-7320c5f343af', '105e1a5f-f2d0-4053-81f9-9425bc8a04e9', N'What will this output?  for i in range(3):      pass  print(i)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c3fafb48-a94c-4d5f-acc0-e1b0cf823d5a', 'a969fd87-a9e8-44f0-8fe7-7320c5f343af', N'0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1e0fdef8-049b-4bb1-b7ac-391c21482360', 'a969fd87-a9e8-44f0-8fe7-7320c5f343af', N'2', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cd5d7329-6051-448e-af33-cd9331f8d4f0', 'a969fd87-a9e8-44f0-8fe7-7320c5f343af', N'3', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7ea04a77-6af3-47ea-abc8-9de26f91517a', 'a969fd87-a9e8-44f0-8fe7-7320c5f343af', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('be03f79f-693d-4b9b-b52d-5d38b7f265df', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('bd9f8b0a-f15d-41ca-92e6-7dbd5f910066', 'be03f79f-693d-4b9b-b52d-5d38b7f265df', N'Which keyword allows you to handle a “not found” case after loop completion?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('abe966ce-8a20-4332-8908-bbbb37097328', 'bd9f8b0a-f15d-41ca-92e6-7dbd5f910066', N'except', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7f3479c9-fcf6-4322-a62b-98048527ce31', 'bd9f8b0a-f15d-41ca-92e6-7dbd5f910066', N'else (with loop)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('07064ef6-c15c-46a3-9307-40a51edc84cf', 'bd9f8b0a-f15d-41ca-92e6-7dbd5f910066', N'finally', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b5e7278c-14cf-4d45-9e68-9a0f80fccdef', 'bd9f8b0a-f15d-41ca-92e6-7dbd5f910066', N'pass', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('8f3a59ca-6967-45a0-9398-bea3e4928e72', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('0c7caa99-36e3-4919-b5a7-3b4791ad9d60', '8f3a59ca-6967-45a0-9398-bea3e4928e72', N'What is output?  i=0  while i<3:      print(i)      i+=2', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a997e9cb-da9c-43af-a576-a566568fedfe', '0c7caa99-36e3-4919-b5a7-3b4791ad9d60', N'0 1 2', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5e30fd01-f09a-45fc-af2c-0ce7b9aa2512', '0c7caa99-36e3-4919-b5a7-3b4791ad9d60', N'0 2', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7dacedb0-6637-486b-8436-9c55bb61151e', '0c7caa99-36e3-4919-b5a7-3b4791ad9d60', N'0 2 4', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d0504fa6-fa0c-4de2-b16b-e7eaf9e53722', '0c7caa99-36e3-4919-b5a7-3b4791ad9d60', N'Infinite loop', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('fc6d89c2-2cb3-487c-be8e-f7b5e8651c5a', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c50a918a-82c5-4f69-b093-48fc73244b71', 'fc6d89c2-2cb3-487c-be8e-f7b5e8651c5a', N'Which comprehension flattens a 2D list [[1,2],[3,4]]?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('306d0dd5-e9b4-4a5f-85bb-d48a7d4204f5', 'c50a918a-82c5-4f69-b093-48fc73244b71', N'[x for row in lst for x in row]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0c04ca47-dc6e-4045-ad68-6a504ad79b92', 'c50a918a-82c5-4f69-b093-48fc73244b71', N'[row for x in lst for row in x]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f81bf172-47fa-4e60-8150-381ea94543b3', 'c50a918a-82c5-4f69-b093-48fc73244b71', N'{x for row in lst for x in row}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e2ee44f7-da30-41e3-9b50-01b208c589d4', 'c50a918a-82c5-4f69-b093-48fc73244b71', N'x for row in lst for x in row', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('aead5c99-2e75-4196-8a49-84bd538ce29e', 'b8b24cad-1860-4bb1-86da-7a66351a5c39', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('ea87ad2a-40f5-4d66-ad01-f21837d75bdd', 'aead5c99-2e75-4196-8a49-84bd538ce29e', N'Why should complex comprehensions sometimes be avoided?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2ebc7e74-f88d-470a-93f7-49f0aac44417', 'ea87ad2a-40f5-4d66-ad01-f21837d75bdd', N'They are slow', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b315c593-cb2c-450f-a024-75e830609b9b', 'ea87ad2a-40f5-4d66-ad01-f21837d75bdd', N'They are unreadable', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b56a2bce-e7e2-4174-989a-588d157c221a', 'ea87ad2a-40f5-4d66-ad01-f21837d75bdd', N'They don’t exist', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fc6c6f02-d9b6-4c76-acbd-bbaa68f06dda', 'ea87ad2a-40f5-4d66-ad01-f21837d75bdd', N'They cause errors', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('227cd58b-7172-437c-9990-cf2ba5f832e0', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('81e6db7a-07b9-4215-b3d8-bfda0a8d5784', '227cd58b-7172-437c-9990-cf2ba5f832e0', N'Which keyword defines a function?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2f04339b-4231-4527-9182-f8d5a1b6e717', '81e6db7a-07b9-4215-b3d8-bfda0a8d5784', N'func', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a0ed3f15-2a72-4c3b-a25c-69a7d4b2e085', '81e6db7a-07b9-4215-b3d8-bfda0a8d5784', N'def', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dba95334-afb5-4a1a-ac99-77c79476694d', '81e6db7a-07b9-4215-b3d8-bfda0a8d5784', N'function', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9dd312e9-5e22-4320-a11c-8476fd48ac8f', '81e6db7a-07b9-4215-b3d8-bfda0a8d5784', N'define', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('9d4091a6-e8ab-460d-b48c-42af75bcd98b', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('9effadec-6c55-4075-9151-bac345a9fff8', '9d4091a6-e8ab-460d-b48c-42af75bcd98b', N'What is the default return value of a function without return?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f9bab603-a1d8-4906-a62f-fed3c7a01aa3', '9effadec-6c55-4075-9151-bac345a9fff8', N'0', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('44099a21-38c2-43a3-b1f4-34777dbbc15a', '9effadec-6c55-4075-9151-bac345a9fff8', N'None', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6a17eb7b-9c1a-4966-93b5-edcb896e4d0c', '9effadec-6c55-4075-9151-bac345a9fff8', N'False', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c4f5a72d-76bd-4107-801b-7bd55e64b281', '9effadec-6c55-4075-9151-bac345a9fff8', N'“”', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('192055cc-5757-4c84-a46a-56ebe363cdc4', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8bb33fac-11de-4a00-a771-df3da7307fb6', '192055cc-5757-4c84-a46a-56ebe363cdc4', N'What will this output?  def f(x=5): return x  print(f())', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4b65a3dc-e475-4634-ac4f-76e8b4506b37', '8bb33fac-11de-4a00-a771-df3da7307fb6', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bd695874-5e5a-4d5f-b915-2a0e8e3607fe', '8bb33fac-11de-4a00-a771-df3da7307fb6', N'None', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a602e16b-4c47-4e08-98b2-03cc5785f23a', '8bb33fac-11de-4a00-a771-df3da7307fb6', N'5', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9394a68e-fd5d-4db1-a2ab-0ad1a630f9ca', '8bb33fac-11de-4a00-a771-df3da7307fb6', N'"5"', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('3ce471fe-4a6c-4d6a-ac29-8e0e3e73048c', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('49386093-315a-48d6-9191-d1c9446addc4', '3ce471fe-4a6c-4d6a-ac29-8e0e3e73048c', N'Which collects extra positional arguments?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('92c27f18-6ff4-4600-af3b-3330ad880a67', '49386093-315a-48d6-9191-d1c9446addc4', N'args', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ded58f43-9814-4929-a1d6-0f684e143aaa', '49386093-315a-48d6-9191-d1c9446addc4', N'*args', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a7aa8113-bdf1-4951-829d-7a7f34becb9d', '49386093-315a-48d6-9191-d1c9446addc4', N'**kwargs', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a5af8626-078a-41e5-b0de-a19dc9d20ffc', '49386093-315a-48d6-9191-d1c9446addc4', N'list()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('7a727d9a-357b-48c7-bb74-d369e28295e2', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('5fc8afd3-814c-4e8a-8cd2-afb76915056e', '7a727d9a-357b-48c7-bb74-d369e28295e2', N'Which library is built-in?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fb84cb83-6079-4252-928c-6bc460b3773e', '5fc8afd3-814c-4e8a-8cd2-afb76915056e', N'numpy', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bd8cb3e8-60bb-493e-8999-ab773c453bbf', '5fc8afd3-814c-4e8a-8cd2-afb76915056e', N'requests', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('382dfb55-9229-47ee-a116-6ab0f5e80f64', '5fc8afd3-814c-4e8a-8cd2-afb76915056e', N'math', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e147f94c-48cd-4210-a367-255a5dd20672', '5fc8afd3-814c-4e8a-8cd2-afb76915056e', N'pandas', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('02303008-3190-43ad-bd4e-2b9ad0402b79', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('b0242486-007f-4342-9f1e-7bddd9778052', '02303008-3190-43ad-bd4e-2b9ad0402b79', N'What is output?  def swap(a,b): return b,a  x,y = swap(3,4)  print(x,y)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('34d658b9-bcf1-4aa2-b72a-5e5d9eec0ab5', 'b0242486-007f-4342-9f1e-7bddd9778052', N'3 4', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('960b2355-15e3-4d9a-ab03-53d68449987d', 'b0242486-007f-4342-9f1e-7bddd9778052', N'4 3', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('955839ef-3042-4a6e-bad5-0559b7107685', 'b0242486-007f-4342-9f1e-7bddd9778052', N'(4,3)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f31c2729-eaa4-4903-803c-c639030ff09f', 'b0242486-007f-4342-9f1e-7bddd9778052', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('dbac6e36-aac4-4237-a836-5dc3ae45760d', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('284aa054-9ff1-4c35-a7ad-f992e9cdb263', 'dbac6e36-aac4-4237-a836-5dc3ae45760d', N'Which statement about global is TRUE?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('78d274fa-1530-4336-a3b2-73a05f0c6009', '284aa054-9ff1-4c35-a7ad-f992e9cdb263', N'It creates a new variable.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ded0524e-d140-4277-913a-0c1b052c9b5d', '284aa054-9ff1-4c35-a7ad-f992e9cdb263', N'It modifies a variable outside the function.', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c674c9ca-5360-4197-8406-48d35199a156', '284aa054-9ff1-4c35-a7ad-f992e9cdb263', N'It deletes a variable.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5dfe318e-556e-44a5-b027-78d16b76005c', '284aa054-9ff1-4c35-a7ad-f992e9cdb263', N'It copies a variable.', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('90af1f22-7302-41fd-bfab-7b66109d08fa', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('d76dbce2-ffb0-4fad-80e9-c8392ef25bb1', '90af1f22-7302-41fd-bfab-7b66109d08fa', N'Which docstring format is correct?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('004bf684-bb09-4bba-b187-a5ebf877fc71', 'd76dbce2-ffb0-4fad-80e9-c8392ef25bb1', N'“comment”', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4be8e86b-931e-450d-914d-0326f37b7e95', 'd76dbce2-ffb0-4fad-80e9-c8392ef25bb1', N'# docstring', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3235ebcc-6db0-43f9-ba6c-c52c06c37853', 'd76dbce2-ffb0-4fad-80e9-c8392ef25bb1', N'“""This is a docstring."""', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('34f7354e-c1b8-49fa-8605-db488d7b3d9b', 'd76dbce2-ffb0-4fad-80e9-c8392ef25bb1', N'/* docstring */', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('1f7c16e4-faf7-4f32-b267-a9a0438f511e', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('fc66a934-54e5-465c-a531-c4219c4c9fe1', '1f7c16e4-faf7-4f32-b267-a9a0438f511e', N'Which of these imports sqrt only?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9d9ed392-1891-4701-a3b5-d1b28d847a3f', 'fc66a934-54e5-465c-a531-c4219c4c9fe1', N'import math.sqrt', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c03f2df9-90f9-466c-abee-8248d4a1cbee', 'fc66a934-54e5-465c-a531-c4219c4c9fe1', N'from math import sqrt', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('667f6361-635d-48c5-bc9d-a6129957566f', 'fc66a934-54e5-465c-a531-c4219c4c9fe1', N'import sqrt from math', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bbbef75c-b8a2-4052-95cc-65423da68ba4', 'fc66a934-54e5-465c-a531-c4219c4c9fe1', N'math sqrt()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('25c374f2-0f2f-4f94-a389-8be492bcb597', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e3880967-1371-4361-859c-c0ed24003fef', '25c374f2-0f2f-4f94-a389-8be492bcb597', N'Which command installs a package?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2a2458f5-3360-416a-8482-bdbbc9bcd68b', 'e3880967-1371-4361-859c-c0ed24003fef', N'install pkg', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e69e46e5-6404-4a9c-a1f5-1b4cb91ce11e', 'e3880967-1371-4361-859c-c0ed24003fef', N'pip install pkg', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cb7a6d9e-0de0-43b0-81f6-98e5e29dece7', 'e3880967-1371-4361-859c-c0ed24003fef', N'py install pkg', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0896ee1b-c499-4338-a27f-b0b6b5e2cb1b', 'e3880967-1371-4361-859c-c0ed24003fef', N'python get pkg', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('e42e3026-974b-4934-8fc6-d517d4493e6e', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('bb66db11-03f3-41db-b4ea-826332d0d9b2', 'e42e3026-974b-4934-8fc6-d517d4493e6e', N'Which of these returns multiple values?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2fb2737e-09da-4cbd-a2a7-62e78204289f', 'bb66db11-03f3-41db-b4ea-826332d0d9b2', N'return 1,2', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8d831291-03c0-471d-be21-1855c6584c9f', 'bb66db11-03f3-41db-b4ea-826332d0d9b2', N'return [1,2]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bc702a7b-8be7-447e-88a1-9792c858fddb', 'bb66db11-03f3-41db-b4ea-826332d0d9b2', N'return (1,2)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5e57774f-9737-4164-895f-e5a154b97ef5', 'bb66db11-03f3-41db-b4ea-826332d0d9b2', N'All of the above', 1);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('f08c231d-cb48-4f34-b6a6-4eedc8ebdb35', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c413d4b7-126e-4585-9073-c5f5b166ade1', 'f08c231d-cb48-4f34-b6a6-4eedc8ebdb35', N'Which is a higher-order function?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2375c04d-9a92-49bb-8c0f-a920c4a0db46', 'c413d4b7-126e-4585-9073-c5f5b166ade1', N'Function returning another function.', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('248c86f6-b915-4cdb-a990-79689b29e04b', 'c413d4b7-126e-4585-9073-c5f5b166ade1', N'Function without return.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('915988dc-cc85-44b7-ac86-a354ddced664', 'c413d4b7-126e-4585-9073-c5f5b166ade1', N'Function with default parameter.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f509b3ea-1477-4ef9-9ac8-3046820ae231', 'c413d4b7-126e-4585-9073-c5f5b166ade1', N'Function with print only.', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('35713f6b-c83c-4d75-a0d5-e039c47f1ccb', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('988089a8-c072-462d-af9f-736a291c0d50', '35713f6b-c83c-4d75-a0d5-e039c47f1ccb', N'Which keyword argument call is valid?  def add(x,y): return x+y', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('01cde526-b811-44ca-8700-fc90b41e5de2', '988089a8-c072-462d-af9f-736a291c0d50', N'add(3,2)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2d90cf36-6417-40da-8e3d-af622c580981', '988089a8-c072-462d-af9f-736a291c0d50', N'add(y=2,x=3)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a6abb231-0954-4058-9e62-cc2e3091c1f7', '988089a8-c072-462d-af9f-736a291c0d50', N'add(3,y=2)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4cd5c185-0537-4dcf-aeca-445b7ea0b4c0', '988089a8-c072-462d-af9f-736a291c0d50', N'All of these', 1);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('fcb850bd-35a2-410b-a235-38f6badaa6b1', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('7cf497b1-9196-4d4b-a1b6-2ae15016c019', 'fcb850bd-35a2-410b-a235-38f6badaa6b1', N'Which is dangerous as a default parameter?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8bc41991-929d-4c88-bb99-3935e3bc0943', '7cf497b1-9196-4d4b-a1b6-2ae15016c019', N'int', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('62b30368-2540-42de-b308-06247093c60a', '7cf497b1-9196-4d4b-a1b6-2ae15016c019', N'None', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a6be2766-7951-41e4-ad18-ca42e17949c3', '7cf497b1-9196-4d4b-a1b6-2ae15016c019', N'[]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0f2708d9-77ee-4850-9ab3-bd26ccf09998', '7cf497b1-9196-4d4b-a1b6-2ae15016c019', N'0', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('fb9152fc-bb2f-444a-bf64-8b1be5300d4e', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('bac3460f-03c0-46e4-b9de-c9ac1ceaef99', 'fb9152fc-bb2f-444a-bf64-8b1be5300d4e', N'Which of these is a module alias import?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7a95d7d1-4d6e-4939-a6f6-68a8febf2e4f', 'bac3460f-03c0-46e4-b9de-c9ac1ceaef99', N'import math as m', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('873a5bbf-923d-47f2-8910-c4495f9766c9', 'bac3460f-03c0-46e4-b9de-c9ac1ceaef99', N'import m = math', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9556088c-2aad-4fdc-a26f-3480cfbd04a6', 'bac3460f-03c0-46e4-b9de-c9ac1ceaef99', N'math = import m', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f5c52eeb-c402-4914-b67e-e6b1bd77517d', 'bac3460f-03c0-46e4-b9de-c9ac1ceaef99', N'alias math as m', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('07b543b7-58de-4ffa-a390-06fe7d4a2283', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e0eca752-fa5f-4f0a-a96c-4a480b6baef8', '07b543b7-58de-4ffa-a390-06fe7d4a2283', N'What happens if you call help(function_name)?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('94d254af-e71d-414a-8786-a05f3e027a27', 'e0eca752-fa5f-4f0a-a96c-4a480b6baef8', N'Runs the function.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('21cd0c6a-dd9c-49a0-a5da-274fa774467c', 'e0eca752-fa5f-4f0a-a96c-4a480b6baef8', N'Prints docstring.', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('62c01131-fb7f-4347-ab67-5dadc3f7b7a3', 'e0eca752-fa5f-4f0a-a96c-4a480b6baef8', N'Deletes function.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('19ddd51a-0cca-43f4-afbd-4a72a415848a', 'e0eca752-fa5f-4f0a-a96c-4a480b6baef8', N'Nothing.', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0c6c3944-d7fb-4d84-b33a-88666b8e095b', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('616dede0-dd75-4633-a891-ec261331b387', '0c6c3944-d7fb-4d84-b33a-88666b8e095b', N'Which command creates a virtual environment (modern)?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1447000a-2894-45d2-a7bf-9f4967553c8f', '616dede0-dd75-4633-a891-ec261331b387', N'python -m venv env', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3bc59331-f6d4-448f-b6c1-d53f6a612aa0', '616dede0-dd75-4633-a891-ec261331b387', N'pip create env', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('063dc6c3-c1ad-4f86-a961-a2a417e3e416', '616dede0-dd75-4633-a891-ec261331b387', N'venv install env', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3fe46318-39f5-46cb-a7d8-cebdcc9a73fd', '616dede0-dd75-4633-a891-ec261331b387', N'py env create', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('4b53d268-c33d-4bc6-aa55-729b4828df46', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('efd1a80c-f1e3-4500-a583-26399564a67a', '4b53d268-c33d-4bc6-aa55-729b4828df46', N'Which scope does Python check first?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('83266aa5-ac23-4a5a-aebe-91faec576b80', 'efd1a80c-f1e3-4500-a583-26399564a67a', N'Global', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('86e6a884-ef0e-4339-ac66-5602f4d4cffa', 'efd1a80c-f1e3-4500-a583-26399564a67a', N'Built-in', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8227342f-ca6d-48d8-9322-ced9f64a7e6a', 'efd1a80c-f1e3-4500-a583-26399564a67a', N'Local', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d87fbad5-2559-46f8-8aa5-7018b5f5f552', 'efd1a80c-f1e3-4500-a583-26399564a67a', N'Module', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('5f9ea38f-29c1-4866-bc13-7d14617f3ce0', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('91d0fb4d-573c-4c63-b9aa-c81505050f8e', '5f9ea38f-29c1-4866-bc13-7d14617f3ce0', N'Which rule defines variable resolution order?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c20cb52b-a89e-47c7-923f-6efee5e44691', '91d0fb4d-573c-4c63-b9aa-c81505050f8e', N'FIFO', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('454f3bae-7e4c-4a84-8dbc-6d8076202d03', '91d0fb4d-573c-4c63-b9aa-c81505050f8e', N'LIFO', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c7e33440-7092-48d9-ad68-57383f134353', '91d0fb4d-573c-4c63-b9aa-c81505050f8e', N'LEGB (Local, Enclosing, Global, Built-in)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1e138548-46fb-469a-bdfb-f044ac1be6bd', '91d0fb4d-573c-4c63-b9aa-c81505050f8e', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('007a4742-e373-415f-a291-510dc5523c63', 'cc2ac419-857d-4c03-b06a-ae5cb95df5f0', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('623fc798-00c2-4c45-832c-fa09476013f4', '007a4742-e373-415f-a291-510dc5523c63', N'Why use modules?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('79e4cc44-5296-4adc-81ce-247f0c832b6d', '623fc798-00c2-4c45-832c-fa09476013f4', N'Avoids reusing code', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c66dc183-5c42-4536-9de6-773c23ffb4ab', '623fc798-00c2-4c45-832c-fa09476013f4', N'Organises and reuses functions', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4e0b9161-9cb4-4576-9462-01b468aacd9d', '623fc798-00c2-4c45-832c-fa09476013f4', N'Slows execution', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5fe28bc2-9d45-4d63-93f9-e99d94d43042', '623fc798-00c2-4c45-832c-fa09476013f4', N'Creates errors', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('13153e9e-efee-4a4e-8a8d-0036117da9dc', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('810fabc5-70b7-49ba-9f2b-6f6b8df5eee3', '13153e9e-efee-4a4e-8a8d-0036117da9dc', N'Which of these is mutable?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c7e295f0-bcb7-41e7-b985-d2d1dd8b9cc6', '810fabc5-70b7-49ba-9f2b-6f6b8df5eee3', N'tuple', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9699f7ab-cd04-4da5-8a1c-2f2771990eff', '810fabc5-70b7-49ba-9f2b-6f6b8df5eee3', N'str', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('45426233-33ed-492a-bad2-be4bc1fa5af9', '810fabc5-70b7-49ba-9f2b-6f6b8df5eee3', N'list', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('814b16a4-cf73-4abf-b03c-ac461a78ce0f', '810fabc5-70b7-49ba-9f2b-6f6b8df5eee3', N'int', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('394a3017-1fd1-4813-a667-e63d2d19e4e8', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('96c03632-c93e-425b-b30d-cd66c35b1eb2', '394a3017-1fd1-4813-a667-e63d2d19e4e8', N'How do you access the 2nd element in nums=[10,20,30]?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ca5c71b4-23eb-44e2-b3c9-56ced4c52ca8', '96c03632-c93e-425b-b30d-cd66c35b1eb2', N'nums(2)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('aac7b42c-b85a-4e2e-8603-274f67725d36', '96c03632-c93e-425b-b30d-cd66c35b1eb2', N'nums{1}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('573e983a-365e-4ac7-b593-79c745e5235c', '96c03632-c93e-425b-b30d-cd66c35b1eb2', N'nums[1]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c8aa8ded-cb88-4f1c-911d-a920c7959183', '96c03632-c93e-425b-b30d-cd66c35b1eb2', N'nums[2]', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('641ad649-e24d-4602-8e32-8fdd79191e77', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('bfec6b7d-0444-40f0-8669-f0b9a55a9da7', '641ad649-e24d-4602-8e32-8fdd79191e77', N'Which removes duplicates from a list?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a7d70ff4-9d86-48bf-8343-79936c21f93b', 'bfec6b7d-0444-40f0-8669-f0b9a55a9da7', N'tuple(list)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dd1f2ffe-39e3-4515-b572-5e769b600f47', 'bfec6b7d-0444-40f0-8669-f0b9a55a9da7', N'set(list)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('de72dfea-2352-4d6d-8cdc-699667ff1b1f', 'bfec6b7d-0444-40f0-8669-f0b9a55a9da7', N'dict(list)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('de888bf3-4ee2-4eb7-864a-c4304358043d', 'bfec6b7d-0444-40f0-8669-f0b9a55a9da7', N'list.remove()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('3cf53687-bd0e-4fb4-b8dc-330ae6fe81a9', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('35141a0f-2bca-48b1-aaef-52a3db2865cc', '3cf53687-bd0e-4fb4-b8dc-330ae6fe81a9', N'Which method removes and returns last element of list?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ba199efe-a9df-4592-828c-7e41118a3ea5', '35141a0f-2bca-48b1-aaef-52a3db2865cc', N'pop()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5aeea400-e22e-446e-b32d-8f5f0dd50658', '35141a0f-2bca-48b1-aaef-52a3db2865cc', N'remove()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fbd43748-95a0-4443-9102-a4636d93cfae', '35141a0f-2bca-48b1-aaef-52a3db2865cc', N'del()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('94fb63f5-24ab-46cf-a2a0-491472e11395', '35141a0f-2bca-48b1-aaef-52a3db2865cc', N'cut()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('9d82b6e2-4a60-4ad0-ad48-89e7963c893f', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('4c12b271-4f37-44c1-87f1-39e4904c75ec', '9d82b6e2-4a60-4ad0-ad48-89e7963c893f', N'What’s the output?  ages={"Ali":20}  print(ages.get("Bala",0))', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3d3e8c6b-5f80-4fea-a87a-6814fe3db561', '4c12b271-4f37-44c1-87f1-39e4904c75ec', N'None', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b8dd7c47-a6e0-4fb7-b35d-cc9792e3bf27', '4c12b271-4f37-44c1-87f1-39e4904c75ec', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6676da0f-a7fe-431b-92e8-99482e6a04c6', '4c12b271-4f37-44c1-87f1-39e4904c75ec', N'0', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5cd3b560-b1b3-4ccc-8cf2-4b2247b8ea23', '4c12b271-4f37-44c1-87f1-39e4904c75ec', N'20', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('5b3af731-2311-49b7-927c-0c2d86128234', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('53499d72-5d4c-4222-ba11-48672896d0b4', '5b3af731-2311-49b7-927c-0c2d86128234', N'Which of these is valid tuple?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9a1c6502-af49-4d8e-bcd6-b283463a026f', '53499d72-5d4c-4222-ba11-48672896d0b4', N'(1)', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3893f8fb-07b2-4d08-86ab-41a5ff84b88e', '53499d72-5d4c-4222-ba11-48672896d0b4', N'(1,)', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e12062b3-ce25-49c5-adc1-d05633ef6706', '53499d72-5d4c-4222-ba11-48672896d0b4', N'[1,]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3c35f69f-3d54-40ff-a6a0-9c15abc1d359', '53499d72-5d4c-4222-ba11-48672896d0b4', N'{1}', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('3707628c-53fc-4cdd-83df-82f770b06194', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('9d8e5db5-77cd-4dfb-ba7f-692beaa71aab', '3707628c-53fc-4cdd-83df-82f770b06194', N'Which method sorts list in-place?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a86eed5e-3d42-46f7-bdc0-25cc57d0a2a9', '9d8e5db5-77cd-4dfb-ba7f-692beaa71aab', N'sorted()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('44cfb8ea-3fea-4cf3-9d98-249f81f4f97e', '9d8e5db5-77cd-4dfb-ba7f-692beaa71aab', N'list.sort()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('012d3f08-7288-4b4d-a157-839231c07dcb', '9d8e5db5-77cd-4dfb-ba7f-692beaa71aab', N'arrange()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6dbb7e52-1cb0-4923-bd40-df295e0753b7', '9d8e5db5-77cd-4dfb-ba7f-692beaa71aab', N'order()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('91b62a9f-ba00-4ab7-8f6a-bad2c56f004a', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e0f155f3-b7fb-4e8d-87ef-c7ea8fbc71a7', '91b62a9f-ba00-4ab7-8f6a-bad2c56f004a', N'Which operation finds common elements of sets A and B?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3143a1f6-f4fb-48f8-b253-2590659b9249', 'e0f155f3-b7fb-4e8d-87ef-c7ea8fbc71a7', N'A+B', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2829e3e6-5a4c-454b-85a6-adf54f0efbfe', 'e0f155f3-b7fb-4e8d-87ef-c7ea8fbc71a7', N'A-B', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5be3f6bb-54a5-4416-b2a0-de565bd5be35', 'e0f155f3-b7fb-4e8d-87ef-c7ea8fbc71a7', N'A&B', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e6df8486-aa3d-467d-b1ae-417c12d7d682', 'e0f155f3-b7fb-4e8d-87ef-c7ea8fbc71a7', N'A|B', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('cadec10b-809a-4069-b74e-fd30c8276332', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('8bc713df-bbb7-48cb-a345-d9312d4a66eb', 'cadec10b-809a-4069-b74e-fd30c8276332', N'Which is a valid dict?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('eae55e30-4770-4f05-a132-b10d6c93b630', '8bc713df-bbb7-48cb-a345-d9312d4a66eb', N'{1,2,3}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c5f056c2-a0c8-42ce-aef5-06a9d8ba2e50', '8bc713df-bbb7-48cb-a345-d9312d4a66eb', N'{"a":1, "b":2}', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7248e290-9ebe-419c-98cb-e104e9f9fdd3', '8bc713df-bbb7-48cb-a345-d9312d4a66eb', N'[("a",1)]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b502050e-5357-46ba-acd6-e41bf27c61bd', '8bc713df-bbb7-48cb-a345-d9312d4a66eb', N'("a":1)', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('fef59b77-0ee1-432e-a273-c053c2088fb2', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('dc976938-7ed4-4a6e-a358-64d2c54d0159', 'fef59b77-0ee1-432e-a273-c053c2088fb2', N'What is output?  d = {"x":1}  d["y"] = 2  print(d)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('553fb574-95fc-4a4c-b712-0a2d04bac397', 'dc976938-7ed4-4a6e-a358-64d2c54d0159', N'{"x":1}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2c129e4f-b604-4023-80db-6a990e2deeba', 'dc976938-7ed4-4a6e-a358-64d2c54d0159', N'{"x":1,"y":2}', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('75467381-5821-4327-aaa0-24a3177437f1', 'dc976938-7ed4-4a6e-a358-64d2c54d0159', N'[1,2]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('fc5e9f87-56c3-4299-9824-1bcd48044ff4', 'dc976938-7ed4-4a6e-a358-64d2c54d0159', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('7a8380e2-4d46-4eb5-b67e-3481925af8b2', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('d6d54bee-79f9-4346-a34c-8150cc989eda', '7a8380e2-4d46-4eb5-b67e-3481925af8b2', N'Which of these can be dict keys?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dc4a349b-80e8-4d46-9012-1dcc74f7d359', 'd6d54bee-79f9-4346-a34c-8150cc989eda', N'list', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c58815d1-ae94-453a-b435-29d83bf8b362', 'd6d54bee-79f9-4346-a34c-8150cc989eda', N'set', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('61d2256d-432d-45db-850b-ff5d2b422659', 'd6d54bee-79f9-4346-a34c-8150cc989eda', N'tuple', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('187f2d01-06a6-44bb-aad5-ccf6a5de5278', 'd6d54bee-79f9-4346-a34c-8150cc989eda', N'dict', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('ae3d3604-4bf7-435c-9c63-082cf6d9638f', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('239a5fb9-8fe7-4f90-9cea-499dd85c85ab', 'ae3d3604-4bf7-435c-9c63-082cf6d9638f', N'What will this print?  a=[1,2]; b=a  b.append(3)  print(a)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('700cb030-a5d5-4bd4-b514-20b0f832b68d', '239a5fb9-8fe7-4f90-9cea-499dd85c85ab', N'[1,2]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('186e0fb2-a5ca-417e-8994-525f61ba5263', '239a5fb9-8fe7-4f90-9cea-499dd85c85ab', N'[1,2,3]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5a6d2850-8b46-46e5-bb5e-e347b03e414b', '239a5fb9-8fe7-4f90-9cea-499dd85c85ab', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9045fb69-6aa1-4f4a-8dbe-53d2215db843', '239a5fb9-8fe7-4f90-9cea-499dd85c85ab', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('76e49741-d102-495f-9feb-9e7694cbd5ba', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('12b9a656-c5bf-4b25-9a36-2277fb8e468c', '76e49741-d102-495f-9feb-9e7694cbd5ba', N'Which method returns list length?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('52ff0101-7ab2-435c-b662-5f6f39cbe45b', '12b9a656-c5bf-4b25-9a36-2277fb8e468c', N'length()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4e817e06-f4d2-4a80-be5e-f3505ca8775f', '12b9a656-c5bf-4b25-9a36-2277fb8e468c', N'len()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dabd0bf5-33ae-4c90-b8d1-e4f2457737b4', '12b9a656-c5bf-4b25-9a36-2277fb8e468c', N'count()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d97c3f51-615c-4a2b-ad27-202baa1f8e06', '12b9a656-c5bf-4b25-9a36-2277fb8e468c', N'size()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('5d8c7e2b-cc0d-4992-ba8a-9c204a4506ee', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('b7319cd1-0870-4b37-bcd2-b330fe363b9a', '5d8c7e2b-cc0d-4992-ba8a-9c204a4506ee', N'Which dict comprehension inverts a dict {1:"a",2:"b"}?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bd6e14b5-00fd-4347-b925-e56b62fcc6dd', 'b7319cd1-0870-4b37-bcd2-b330fe363b9a', N'{v:k for k,v in d.items()}', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0a982661-32b8-4c1d-9e49-39b8def835fc', 'b7319cd1-0870-4b37-bcd2-b330fe363b9a', N'{k:v for k,v in d.items()}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8d400f38-a3e4-449c-819c-0ccb0a618d4f', 'b7319cd1-0870-4b37-bcd2-b330fe363b9a', N'[v:k for k,v in d.items()]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('38e09c8b-c946-468b-9914-6066da49a0a7', 'b7319cd1-0870-4b37-bcd2-b330fe363b9a', N'(v:k for k,v in d.items())', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('fa32c5f5-2376-4b25-abdc-c93046095903', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e93566e3-a91f-4c48-8f73-4efc4164c561', 'fa32c5f5-2376-4b25-abdc-c93046095903', N'Which set operation removes elements in B from A?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('183b72ae-c356-4b61-93d7-3bc0035ca140', 'e93566e3-a91f-4c48-8f73-4efc4164c561', N'A|B', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d746976b-e81c-41bc-b949-8f20e6a428f7', 'e93566e3-a91f-4c48-8f73-4efc4164c561', N'A-B', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('36e617df-a4b4-4d62-975c-ffb33f6d8aee', 'e93566e3-a91f-4c48-8f73-4efc4164c561', N'A&B', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0ddfa47b-1f42-492b-a6b8-115834222ca7', 'e93566e3-a91f-4c48-8f73-4efc4164c561', N'A^B', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('b1fc6aa1-6136-4feb-be9f-15e8101141f9', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c55edb6b-1ae0-4690-b6ef-f40c8f8eeffc', 'b1fc6aa1-6136-4feb-be9f-15e8101141f9', N'What is output?  s = {1,2,2,3}  print(s)', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('241c057a-421d-43a9-84ce-934e2ed45d20', 'c55edb6b-1ae0-4690-b6ef-f40c8f8eeffc', N'{1,2,2,3}', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('94ae79aa-163b-40c2-bf7c-e63511dcfd0b', 'c55edb6b-1ae0-4690-b6ef-f40c8f8eeffc', N'{1,2,3}', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a15c60ea-c709-460f-8d58-07cfc4a1f984', 'c55edb6b-1ae0-4690-b6ef-f40c8f8eeffc', N'[1,2,3]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('02d5c5a1-fbe0-474a-a883-600999435ef1', 'c55edb6b-1ae0-4690-b6ef-f40c8f8eeffc', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('b278c66a-c4ec-4d4b-a1cc-2dd4e05cebef', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('4e183786-91f4-4c65-b423-8d13a04a9d63', 'b278c66a-c4ec-4d4b-a1cc-2dd4e05cebef', N'Which slice gives last 3 elements of list nums?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('238f3ac7-3d10-4050-8442-2a8f2cf2e189', '4e183786-91f4-4c65-b423-8d13a04a9d63', N'nums[3]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0b2ac53b-fb94-4a3c-ab67-668db44f2be8', '4e183786-91f4-4c65-b423-8d13a04a9d63', N'nums[-3:]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('178c64ab-6195-4ab3-978d-6e65d9a75289', '4e183786-91f4-4c65-b423-8d13a04a9d63', N'nums[:3]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('029bb80f-e939-4151-a942-c0b7541a423b', '4e183786-91f4-4c65-b423-8d13a04a9d63', N'nums[:-3]', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('083952e5-2922-4760-9c03-d08820fef80d', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('494617ad-358b-4e37-8ee6-c6db0841073b', '083952e5-2922-4760-9c03-d08820fef80d', N'Which is TRUE about tuples?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c83e5b63-76e9-4ffc-9806-a00083166361', '494617ad-358b-4e37-8ee6-c6db0841073b', N'They are mutable.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f30f6a31-c7d5-4732-bfeb-d18f90250a42', '494617ad-358b-4e37-8ee6-c6db0841073b', N'Can be used as dict keys.', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4deb0484-682d-434e-b213-b02d228c1687', '494617ad-358b-4e37-8ee6-c6db0841073b', N'Slower than lists.', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('201cd08b-c611-442f-bac2-0d7831ffc360', '494617ad-358b-4e37-8ee6-c6db0841073b', N'Not indexable.', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('6cc3fb95-b58d-4aa5-b253-0099ea05cfaf', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('1a3a986d-3e85-4f01-98a5-71f50e026b7f', '6cc3fb95-b58d-4aa5-b253-0099ea05cfaf', N'What’s output?  words=["hi","hello","hey"]  print([w[0] for w in words])', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('429a3faa-2c15-4acb-b499-73ce0030906f', '1a3a986d-3e85-4f01-98a5-71f50e026b7f', N'["hi","hello","hey"]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('91ce121e-e8cd-4d7f-a187-784365f1900b', '1a3a986d-3e85-4f01-98a5-71f50e026b7f', N'["h","h","h"]', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('967b88c3-e0b9-4157-99cb-696f063ec705', '1a3a986d-3e85-4f01-98a5-71f50e026b7f', N'["i","e","y"]', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('07df6f58-49b0-43e9-9a13-28aef9e48c78', '1a3a986d-3e85-4f01-98a5-71f50e026b7f', N'Error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('b63bfcc1-a1b9-4f22-bc8f-b68578128046', '007ccfb7-e6f4-493f-85ae-66520c4231c5', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('9bd6b11e-0e43-4b5b-ac19-6149f0893429', 'b63bfcc1-a1b9-4f22-bc8f-b68578128046', N'Why use deep copy over shallow copy?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('75facee3-4da4-43e3-95b2-538e29bce5b9', '9bd6b11e-0e43-4b5b-ac19-6149f0893429', N'It’s faster', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('70bafe8d-939c-4c69-aaee-5131e2f6d34b', '9bd6b11e-0e43-4b5b-ac19-6149f0893429', N'To copy nested structures safely', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4327870c-8f82-4ed8-ad22-10684cd36c43', '9bd6b11e-0e43-4b5b-ac19-6149f0893429', N'It uses less memory', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('4498d04a-a2d8-449c-be1b-7ee0324cbd94', '9bd6b11e-0e43-4b5b-ac19-6149f0893429', N'It removes duplicates', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('f5fe55e3-2563-4f3b-9e45-122c9ca50eac', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('ac90782b-0cb9-49c8-a909-cad3d48d41cf', 'f5fe55e3-2563-4f3b-9e45-122c9ca50eac', N'Which keyword defines a class?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('eadf3eed-c438-4690-801e-5ba5b3e1366c', 'ac90782b-0cb9-49c8-a909-cad3d48d41cf', N'class', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a86e07a7-9cdd-459b-9b70-3ea00535bc54', 'ac90782b-0cb9-49c8-a909-cad3d48d41cf', N'def', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('75435a3a-878c-44cc-b5c9-bd30012ce4c5', 'ac90782b-0cb9-49c8-a909-cad3d48d41cf', N'object', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a4e1b1b6-1ed8-46c0-a8ca-8c5ba70ef015', 'ac90782b-0cb9-49c8-a909-cad3d48d41cf', N'new', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('6b7d7193-cb15-41ff-adb1-975a6c508225', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('090072ca-affc-492b-a03a-8aed59864eeb', '6b7d7193-cb15-41ff-adb1-975a6c508225', N'What is self in a method?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('54650900-b629-4866-9e37-f223bf004a44', '090072ca-affc-492b-a03a-8aed59864eeb', N'Refers to module', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8ec5365e-b1df-4b8f-b2af-eb3ce697acd0', '090072ca-affc-492b-a03a-8aed59864eeb', N'Refers to the object instance', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('319228e9-0250-4169-8ec3-78c2704c2186', '090072ca-affc-492b-a03a-8aed59864eeb', N'Refers to class', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2ba7565f-3b5a-4375-8840-00e126ab6179', '090072ca-affc-492b-a03a-8aed59864eeb', N'Refers to parent', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0a44a0f8-65c9-42c2-ac97-27ca5f5f3d4e', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('59d8013a-2d6e-4173-8586-f17b37b597c3', '0a44a0f8-65c9-42c2-ac97-27ca5f5f3d4e', N'Which method runs when object is created?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('578df3dc-8d3c-49ea-b807-17f76d640a43', '59d8013a-2d6e-4173-8586-f17b37b597c3', N'start()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('59c8be99-a4fa-402b-b66b-00e773d13511', '59d8013a-2d6e-4173-8586-f17b37b597c3', N'new()', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e23b0de7-6640-437a-905e-2d36a4f35f27', '59d8013a-2d6e-4173-8586-f17b37b597c3', N'init()', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1003dd68-9cf2-4e1f-b00a-5467da366ea2', '59d8013a-2d6e-4173-8586-f17b37b597c3', N'begin()', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('18c97dcd-647b-4271-8260-56d7d7ff722d', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('0465935a-f872-4099-a75b-ca3548c0a4e2', '18c97dcd-647b-4271-8260-56d7d7ff722d', N'What does @staticmethod mean?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e8557291-85dd-4625-9ab2-edae329f7f8b', '0465935a-f872-4099-a75b-ca3548c0a4e2', N'Bound to object', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f0fd56ed-5afc-419a-9d19-d364b9881626', '0465935a-f872-4099-a75b-ca3548c0a4e2', N'Bound to class', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8f2eb85a-d39e-4d49-a5c9-c90febf784e7', '0465935a-f872-4099-a75b-ca3548c0a4e2', N'No binding needed', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f002a0c6-f06e-4e90-9a86-c5ece5fbe8f9', '0465935a-f872-4099-a75b-ca3548c0a4e2', N'Creates static variable', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('367137b0-d5a6-4ddd-9879-3b668c2f3f13', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('ccdc18c8-9dee-437d-b397-968c19d95f2b', '367137b0-d5a6-4ddd-9879-3b668c2f3f13', N'Which block handles exceptions?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5bf9b23f-6f22-4bec-923f-b9e00528b686', 'ccdc18c8-9dee-437d-b397-968c19d95f2b', N'try', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f085e484-d2d2-4db6-a33e-e8850df217ae', 'ccdc18c8-9dee-437d-b397-968c19d95f2b', N'except', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('42d4c08e-dce9-402e-8b54-604fbbeef145', 'ccdc18c8-9dee-437d-b397-968c19d95f2b', N'finally', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ffb32d01-1500-47f7-b8ad-0d68bbd95de9', 'ccdc18c8-9dee-437d-b397-968c19d95f2b', N'raise', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('0ce32daa-7224-4957-bd82-51bb3ee28194', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e69058c3-b435-4e1d-ba94-a713750f457d', '0ce32daa-7224-4957-bd82-51bb3ee28194', N'Which is true about inheritance?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('ae884136-6160-468f-af9d-c636307c68b1', 'e69058c3-b435-4e1d-ba94-a713750f457d', N'Child class can’t override parent method', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('497b8a30-4586-43eb-b2c4-ed870d0e33f2', 'e69058c3-b435-4e1d-ba94-a713750f457d', N'Parent inherits from child', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('dbaad59a-7bb8-4c0c-b3e0-17dc6985ba48', 'e69058c3-b435-4e1d-ba94-a713750f457d', N'Child inherits methods/attributes from parent', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bda4ae83-90b6-41bf-b711-0ce88d261156', 'e69058c3-b435-4e1d-ba94-a713750f457d', N'Inheritance not supported in Python', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('629eb92f-a6fb-4210-89c8-41198d8f5138', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('c5b131a1-8b96-4e59-b044-3016cdc924cd', '629eb92f-a6fb-4210-89c8-41198d8f5138', N'What does this code print?  class A: pass  a = A()  print(isinstance(a, A))', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('6a0296b8-a7de-4e9a-b48a-0cc89ce57290', 'c5b131a1-8b96-4e59-b044-3016cdc924cd', N'False', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('2a23b526-e45c-46f5-88c7-872a70935695', 'c5b131a1-8b96-4e59-b044-3016cdc924cd', N'True', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('88442ba0-ecbf-4439-a808-79ac7c5ca9bd', 'c5b131a1-8b96-4e59-b044-3016cdc924cd', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('63f979b9-2dbf-4d55-a563-643640810a65', 'c5b131a1-8b96-4e59-b044-3016cdc924cd', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('27509c45-8729-4fb6-804b-8ac9907478a2', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('ad02d482-137c-43ac-8400-d9d5ebd8736f', '27509c45-8729-4fb6-804b-8ac9907478a2', N'Which is the parent of all classes in Python?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e2867d4f-8c0e-4f58-9575-27d60de6f934', 'ad02d482-137c-43ac-8400-d9d5ebd8736f', N'class', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('9406cc6e-34d9-4465-a096-97f9dbd83f6f', 'ad02d482-137c-43ac-8400-d9d5ebd8736f', N'object', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1f17c79d-08a7-4f7f-9bd9-7a8434064a31', 'ad02d482-137c-43ac-8400-d9d5ebd8736f', N'base', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('af974e6b-ae98-4bfb-9414-cf3e844c92e6', 'ad02d482-137c-43ac-8400-d9d5ebd8736f', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('213c4b7f-66d9-4233-bc3b-32ec7afc6b82', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('380f44ba-7c48-4b30-9ef3-5d27619ffcfe', '213c4b7f-66d9-4233-bc3b-32ec7afc6b82', N'Which block always runs, regardless of error?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('824d92d6-93b5-4754-9d95-021ce787ee37', '380f44ba-7c48-4b30-9ef3-5d27619ffcfe', N'try', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('404330b5-e8ce-45b5-a637-6479bdc7e503', '380f44ba-7c48-4b30-9ef3-5d27619ffcfe', N'except', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('5926d99a-57fb-4a70-8837-c2fc65648070', '380f44ba-7c48-4b30-9ef3-5d27619ffcfe', N'else', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7137870c-128c-468d-bc2f-3cebce636c66', '380f44ba-7c48-4b30-9ef3-5d27619ffcfe', N'finally', 1);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('77b41e50-db5c-4a26-abd4-7220d91942ff', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('87d1a511-4528-41ca-bf5d-0ee208968d36', '77b41e50-db5c-4a26-abd4-7220d91942ff', N'Which raises an exception manually?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('57fa7ef6-97c4-4e3b-8d3e-6f447d23c021', '87d1a511-4528-41ca-bf5d-0ee208968d36', N'throw', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7e00cfd0-775e-4251-923f-3ddf742d651b', '87d1a511-4528-41ca-bf5d-0ee208968d36', N'raise', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('bf184b16-26f2-490a-a6ac-fcbb1ed30566', '87d1a511-4528-41ca-bf5d-0ee208968d36', N'except', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('886639d1-80d7-42f7-9edc-2ee5099418ef', '87d1a511-4528-41ca-bf5d-0ee208968d36', N'error', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('f46054ed-9dcd-46ab-8962-e2f518951a37', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('e1c3be49-08aa-4c0a-b950-182ca98eb2be', 'f46054ed-9dcd-46ab-8962-e2f518951a37', N'What is output?  class A:      def show(self): print("A")  class B(A):      def show(self): print("B")  obj = B()  obj.show()', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('156eeba7-039b-4324-9730-d6be866d0884', 'e1c3be49-08aa-4c0a-b950-182ca98eb2be', N'A', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e01827e3-d986-4994-a578-803e10abf074', 'e1c3be49-08aa-4c0a-b950-182ca98eb2be', N'B', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('206e18ba-7124-4d6e-8cea-826483c11b25', 'e1c3be49-08aa-4c0a-b950-182ca98eb2be', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('40f6e55c-a054-443b-b39f-987c6469dd3b', 'e1c3be49-08aa-4c0a-b950-182ca98eb2be', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('b47a4675-2537-42e8-86c8-d648e6895826', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('7238a59a-016a-4efd-ac90-c7a7c971bba3', 'b47a4675-2537-42e8-86c8-d648e6895826', N'Which of these defines a custom exception?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('90412826-f8ff-44ce-b964-2a157dd211bf', '7238a59a-016a-4efd-ac90-c7a7c971bba3', N'class MyError: pass', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('25e999dc-0163-495c-8105-6368038b3dff', '7238a59a-016a-4efd-ac90-c7a7c971bba3', N'class MyError(Exception): pass', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d8dcb4f3-f624-478d-ad13-9304aec0972b', '7238a59a-016a-4efd-ac90-c7a7c971bba3', N'def MyError(): pass', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('eb68de65-35b0-4b0b-a79e-fcf23f3a0b5a', '7238a59a-016a-4efd-ac90-c7a7c971bba3', N'raise MyError', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('6a8cdd31-2599-42eb-9ff4-ba3d7030d90c', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('0b285ef7-d91c-4f97-bad9-12378d1867ab', '6a8cdd31-2599-42eb-9ff4-ba3d7030d90c', N'What does polymorphism allow?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1743275b-f185-4b75-9024-9c3a769dfbff', '0b285ef7-d91c-4f97-bad9-12378d1867ab', N'Using multiple classes with same method names', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('67e7bb8f-e622-4d16-8e6e-e565428e6eec', '0b285ef7-d91c-4f97-bad9-12378d1867ab', N'Using only one method per class', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('eaf6f37e-a9f4-4b87-aec3-49e6d7b2fc4f', '0b285ef7-d91c-4f97-bad9-12378d1867ab', N'Changing variable type', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8b98b48c-101a-45cd-a4b9-54dd56a5b3ce', '0b285ef7-d91c-4f97-bad9-12378d1867ab', N'Writing multiple init methods', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('9ca4e41b-18d7-4017-9d92-b445489cac5e', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('2d2b7f4b-17ba-4bf6-9b98-e56f4f1b6087', '9ca4e41b-18d7-4017-9d92-b445489cac5e', N'Which method creates object without calling init?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('0efbfeab-2e0c-49c1-b8ac-6b0dbe608f82', '2d2b7f4b-17ba-4bf6-9b98-e56f4f1b6087', N'new', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b2348f08-8421-4adb-8459-db726a043080', '2d2b7f4b-17ba-4bf6-9b98-e56f4f1b6087', N'create', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('d519ed7b-8b82-41c9-9303-1d7d108d5382', '2d2b7f4b-17ba-4bf6-9b98-e56f4f1b6087', N'obj', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('f104a00c-b9e4-4b64-a481-0d9ec4ca8971', '2d2b7f4b-17ba-4bf6-9b98-e56f4f1b6087', N'class', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('87730b51-3f9b-401d-b3d1-dfdaec258a85', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('db138de1-ce5c-40b5-a3dd-e53629161154', '87730b51-3f9b-401d-b3d1-dfdaec258a85', N'What happens if error is not handled?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('237da6d2-4485-4bfc-9051-2218843db12e', 'db138de1-ce5c-40b5-a3dd-e53629161154', N'Program ignores it', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('c052324c-29df-4f57-ae28-83d95a6857c6', 'db138de1-ce5c-40b5-a3dd-e53629161154', N'Program crashes', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('80bddeb7-c34c-4100-885a-d7c13251ae50', 'db138de1-ce5c-40b5-a3dd-e53629161154', N'Error gets logged silently', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('25d193a8-9445-40e9-845d-778006eaca2b', 'db138de1-ce5c-40b5-a3dd-e53629161154', N'Nothing', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('91559a57-753d-4ea0-8139-625d794dd806', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('49f07b46-c0d4-4f40-a65f-e74f9d6b7ed1', '91559a57-753d-4ea0-8139-625d794dd806', N'Which OOP concept allows replacing large if/elif with class hierarchy?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('62f39ce3-15c8-4205-8109-ad69e15c5460', '49f07b46-c0d4-4f40-a65f-e74f9d6b7ed1', N'Inheritance + Polymorphism', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('553685f4-0131-4076-9d20-d98bad72d993', '49f07b46-c0d4-4f40-a65f-e74f9d6b7ed1', N'Encapsulation', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1c86eb74-4315-4926-aae8-6dead560b316', '49f07b46-c0d4-4f40-a65f-e74f9d6b7ed1', N'Abstraction', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('16319e42-d66c-4491-a3b5-2cbdf3922b19', '49f07b46-c0d4-4f40-a65f-e74f9d6b7ed1', N'Composition', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('05f306fa-59c3-4bea-a1f8-e6b275a510cd', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('45683ad2-d474-4b2f-b2a9-659bd48bbaf0', '05f306fa-59c3-4bea-a1f8-e6b275a510cd', N'Which prints “Meow”?  class Animal:      def speak(self): print("Generic")  class Cat(Animal):      def speak(self): print("Meow")  a = Cat(); a.speak()', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('80c2e9c0-b5eb-4071-9a2d-d2f4d02af9ba', '45683ad2-d474-4b2f-b2a9-659bd48bbaf0', N'Generic', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7784bb1b-51e9-4006-aed3-cf0e92f8298b', '45683ad2-d474-4b2f-b2a9-659bd48bbaf0', N'Meow', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('38c17fd3-c83b-4318-abd8-fa532999ea05', '45683ad2-d474-4b2f-b2a9-659bd48bbaf0', N'Error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('3d3618e1-1e90-4726-b9a3-8dd4841e3091', '45683ad2-d474-4b2f-b2a9-659bd48bbaf0', N'None', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('5638ba4f-d0cd-4ae6-8337-33eb78ea41db', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('f9af6861-d5b0-42d7-9134-62b02259838f', '5638ba4f-d0cd-4ae6-8337-33eb78ea41db', N'What’s the output?  try:      x=5/0  except:      print("Error")  else:      print("No error")', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('68e36461-80cb-407c-b122-d4bd0ba62bb4', 'f9af6861-d5b0-42d7-9134-62b02259838f', N'Error', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('a6073143-ed93-4705-989b-46ad6573d296', 'f9af6861-d5b0-42d7-9134-62b02259838f', N'No error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('52664020-6bff-4744-888d-561bc2b4de34', 'f9af6861-d5b0-42d7-9134-62b02259838f', N'Error + No error', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('7e856d49-1a6a-40e5-b5ad-9ce2033fe23d', 'f9af6861-d5b0-42d7-9134-62b02259838f', N'Crash', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('dffdc02e-b443-44da-b684-ea74167f036b', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('da43fae0-c404-4bcd-bc9c-08395cb436b6', 'dffdc02e-b443-44da-b684-ea74167f036b', N'Why use custom exceptions?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('da1577a7-7a1c-4880-bf1c-ee9d8727a0fc', 'da43fae0-c404-4bcd-bc9c-08395cb436b6', N'To confuse users', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('32179611-7695-4243-b165-bad1af1fc091', 'da43fae0-c404-4bcd-bc9c-08395cb436b6', N'For meaningful, specific error handling', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('1b7f76d9-929c-4e9b-ac29-2b9d2a363004', 'da43fae0-c404-4bcd-bc9c-08395cb436b6', N'To replace built-in errors', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('e42a3c84-c424-407e-a4b7-00903800d894', 'da43fae0-c404-4bcd-bc9c-08395cb436b6', N'To avoid debugging', 0);
GO
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) VALUES ('91d8cc3f-6f15-4b38-812c-de409612f3a1', 'f47f15f7-9d05-4509-9d5f-0926793c429e', 'mcq', NULL);
GO
INSERT INTO Questions (QuestionId, ResourceId, Stem, Difficulty, Explanation) VALUES ('11ed547f-9b75-480d-a54b-bafc32750f3e', '91d8cc3f-6f15-4b38-812c-de409612f3a1', N'Which method defines behaviour for str(obj)?', 'medium', NULL);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('b520b1a7-8004-49f3-a2bd-a2ef83e6d946', '11ed547f-9b75-480d-a54b-bafc32750f3e', N'repr', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('cf3b01ba-4658-4eb4-a8fd-5b25cf91aa72', '11ed547f-9b75-480d-a54b-bafc32750f3e', N'str', 1);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('8ccce4f4-4d1c-4db4-8213-bbac3aee8346', '11ed547f-9b75-480d-a54b-bafc32750f3e', N'format', 0);
GO
INSERT INTO QuestionOptions (OptionId, QuestionId, OptionText, IsCorrect) VALUES ('97fea60a-a00b-4869-9097-3c582910c407', '11ed547f-9b75-480d-a54b-bafc32750f3e', N'print', 0);
GO