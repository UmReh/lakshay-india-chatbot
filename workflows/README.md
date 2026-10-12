# Workflows

Export both n8n workflows here (workflow menu, then Download):

- `enquiry-chatbot.json` - the chat workflow (webhook, retrieval, Gemini, logging, hot leads)
- `faq-ingestion.json` - the one-time workflow that loads the FAQ into Supabase

n8n exports credential names, not the secret values. Before committing, open each file and
search for `key`, `secret` and `token` to be sure nothing sensitive is inside.
