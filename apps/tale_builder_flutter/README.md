# tale_builder_flutter

create or replace function upsert_full_tale(
  tale_data jsonb,
  localization_data jsonb default null,
  pages_data jsonb default null,
  texts_data jsonb default null
)
returns jsonb as $$
declare
  updated_tale jsonb;
  updated_pages jsonb;
  updated_localization jsonb;
  updated_texts jsonb;
  page jsonb;
  text jsonb;
begin
  -- Upsert tale
  insert into tales (
    id,
    title,
    description,
    orientation,
    metadata,
    created_at
  )
  values (
    (tale_data->>'id')::uuid,
    tale_data->>'title',
    coalesce(tale_data->>'description', ''),
    coalesce(tale_data->>'orientation', 'landscape'),
    coalesce(tale_data->'metadata', '{"cover_image_url": "", "background_audio_url": ""}'::jsonb),
    coalesce((tale_data->>'created_at')::timestamp, now())
  )
  on conflict (id) do update set
    title = excluded.title,
    description = excluded.description,
    orientation = excluded.orientation,
    metadata = excluded.metadata;

  -- Upsert pages (if any)
  if pages_data is not null then
    for page in select * from jsonb_array_elements(pages_data)
    loop
      insert into pages (
        id,
        tale_id,
        page_number,
        text,
        metadata,
        created_at
      )
      values (
        (page->>'id')::uuid,
        (tale_data->>'id')::uuid,
        (page->>'page_number')::int,
        page->>'text',
        coalesce(page->'metadata', '{}'::jsonb),
        coalesce((page->>'created_at')::timestamp, now())
      )
      on conflict (id) do update set
        page_number = excluded.page_number,
        text = excluded.text,
        metadata = excluded.metadata;
    end loop;
  end if;

  -- Upsert localization (if provided)
  if localization_data is not null then
    insert into localizations (
      tale_id,
      translations,
      default_locale,
      updated_at
    )
    values (
      (tale_data->>'id')::uuid,
      localization_data->'translations',
      coalesce(localization_data->>'default_locale', 'en'),
      now()
    )
    on conflict (tale_id) do update set
      translations = excluded.translations,
      default_locale = excluded.default_locale,
      updated_at = now();
  end if;

  -- Upsert texts (if provided)
  if texts_data is not null then
    for text in select * from jsonb_array_elements(texts_data)
    loop
      insert into texts (
        id,
        tale_page_id,
        text,
        metadata,
        created_at
      )
      values (
        (text->>'id')::uuid,
        (text->>'tale_page_id')::uuid,
        text->>'text',
        coalesce(text->'metadata', '{"pos": {"x": 0, "y": 0}, "size": {"h": 0, "w": 0}}'::jsonb),
        coalesce((text->>'created_at')::timestamp, now())
      )
      on conflict (id) do update set
        tale_page_id = excluded.tale_page_id,
        text = excluded.text,
        metadata = excluded.metadata;
    end loop;
  end if;

  -- Fetch updated tale row
  select to_jsonb(t) into updated_tale
  from tales t
  where t.id = (tale_data->>'id')::uuid;

  -- Fetch updated pages list
  select jsonb_agg(to_jsonb(p)) into updated_pages
  from pages p
  where p.tale_id = (tale_data->>'id')::uuid;

  -- Fetch updated localization
  select to_jsonb(l) into updated_localization
  from localizations l
  where l.tale_id = (tale_data->>'id')::uuid;

  -- Fetch updated texts list
  select jsonb_agg(to_jsonb(t)) into updated_texts
  from texts t
  where t.tale_page_id in (select id from pages where tale_id = (tale_data->>'id')::uuid);

  -- Return tale data, pages data, localization data, and texts data
  return jsonb_build_object(
    'tale_data', updated_tale,
    'pages_data', updated_pages,
    'localization_data', updated_localization,
    'texts_data', updated_texts
  );
end;
$$ language plpgsql;


-- DROP FUNCTION upsert_full_tale(jsonb,jsonb,jsonb,jsonb);