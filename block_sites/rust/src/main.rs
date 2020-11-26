use regex::Regex;
use std::fs;
use std::fs::File;
use std::io::prelude::*;

fn main() -> std::io::Result<()> {
    let mut file = File::open("testhosts")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;

    let lines: Vec<&str> = contents.split("\n").collect();

    let start_regex = Regex::new(r"blocked\ssites\sstart").unwrap();
    let end_regex = Regex::new(r"blocked\ssites\send").unwrap();
    let site_regex = Regex::new(r"^\s*#+\s*127\.0\.0\.1").unwrap();
    let replace_regex = Regex::new(r"^\s*#+\s*").unwrap();

    let mut blocked_sites_section = false;
    let lines: Vec<String> = lines
        .into_iter()
        .map(|line| {
            if start_regex.is_match(line) {
                blocked_sites_section = true;
            } else if end_regex.is_match(line) {
                blocked_sites_section = false;
            }

            if blocked_sites_section && site_regex.is_match(line) {
                let cow = replace_regex.replace(line, "");
                return cow.to_string();
            }

            return line.to_string();
        })
        .collect();
    let lines = lines.join("\n");
    fs::write("testhosts", lines).unwrap();

    Ok(())
}
