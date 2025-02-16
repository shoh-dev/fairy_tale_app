CREATE TABLE tales (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    cover_image TEXT NOT NULL,  -- URL to cover image
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE tale_pages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tale_id UUID REFERENCES tales(id) ON DELETE CASCADE,
    page_number INT NOT NULL,  -- Order of the page in the tale
    text TEXT NOT NULL,        -- Localized text (stored as a key)
    background_image TEXT,     -- URL to background image
    audio TEXT,                -- URL to narration audio
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE tale_interactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tale_page_id UUID REFERENCES tale_pages(id) ON DELETE CASCADE,
    event_type TEXT NOT NULL,   -- "tap", "tilt", "voice", etc.
    trigger TEXT NOT NULL,      -- Condition (e.g., "tilt_left", "say_open sesame")
    action TEXT NOT NULL,       -- Effect (e.g., "play_animation", "play_sound")
    hint TEXT NOT NULL,         -- Localized key for hints
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE localization (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language TEXT NOT NULL,  -- "en", "fr", "es", etc.
    key TEXT NOT NULL,       -- Unique key (e.g., "tale_1_page_1_text")
    value TEXT NOT NULL      -- Translated text
);