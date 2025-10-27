# Publishing Guide for dial_codes Package

This guide walks you through the steps to publish your `dial_codes` package to pub.dev.

## Prerequisites

1. **Pub.dev Account**
   - Create an account at [pub.dev](https://pub.dev)
   - You'll need a Google account to sign in

2. **Verify Package Quality**
   - All tests pass ✅
   - No analyzer issues ✅
   - Documentation is complete ✅
   - Example is working ✅

## Step 1: Verify Package Structure

Run these commands to ensure everything is ready:

```bash
# Check for any issues
flutter analyze

# Run all tests
flutter test

# Check package score (dry run)
flutter pub publish --dry-run
```

## Step 2: Update Package Information

Make sure your `pubspec.yaml` has all required fields:

```yaml
name: dial_codes
description: "A comprehensive Flutter package for accessing country dial codes, country information, flags, and more."
version: 0.0.1
homepage: https://github.com/mahmoud-badwy/dial_codes
repository: https://github.com/mahmoud-badwy/dial_codes
issue_tracker: https://github.com/mahmoud-badwy/dial_codes/issues

environment:
  sdk: ^3.8.1
  flutter: ">=1.17.0"
```

**Important Fields:**
- `name` - Package name (must be unique on pub.dev)
- `description` - Short description (60-180 characters recommended)
- `version` - Current version (follow semantic versioning)
- `homepage` - Package homepage URL
- `repository` - Source code repository URL
- `issue_tracker` - Where users can report issues

## Step 3: Verify LICENSE

Ensure you have a LICENSE file. Your package currently has one. Common licenses:
- MIT (most common for Flutter packages)
- BSD
- Apache 2.0

## Step 4: Review Documentation

Ensure these files are complete:
- ✅ `README.md` - Package overview and usage
- ✅ `CHANGELOG.md` - Version history
- ✅ `LICENSE` - License information
- ✅ `example/` - Working example app

## Step 5: Run Dry Run

Test the publishing process without actually publishing:

```bash
flutter pub publish --dry-run
```

This will:
- Validate your package
- Check for common issues
- Show what will be published
- Calculate package score

**Fix any issues** that appear before proceeding.

## Step 6: Publish to Pub.dev

When everything looks good:

```bash
flutter pub publish
```

**What happens:**
1. You'll be prompted to confirm
2. A browser will open for authentication
3. Sign in with your Google account
4. Authorize the pub.dev CLI
5. Package will be uploaded
6. Package will be processed and published

**Note:** Publishing is **permanent** for each version. You cannot unpublish or delete versions (except within the first 7 days).

## Step 7: Verify Publication

After publishing:
1. Visit `https://pub.dev/packages/dial_codes`
2. Check the package page
3. Review the score (aim for 130+)
4. Check documentation rendering
5. Test the example

## Common Issues and Solutions

### Issue: "Package name already exists"
**Solution:** Choose a different package name in `pubspec.yaml`

### Issue: "Description too short"
**Solution:** Make description at least 60 characters

### Issue: "Missing homepage"
**Solution:** Add `homepage` field to `pubspec.yaml`

### Issue: "Low pub points"
**Solution:** 
- Add documentation comments to public APIs
- Follow Dart style guide
- Add more examples
- Improve README

### Issue: "Example doesn't work"
**Solution:** Test the example app thoroughly before publishing

## Updating Your Package

When you need to publish updates:

1. **Update Version** in `pubspec.yaml`:
   ```yaml
   version: 0.0.2  # Increment version
   ```

2. **Update CHANGELOG.md**:
   ```markdown
   ## 0.0.2
   * Bug fixes
   * New features
   ```

3. **Test thoroughly**:
   ```bash
   flutter test
   flutter analyze
   ```

4. **Publish update**:
   ```bash
   flutter pub publish
   ```

## Semantic Versioning

Follow semantic versioning (MAJOR.MINOR.PATCH):

- **PATCH** (0.0.X) - Bug fixes, no breaking changes
- **MINOR** (0.X.0) - New features, no breaking changes
- **MAJOR** (X.0.0) - Breaking changes

Examples:
- `0.0.1` → `0.0.2` - Bug fix
- `0.0.2` → `0.1.0` - New widget added
- `0.1.0` → `1.0.0` - API breaking change

## Pre-Publishing Checklist

Before running `flutter pub publish`:

- [ ] All tests pass
- [ ] No analyzer warnings
- [ ] README is complete and clear
- [ ] CHANGELOG is updated
- [ ] Example app works
- [ ] Version number is correct
- [ ] License is appropriate
- [ ] pubspec.yaml has all required fields
- [ ] Documentation is complete
- [ ] Dry run succeeds

## Package Maintenance

After publishing:

1. **Monitor Issues** - Respond to GitHub issues
2. **Accept Pull Requests** - Review and merge contributions
3. **Update Dependencies** - Keep dependencies current
4. **Fix Bugs** - Release patches as needed
5. **Add Features** - Release minor versions for new features

## Getting a Good Pub Score

Aim for maximum points (130) by:

- ✅ **Follow conventions** (20 points)
- ✅ **Provide documentation** (10 points)
- ✅ **Support multiple platforms** (20 points)
- ✅ **Pass static analysis** (30 points)
- ✅ **Support latest SDK** (20 points)
- ✅ **Have good popularity** (grows over time)

## Helpful Commands

```bash
# Check package health
flutter pub publish --dry-run

# Analyze code
flutter analyze

# Run tests
flutter test

# Format code
dart format .

# Check outdated dependencies
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade

# View package details
flutter pub deps
```

## Next Steps After Publishing

1. **Share your package**:
   - Post on Reddit (r/FlutterDev)
   - Tweet about it
   - Share on LinkedIn
   - Write a blog post

2. **Monitor analytics**:
   - Check pub.dev for download stats
   - Monitor GitHub stars
   - Track issues and PRs

3. **Gather feedback**:
   - Ask users for suggestions
   - Fix reported bugs
   - Add requested features

4. **Keep improving**:
   - Regular updates
   - Better documentation
   - More examples
   - Performance improvements

## Resources

- [Publishing Packages Guide](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Pub.dev Publishing Policy](https://pub.dev/policy)
- [Semantic Versioning](https://semver.org/)

---

## Quick Command Reference

```bash
# Pre-publish checks
flutter analyze
flutter test
flutter pub publish --dry-run

# Publish
flutter pub publish

# After making changes
# 1. Update version in pubspec.yaml
# 2. Update CHANGELOG.md
# 3. Test and analyze
# 4. Publish update
```

Good luck with your package! 🚀
