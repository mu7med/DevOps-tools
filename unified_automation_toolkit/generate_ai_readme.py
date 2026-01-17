
import os
import re

ROOT_DIR = "unified_automation_toolkit"
OUTPUT_FILE = os.path.join(ROOT_DIR, "AI_README.md")

def analyze_script(file_path):
    rel_path = os.path.relpath(file_path, ROOT_DIR)
    intent = "Unknown functionality"
    safety = "Read-only"
    inputs = "None detected"
    keywords = []

    try:
        with open(file_path, 'r', errors='ignore') as f:
            content = f.read(2048) # Read first 2kb
            lines = content.splitlines()
            
            # Intent extraction (look for Description or first comment)
            for line in lines[:10]:
                if line.startswith("#") and len(line) > 5 and "!" not in line:
                    clean_line = line.lstrip("# ").strip()
                    if clean_line:
                        intent = clean_line
                        break
            
            # Keywords extraction
            path_parts = rel_path.lower().replace('.', '_').split('/')
            keywords.extend(path_parts)
            
            # Safety checks
            destructive_patterns = ['rm ', 'mkfs', 'dd ', 'shutdown', 'reboot', ' truncate', 'drop ', 'delete']
            if any(p in content for p in destructive_patterns):
                safety = "Destructive/Write"
            
            # Input extraction
            args = re.findall(r'\$([1-9]|@|\*|[a-zA-Z_]+)', content)
            if args:
                inputs = f"Arguments detected: {', '.join(set(args[:5]))}..."
                
    except Exception as e:
        intent = f"Error reading file: {e}"

    return {
        "Path": rel_path,
        "Intent": intent,
        "Trigger Keywords": ", ".join(set(keywords)),
        "Input Schema": inputs,
        "Safety Level": safety
    }

def generate_markdown(scripts):
    lines = ["# Unified Automation Toolkit - AI Context\n"]
    lines.append("| Script Path | Intent | Trigger Keywords | Input Schema | Safety Level |")
    lines.append("|---|---|---|---|---|")
    
    for s in scripts:
        lines.append(f"| `{s['Path']}` | {s['Intent']} | {s['Trigger Keywords']} | {s['Input Schema']} | {s['Safety Level']} |")
    
    return "\n".join(lines)

all_scripts = []
for root, dirs, files in os.walk(ROOT_DIR):
    for file in files:
        if file.endswith(".sh"):
            full_path = os.path.join(root, file)
            all_scripts.append(analyze_script(full_path))

with open(OUTPUT_FILE, "w") as f:
    f.write(generate_markdown(all_scripts))

print(f"Generated AI_README.md with {len(all_scripts)} entries.")
