const file = await Deno.readTextFile('./testhosts');

let blocked_sites_section = false;

const lines = file.split('\n').map((line): string => {
  if (/blocked\ssites\sstart/.test(line)) {
    blocked_sites_section = true;
  } else if (/blocked\ssites\send/.test(line)) {
    blocked_sites_section = false;
  }

  if (blocked_sites_section && /^\s*#+\s*127\.0\.0\.1/.test(line)) {
    line = line.replace(/^\s*#+\s*/, '');
  }

  return line;
});

await Deno.writeTextFile('./testhosts', lines.join('\n'));
