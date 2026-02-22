#!/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
# hadnoir-skill Enhancement Script
# Apply research-backed best practices to scaffolded skills
# ═══════════════════════════════════════════════════════════════════════════════

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="${SCRIPT_DIR}/templates"
REFERENCES_DIR="${SCRIPT_DIR}/references"
SKILLS_BASE_DIR="${HOME}/.openclaw/skills"

# ═══════════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════════

print_header() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║           HADNOIR SKILL ENHANCER v1.0.0                       ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

show_usage() {
    echo "Usage: $0 <skill-name>"
    echo ""
    echo "Enhances a skill created by skill-creator with:"
    echo "  • Optimized SKILL.md with proper triggers"
    echo "  • Progressive disclosure structure"
    echo "  • Validation checks"
    echo ""
    echo "Example:"
    echo "  $0 my-awesome-skill"
    echo ""
    echo "The skill must already exist (created by skill-creator)"
}

# ═══════════════════════════════════════════════════════════════════════════════
# Validation Functions
# ═══════════════════════════════════════════════════════════════════════════════

validate_skill_exists() {
    local skill_name="$1"
    local skill_path="${SKILLS_BASE_DIR}/${skill_name}"
    
    if [[ ! -d "$skill_path" ]]; then
        print_error "Skill '${skill_name}' not found at:"
        print_error "  ${skill_path}"
        echo ""
        print_info "Make sure to run 'clawhub run skill-creator ${skill_name}' first"
        exit 1
    fi
    
    if [[ ! -f "${skill_path}/SKILL.md" ]]; then
        print_error "SKILL.md not found in ${skill_path}"
        print_info "The skill directory appears to be incomplete"
        exit 1
    fi
    
    print_success "Found skill: ${skill_name}"
}

validate_templates_exist() {
    if [[ ! -f "${TEMPLATES_DIR}/SKILL.md.enhanced" ]]; then
        print_error "Enhanced template not found:"
        print_error "  ${TEMPLATES_DIR}/SKILL.md.enhanced"
        exit 1
    fi
    
    print_success "Templates verified"
}

check_skill_md_size() {
    local skill_path="$1"
    local line_count
    
    line_count=$(wc -l < "${skill_path}/SKILL.md")
    
    if [[ $line_count -gt 500 ]]; then
        print_warning "SKILL.md is ${line_count} lines (recommended: <500)"
        print_info "Consider splitting content into references/"
    else
        print_success "SKILL.md size: ${line_count} lines (✓ under 500)"
    fi
}

