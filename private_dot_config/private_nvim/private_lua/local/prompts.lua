return {
  Email = {
    prompt = [[
      Provide a summary for these changes in a format digestible via email:
      - Change language to suit non-technical users.
      - No need to say "main platform" when mentioning merging; instead, say "deploy" (since we automatically deploy changes merged to main).
      - Avoid using markdown; email does not use markdown. Use plain text or HTML instead.
      - Ignore formatting or unimportant changes.
      - Simplify the summary; they don't need to know the specifics of policy changes.
      - When you see API mentioned as a heading or alone, it means the backend. Avoid using the term API if possible
      - When you see Client mentioned as a heading or alone, it means the Frontend. Avoid using the term Client if possible

    ]],
    system_prompt = 'You are very good at explaining stuff',
    mapping = '<leader>@',
    description = 'Summarise email',
  },
  acceptance = {
    prompt = [[
      Help write acceptance criteria based on the statements I provide. I might provide further context below which help form the relevant criteria.
      Keep the criteria short and concise.
      Each criteria should be less than 85 characters long so this serves as a max length.
      Each should start with "- [ ] " (without quotes) as I will be using them in markdown
    ]],
    system_prompt = 'You are very good at explaining stuff',
    mapping = '<leader>4',
    description = 'Provide acceptance criteria',
  },
  Hi = {
    prompt = 'Count the number of words in this line',
    system_prompt = 'You are skilled at counting.',
    mapping = '<leader>#',
    description = 'Count words',
  },
}
