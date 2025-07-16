# Contributing to Notes App

Thank you for your interest in contributing to the Notes App! This document provides guidelines and instructions for contributing to this project.

## 🤝 Ways to Contribute

- **Report bugs** by opening an issue
- **Suggest features** or improvements
- **Submit code** improvements or bug fixes
- **Improve documentation**
- **Help with testing** on different platforms

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Git
- A code editor (VS Code, Android Studio, etc.)

### Setup

1. **Fork the repository**
   ```bash
   # Click the Fork button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/yourusername/noteapp_new.git
   cd noteapp_new
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/twizelissa/noteapp_new.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Set up Firebase** (see README.md for detailed instructions)

## 🏗️ Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 2. Make Your Changes

- Follow the existing code style and architecture
- Write clear, concise commit messages
- Add tests for new functionality
- Update documentation if needed

### 3. Test Your Changes

```bash
# Run tests
flutter test

# Run the app
flutter run

# Check code formatting
dart format .

# Analyze code
flutter analyze
```

### 4. Commit Your Changes

```bash
git add .
git commit -m "feat: add your feature description"
```

### 5. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## 📝 Coding Standards

### Code Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper error handling

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `ci:` CI/CD changes

Examples:
```
feat: add search functionality to notes
fix: resolve authentication state persistence issue
docs: update README with new setup instructions
refactor: improve note repository error handling
```

### Architecture Guidelines

This project follows **Clean Architecture** principles:

#### Domain Layer (`lib/domain/`)
- Contains business logic and entities
- Independent of external frameworks
- Define repository interfaces here

#### Data Layer (`lib/data/`)
- Implements repository interfaces
- Handles external data sources (Firebase)
- Contains data models and services

#### Presentation Layer (`lib/presentation/`)
- Contains UI components and BLoC
- Handles user interactions
- Manages application state

#### Core Layer (`lib/core/`)
- Shared utilities and widgets
- Common constants and configurations
- Reusable components

### Testing Guidelines

- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for complete user flows
- Aim for good test coverage
- Mock external dependencies

Example test structure:
```dart
void main() {
  group('AuthBloc', () {
    test('should emit AuthLoading then AuthAuthenticated when sign in succeeds', () async {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

## 🐛 Reporting Bugs

When reporting bugs, please include:

1. **Bug description** - Clear description of the issue
2. **Steps to reproduce** - Step-by-step instructions
3. **Expected behavior** - What should happen
4. **Actual behavior** - What actually happens
5. **Environment details** - OS, Flutter version, device info
6. **Screenshots** - If applicable
7. **Logs** - Error messages or stack traces

## 💡 Suggesting Features

When suggesting features:

1. **Check existing issues** - Avoid duplicates
2. **Describe the problem** - What need does this address?
3. **Propose a solution** - How should it work?
4. **Consider alternatives** - Are there other approaches?
5. **Additional context** - Mockups, examples, etc.

## 📋 Pull Request Process

1. **Update documentation** if needed
2. **Add tests** for new functionality
3. **Ensure all tests pass**
4. **Update CHANGELOG.md** with your changes
5. **Request review** from maintainers
6. **Address feedback** promptly

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## 🎯 Good First Issues

Look for issues labeled `good first issue` if you're new to the project. These are beginner-friendly issues that help you get familiar with the codebase.

## 📞 Getting Help

- **GitHub Issues** - For bugs and feature requests
- **GitHub Discussions** - For questions and general discussion
- **Email** - twizelissa@gmail.com for direct contact

## 🏆 Recognition

Contributors will be recognized in:
- README.md contributors section
- CHANGELOG.md for their contributions
- GitHub contributors page

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to make this project better! 🚀
