import re

def mark(text, args, Mark, extra_cli_args, *a):
    # We mark all individual wr for potential selection
    # e.g. WR-123456 or WR-12345 or WR-400000
    for idx, m in enumerate(re.finditer(r'\d{5,6}', text)):
        start, end = m.span()
        mark_text = text[start:end].replace('\n', '').replace('\0', '')
        # Highlight on screen
        yield Mark(idx, start, end, mark_text, {})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    matches, groupdicts = [], []
    for m, g in zip(data['match'], data['groupdicts']):
        if m:
            matches.append(m), groupdicts.append(g)
    for wr, match_data in zip(matches, groupdicts):
        # Open WR in browser.
        boss.open_url(f'https://wrms.catalyst.net.nz/wr.php?request_id={wr}')
