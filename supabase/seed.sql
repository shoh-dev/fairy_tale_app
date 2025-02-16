INSERT INTO tales (id, title, description, cover_image, language_code)
VALUES 
    ('11111111-1111-1111-1111-111111111111', 
     'Kolobok', 
     'A little round bun escapes from its grandparents and meets different animals along the way.',
     'https://yourcdn.com/tales/kolobok/cover.jpg',
     'en');


INSERT INTO tale_pages (id, tale_id, page_number, text, background_image, audio)
VALUES 
    ('22222222-2222-2222-2222-222222222222', 
     '11111111-1111-1111-1111-111111111111', 
     1, 
     'tale_kolobok_page_1_text', 
     'https://yourcdn.com/tales/kolobok/page1.jpg', 
     'https://yourcdn.com/tales/kolobok/page1.mp3'),

    ('33333333-3333-3333-3333-333333333333', 
     '11111111-1111-1111-1111-111111111111', 
     2, 
     'tale_kolobok_page_2_text', 
     'https://yourcdn.com/tales/kolobok/page2.jpg', 
     'https://yourcdn.com/tales/kolobok/page2.mp3');


INSERT INTO tale_interactions (id, tale_page_id, event_type, trigger, action, hint)
VALUES 
    ('44444444-4444-4444-4444-444444444444', 
     '22222222-2222-2222-2222-222222222222', 
     'swipe', 
     'swipe_right', 
     'move_kolobok', 
     'hint_swipe_right_to_roll_kolobok'),

    ('55555555-5555-5555-5555-555555555555', 
     '33333333-3333-3333-3333-333333333333', 
     'tap', 
     'tap_fox', 
     'play_sound', 
     'hint_tap_fox_to_hear_song');

-- INSERT INTO tale_interactions (id, tale_id, page_number, event_type, event_subtype, initial_pos, source_pos, action, hint_key)
-- VALUES 
--   ('44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 1, 'swipe', 'swipe_left', 
--    '{"x": 0.8, "y": 0.5}', '{"x": 0.2, "y": 0.5}', 'move_character', 'hint_swipe_left'),
--   ('55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 1, 'tap', 'long_press', 
--    '{"x": 0.5, "y": 0.8}', '{"x": 0.5, "y": 0.8}', 'jump', 'hint_long_press');




INSERT INTO localization (id, language, key, value)
VALUES 
    ('66666666-6666-6666-6666-666666666666', 'en', 'tale_kolobok_page_1_text', 'Once upon a time, an old man and an old woman baked a little round bun called Kolobok...'),
    ('77777777-7777-7777-7777-777777777777', 'en', 'tale_kolobok_page_2_text', 'Kolobok rolled away and met a cunning fox...'),
    ('88888888-8888-8888-8888-888888888888', 'en', 'hint_swipe_right_to_roll_kolobok', 'Swipe right to help Kolobok roll away!'),
    ('99999999-9999-9999-9999-999999999999', 'en', 'hint_tap_fox_to_hear_song', 'Tap on the fox to hear its song!');
