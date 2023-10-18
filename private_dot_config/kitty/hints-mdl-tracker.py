import re

def mark(text, args, Mark, extra_cli_args, *a):
    # We mark all individual tracker for potential selection
    # e.g. MDL-123456 or MDL-12345 or MDL-400000
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
    for tracker, match_data in zip(matches, groupdicts):
        # Open MDL in browser.
        boss.open_url(f'https://tracker.moodle.org/browse/MDL-{tracker}')
