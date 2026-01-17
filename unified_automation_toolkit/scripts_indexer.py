
import os
import re
import hashlib
import json
import argparse
import sys

ROOT_DIR = "unified_automation_toolkit"
OUTPUT_FILE_MD = os.path.join(ROOT_DIR, "AI_README.md")
OUTPUT_FILE_JSON = os.path.join(ROOT_DIR, "context.json")

def get_file_hash(file_path):
    """Calculate MD5 hash of file content for deduplication."""
    hasher = hashlib.md5()
    with open(file_path, 'rb') as f:
        buf = f.read()
        hasher.update(buf)
    return hasher.hexdigest()

def analyze_script(file_path):
    rel_path = os.path.relpath(file_path, ROOT_DIR)
    intent = "Unknown functionality"
    safety = "Read-only"
    inputs = "None detected"
    keywords = set()
    
    # Add path-based keywords
    path_parts = rel_path.lower().replace('.', '_').split('/')
    keywords.update([p for p in path_parts if p not in ['unified_automation_toolkit']])

    try:
        with open(file_path, 'r', errors='ignore') as f:
            content = f.read(4096) # Read first 4kb
            lines = content.splitlines()
            
            # --- Better Intent Extraction ---
            description_found = False
            for line in lines[:30]:
                line = line.strip()
                # Skip shebang and empty lines
                if not line or line.startswith("#!"):
                    continue
                
                # Check for explicit description tags
                if "@description" in line or "Description:" in line:
                    intent = re.sub(r'^.*(@description|Description:)\s*', '', line).strip()
                    description_found = True
                    break
                
                # Use first meaningful comment that isn't a vim modeline or license
                if line.startswith("#") and not description_found:
                    clean_line = line.lstrip("# ").strip()
                    # Skip vim modelines
                    if "vim:" in clean_line or "ts=" in clean_line:
                        continue
                    # Skip license markers commonly found
                    if "License" in clean_line or "Copyright" in clean_line or "Author" in clean_line:
                        continue
                    # Skip shellcheck ignores
                    if "shellcheck" in clean_line:
                        continue
                        
                    if len(clean_line) > 10 and not description_found:
                        intent = clean_line
                        description_found = True # Lock it in unless better tag found later

            # --- Keyword Extraction from Comments ---
            # Look for "Keywords: foo, bar"
            for line in lines[:20]:
                if "Keywords:" in line or "@keywords" in line:
                    kws = re.sub(r'^.*(Keywords:|@keywords)\s*', '', line).split(',')
                    keywords.update([k.strip().lower() for k in kws if k.strip()])

            # --- Safety Checks ---
            # Context-aware basic checks
            destructive_patterns = [
                r'rm\s+-[rf]+',       # rm -rf
                r'mkfs',              # format
                r'dd\s+if=',          # raw disk write
                r'shutdown', 
                r'reboot', 
                r'truncate', 
                r'drop\s+table',      # sql drop
                r'delete\s+from',     # sql delete
                r'>\s*/dev/sd',       # writing to device
            ]
            
            for pat in destructive_patterns:
                if re.search(pat, content, re.IGNORECASE):
                    safety = "Destructive/Write"
                    break
            
            # --- Input Extraction ---
            # Regex for $1, $2, or arguments like $ARG, ${ARG}
            args = re.findall(r'\$\{?([a-zA-Z0-9_]+)\}?', content)
            # Filter distinct commons
            common_vars = {'HOME', 'PATH', 'USER', 'SHELL', 'PWD', 'BASH_SOURCE', '0', '?', 'date', 'echo'}
            found_args = [a for a in args if a not in common_vars and len(a) > 1]
            if found_args:
                # Dedupe and take top 5
                unique_args = list(set(found_args))
                inputs = f"Vars: {', '.join(unique_args[:5])}..."
                
    except Exception as e:
        intent = f"Error analysis: {e}"

    return {
        "Path": rel_path,
        "Intent": intent,
        "Trigger Keywords": ", ".join(sorted(list(keywords))),
        "Input Schema": inputs,
        "Safety Level": safety,
        "Hash": get_file_hash(file_path)
    }

def generate_markdown(scripts):
    lines = ["# Unified Automation Toolkit - AI Context\n"]
    lines.append(f"> Auto-generated index of {len(scripts)} scripts.\n")
    lines.append("| Script Path | Intent | Trigger Keywords | Input Schema | Safety Level |")
    lines.append("|---|---|---|---|---|")
    
    for s in scripts:
        lines.append(f"| `{s['Path']}` | {s['Intent']} | {s['Trigger Keywords']} | {s['Input Schema']} | {s['Safety Level']} |")
    
    return "\n".join(lines)

def main():
    parser = argparse.ArgumentParser(description="Generate AI Context for Automation Repo")
    parser.add_argument("--json", action="store_true", help="Output JSON format context.json")
    parser.add_argument("--dedupe", action="store_true", help="Report duplicates based on content hash")
    args = parser.parse_args()

    all_scripts = []
    seen_hashes = {}
    duplicates = []

    print(f"Scanning {ROOT_DIR}...")
    for root, dirs, files in os.walk(ROOT_DIR):
        for file in files:
            if file.endswith(".sh"):
                full_path = os.path.join(root, file)
                script_data = analyze_script(full_path)
                all_scripts.append(script_data)
                
                if args.dedupe:
                    h = script_data['Hash']
                    if h in seen_hashes:
                        duplicates.append((script_data['Path'], seen_hashes[h]))
                    else:
                        seen_hashes[h] = script_data['Path']

    # Sort by path
    all_scripts.sort(key=lambda x: x['Path'])

    # Write Markdown
    with open(OUTPUT_FILE_MD, "w") as f:
        f.write(generate_markdown(all_scripts))
    print(f"Generated {OUTPUT_FILE_MD} with {len(all_scripts)} entries.")

    # Write JSON if requested
    if args.json:
        with open(OUTPUT_FILE_JSON, "w") as f:
            json.dump(all_scripts, f, indent=2)
        print(f"Generated {OUTPUT_FILE_JSON}")

    # Report duplicates
    if args.dedupe and duplicates:
        print("\n=== DUPLICATE FILES FOUND ===")
        for new, old in duplicates:
            print(f"Duplicate Content: {new} == {old}")
    elif args.dedupe:
        print("\nNo duplicates found.")

if __name__ == "__main__":
    main()