check_frontmatter_triggers() {
    local skill_path="$1"
    local skill_file="${skill_path}/SKILL.md"
    
    # Check if frontmatter exists
    if ! grep -q "^---$" "$skill_file"; then
        print_warning "No YAML frontmatter detected"
        return 1
    fi
    
    # Check if description contains trigger phrases
    if grep -A 20 "^---$" "$skill_file" | grep -q "Use when"; then
        print_success "Frontmatter contains trigger phrases ('Use when')"
    else
        print_warning "Frontmatter missing explicit triggers"
        print_info "Add 'Use when: (1)... (2)...' to description"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
# Enhancement Functions
# ═══════════════════════════════════════════════════════════════════════════════

backup_original() {
    local skill_path="$1"
    local backup_name="SKILL.md.original.$(date +%Y%m%d_%H%M%S)"
    
    cp "${skill_path}/SKILL.md" "${skill_path}/${backup_name}"
    print_info "Backed up original SKILL.md to: ${backup_name}"
}

enhance_skill_md() {
    local skill_name="$1"
    local skill_path="$2"
    local template_file="${TEMPLATES_DIR}/SKILL.md"
    
    print_info "Enhancing SKILL.md..."
    
    # Copy enhanced template
    cp "$template_file" "${skill_path}/SKILL.md"
    
    # Replace placeholder with actual skill name
    sed -i "s/name: placeholder/name: ${skill_name}/g" "${skill_path}/SKILL.md"
    
    print_success "Replaced SKILL.md with enhanced template"
}

create_references_structure() {
    local skill_path="$1"
    
    print_info "Creating references/ structure..."
    
    mkdir -p "${skill_path}/references"
    
    # Create placeholder reference files
    cat > "${skill_path}/references/advanced.md" << 'EOF'
# Advanced Usage

<!-- Load this when dealing with complex scenarios -->

## Complex Configuration

Detailed configuration options for advanced use cases.

## Edge Cases

Handling unusual scenarios and workarounds.

## Performance Optimization

Tips for improving speed and efficiency.
EOF

    cat > "${skill_path}/references/troubleshooting.md" << 'EOF'
# Troubleshooting

<!-- Load this when errors occur -->

## Common Errors

### Error: [Error Name]
**Symptoms:** Description of what happens
**Cause:** Why it occurs
**Solution:** How to fix it

### Error: [Another Error]
...

## Debug Mode

How to enable and interpret debug output.
EOF

    cat > "${skill_path}/references/configuration.md" << 'EOF'
# Configuration Guide

<!-- Load this when customizing settings -->

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| option1 | string | "default" | What it does |
| option2 | number | 100 | What it does |

## Environment Variables

- `ENV_VAR_1`: Description
- `ENV_VAR_2`: Description
EOF

    print_success "Created references/ directory with starter files"
}

create_assets_structure() {
    local skill_path="$1"
    
    print_info "Creating assets/ structure..."
    
    mkdir -p "${skill_path}/assets"/{templates,components,styles}
    
    # Create README for assets
    cat > "${skill_path}/assets/README.md" << 'EOF'
# Assets

This directory contains files used in skill output (not loaded into context).

## Structure

- `templates/` - Reusable templates
- `components/` - Reusable components
- `styles/` - CSS, theme files

## Usage

These files are copied or modified during skill execution, not read into context.
EOF

    print_success "Created assets/ directory structure"
}

create_scripts_structure() {
    local skill_path="$1"
    
    print_info "Creating scripts/ structure..."
    
    mkdir -p "${skill_path}/scripts"
    
    # Create example script
    cat > "${skill_path}/scripts/example.sh" << 'EOF'
#!/bin/bash
# Example script for skill
# Add executable scripts here for deterministic operations

set -euo pipefail

echo "Example script - replace with actual functionality"
EOF

    chmod +x "${skill_path}/scripts/example.sh"
    
    print_success "Created scripts/ directory with example"
}

# ═══════════════════════════════════════════════════════════════════════════════
# Main Execution
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    print_header
    
    # Check arguments
    if [[ $# -eq 0 ]]; then
        show_usage
        exit 1
    fi
    
    local skill_name="$1"
    local skill_path="${SKILLS_BASE_DIR}/${skill_name}"
    
    print_info "Enhancing skill: ${skill_name}"
    echo ""
    
    # Validations
    validate_templates_exist
    validate_skill_exists "$skill_name"
    
    echo ""
    print_info "Starting enhancements..."
    echo "────────────────────────────────────────────────────────────────"
    
    # Backup original
    backup_original "$skill_path"
    
    # Apply enhancements
    enhance_skill_md "$skill_name" "$skill_path"
    create_references_structure "$skill_path"
    create_assets_structure "$skill_path"
    create_scripts_structure "$skill_path"
    
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    
    # Post-enhancement validation
    print_info "Running validation checks..."
    check_skill_md_size "$skill_path"
    check_frontmatter_triggers "$skill_path"
    
    echo ""
    print_success "Enhancement complete!"
    echo ""
    echo -e "${GREEN}Next steps:${NC}"
    echo "  1. Edit ${skill_path}/SKILL.md"
    echo "     - Replace 'placeholder' with actual skill name"
    echo "     - Update description with specific 'Use when' triggers"
    echo "     - Fill in Quick Start and Core Workflow sections"
    echo ""
    echo "  2. Customize references/ files"
    echo "     - Add domain-specific documentation"
    echo ""
    echo "  3. Add assets/ as needed"
    echo "     - Templates, components, styles"
    echo ""
    echo "  4. Test the skill: clawhub run ${skill_name}"
    echo ""
    echo -e "${BLUE}For help, see:${NC}"
    echo "  ${REFERENCES_DIR}/progressive-disclosure-patterns.md"
}

# Run main if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
