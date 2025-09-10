# chef/performance Cops

This directory contains cops focused on identifying inefficient patterns in Chef Infra cookbooks that impact **CPU**, **memory usage**, or **I/O performance**. These cops aim to guide developers toward more performant resource usage, especially in environments with scale, concurrency, or strict runtime constraints.

---

## Purpose of the `Performance` Cops

Chef recipes often run on resource-constrained nodes and may be applied across large fleets. Inefficient patterns — like creating many resources in loops or loading large amounts of data from disk or network — can result in slower runs, higher memory consumption, and degraded scalability. The `Chef/Performance` cops are designed to detect such anti-patterns and guide users toward more optimal constructs.

### Benefits:

- Reduces memory footprint and CPU cycles by avoiding repeated or unnecessary operations.
- Encourages bulk/batched resource use where possible.
- Prevents I/O bottlenecks caused by loading large or undefined datasets.
- Promotes cleaner, more maintainable code by using more expressive and performant patterns.

---

## Implemented Cops

### `Chef/Performance/RepeatedResourcesInLoops`

**Cop Name**: `Chef/Performance/RepeatedResourcesInLoops`

**Description**:  
Detects repeated creation of resources within loops, such as calling `package` or `user` within an `each` block. Many Chef resources support array-based declarations, allowing multiple resources to be declared in one go, which is significantly more efficient than creating them iteratively.

**Example:**

```ruby
# bad
%w(foo bar baz).each do |pkg|
  package pkg
end

# good
package %w(foo bar baz)


**Resources Checked**:
This cop currently checks the following batchable resources:

* `package`
* `user`
* `service`
* `group`

These can be easily expanded in the future based on more Chef resources that support batch operations.

---

### `Chef/Performance/LoadAllDataBagItems`

**Cop Name**: `Chef/Performance/LoadAllDataBagItems`

**Description**:
Warns against the use of broad data bag searches (e.g., wildcard or empty queries) which lead to excessive memory and disk/network I/O. Searching all items in a bag (`search(:bag, '*:*')`) may inadvertently fetch hundreds of items and load them all into memory, which is highly inefficient.

**Example:**

```ruby
# bad
search(:users, '*:*')
search(:users, '')

# good
search(:users, 'id:admin')
```

**Detection Logic**:
Checks the second or third argument of `search` and `data_bag_search` calls. If the query string is empty or set to a wildcard (`'*:*'`), it flags it as a performance issue.

---

## Contribution & Future Cops

More performance-focused cops can be added under this directory to detect:

* Redundant conversions or object allocations
* Use of `lazy` evaluation where it's not needed
* Repeated use of expensive shell-outs in loops
* Inefficient string interpolations or regex use

Each cop added should be backed by a rationale rooted in measurable runtime or memory improvements.

---

**Maintainers Note**:
All cops in this directory are intended to remain **autocorrect-safe** when possible and to avoid false positives on dynamic logic. Test coverage should reflect edge cases typical in large-scale Chef cookbooks.

---

**Contributed by [Lohith R Gowda](https://github.com/LohithR22)**  
<a href="https://github.com/LohithR22">
  <img src="https://github.com/LohithR22" width="80" style="border-radius: 50%;" alt="lohithgn" />
</a>
