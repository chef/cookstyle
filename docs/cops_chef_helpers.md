# 📁 `helpers/` Directory in Cookstyle

## 🧩 Purpose of the `helpers/` Directory

The `helpers/` directory inside `lib/rubocop/cop/chef/` is introduced to encapsulate **reusable logic** shared across multiple RuboCop Cops. These helpers improve code **modularity**, **readability**, and **maintainability**.

By moving repeated logic into clearly named helper modules, we:

- Avoid duplication across Cops.
- Enable easier unit testing and updates.
- Improve consistency in pattern matching.
- Encourage standardized design across Cookstyle rules.

---

## 📁 Location

lib/rubocop/cop/chef/helpers/

```

Example file:
```

lib/rubocop/cop/chef/helpers/resource\_matcher.rb

---

## ✅ Why Helpers Improve the Codebase

### Before Helpers
- Each Cop implemented its own logic to match resources like `execute`, `package`, etc.
- This resulted in **duplicated methods**, inconsistencies in naming, and higher maintenance effort.

### After Helpers
- Centralized matching logic (e.g., `resource_type?`, `matches_property?`).
- Reuse in multiple Cop classes.
- Easy to add support for new Chef resources in a single location.

---

## ✅ Where It Is Used

### 1. `chef/modernize/execute_apt_update`

**Before:**
```ruby
node.respond_to?(:resource_type) && node.resource_type == 'execute'


**After using helper:**

```ruby
resource_type?(node, 'execute')
```

**Benefits:**

* Makes the condition more readable.
* Prevents repetition of AST navigation logic across Cops.

---

### 2. `chef/performance/repeated_resources_in_loops`

**Before:**

* Redundant logic for resource matching inside loop constructs.
* Manual checks for resource names and property keys.

**After using helper:**

```ruby
resource_type?(resource_node, 'package') && matches_property?(resource_node, 'action', 'install')
```

**Benefits:**

* Abstracts AST pattern traversal.
* Reuses reliable, tested logic.
* Improves performance rule clarity.

---

## 🧭 Where This Can Be Used Next

### Suggested Cops and Directories:

| Directory          | Cop                                                    | Opportunity                                            |
| ------------------ | ------------------------------------------------------ | ------------------------------------------------------ |
| `chef/modernize`   | `ExecuteSleep`                                         | Matching `execute` resources running `sleep`           |
| `chef/modernize`   | `ExecuteScExe`                                         | Match `execute` with `sc.exe` command                  |
| `chef/modernize`   | `ExecuteTzutil`                                        | Detect usage of `tzutil` in `execute`                  |
| `chef/modernize`   | `WindowsTaskChangeAction`                              | Match resource type `windows_task` with legacy actions |
| `chef/performance` | `ExecuteRepeated`                                      | Detect repeated resource executions                    |
| `chef/shared`      | Any cop rechecking the same resource or property logic |                                                        |

These Cops can immediately benefit from `resource_type?`, `matches_property?`, or custom helper functions like `command_in_execute?`.

---

## 🧱 Common Helper Methods (in `resource_matcher.rb`)

| Method                                      | Purpose                                                                  |
| ------------------------------------------- | ------------------------------------------------------------------------ |
| `resource_type?(node, type)`                | Check if AST node is a resource block of given type                      |
| `matches_property?(node, key, value = nil)` | Check if a resource has a property key (and optionally a specific value) |
| `command_in_execute?(node, cmd)`            | Specialized helper for `execute` resources using a specific command      |

---

## 🧰 How to Add a New Helper

1. Add your method in:
   `lib/rubocop/cop/chef/helpers/resource_matcher.rb`

2. Include the module in your Cop:

   ```ruby
   include RuboCop::Cop::Chef::Helpers::ResourceMatcher
   ```

3. Use the method in your Cop logic.

---

## 📌 Summary

Adding the `helpers/` directory is a **long-term improvement** to the Cookstyle codebase that:

* Makes Cop logic reusable.
* Reduces duplication.
* Simplifies maintenance.
* Encourages consistent AST parsing.

This abstraction is already proving helpful in multiple Cops and will scale well as the codebase grows.

---

**Contributed by [Lohith R Gowda](https://github.com/LohithR22)**  
<a href="https://github.com/LohithR22">
  <img src="https://github.com/LohithR22" width="80" style="border-radius: 50%;" alt="lohithgn" />
</a>
