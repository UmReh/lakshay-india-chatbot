-- Run this once in the Supabase SQL Editor.
-- The vector size (3072) must match the embedding model's output size
-- (gemini-embedding-001 produces 3072 numbers by default).

create extension if not exists vector;

create table documents (
  id bigserial primary key,
  content text,
  metadata jsonb,
  embedding vector(3072)
);

create function match_documents (
  query_embedding vector(3072),
  match_count int default null,
  filter jsonb default '{}'
) returns table (
  id bigint,
  content text,
  metadata jsonb,
  similarity float
)
language plpgsql
as $$
#variable_conflict use_column
begin
  return query
  select id, content, metadata,
    1 - (documents.embedding <=> query_embedding) as similarity
  from documents
  where metadata @> filter
  order by documents.embedding <=> query_embedding
  limit match_count;
end;
$$;

-- If n8n cannot see the new table or function, run:
-- NOTIFY pgrst, 'reload schema';
