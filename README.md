# terraform-githooks

This repository contains:
- Terraform specific git hooks (see: `hooks/`).
- Generic git hook wrapper scripts that _can_ be re-used for purposes outside of Terraform (see: `*.sh`).

The hook scripts are written in Bash and make use of the `terraform` command as well as [Terraform Documenter](https://github.com/martinbaillie/terraform-documenter) to enforce consistent linting, formatting and documentation standards across Terraform modules.

### Usage
1. Symlink or `git submodule` this repository to a location within your Terraform module (e.g. `.bin/`).
2. Run `.bin/install_hooks`.
3. Consider making this part of your developer workflow through a Terraform module boilerplate.

### Examples
Terraform repository with hooks and lots of issues:
![](https://github.com/martinbaillie/terraform-documenter/raw/master/images/issues.png)

Terraform repository with hooks and issues gradually fixed:
![](https://github.com/martinbaillie/terraform-documenter/raw/master/images/fixes.png)
