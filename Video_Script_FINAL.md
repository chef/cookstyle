# 🎬 Video Script: "AI-Powered Contribution to Cookstyle"
## Final Production Version | 4 Minutes

---

## PRE-PRODUCTION CHECKLIST
- [ ] VS Code open with files ready
- [ ] Terminal ready with command typed (don't press Enter yet)
- [ ] ChatGPT conversation open in browser
- [ ] Clean desktop, notifications OFF
- [ ] Good lighting on face

---

# 🎤 THE SCRIPT

---

## SECTION 1: Hook & Introduction
**⏱️ 0:00 – 0:45 | 45 seconds**

### 📺 ON-SCREEN TEXT (Lower Third):
```
Suhas Kumar
Security Cop: InsecureCurlWgetDownload
PR #1051 → github.com/chef/cookstyle
```

### 🎬 VISUAL: 
Face on camera, confident posture

### 📝 SCRIPT:

> "Hi, I'm Suhas.
>
> **[PAUSE - 1 second]**
>
> For this assessment, I chose to add a **Security Cop** to Cookstyle.
>
> **[GESTURE: Point to camera]**
>
> Here's the problem I solved:
>
> When developers write Chef cookbooks, they sometimes download files using `curl` or `wget`. And sometimes... they add flags like `-k` or `--insecure` to skip SSL verification.
>
> **[ON-SCREEN: Show the bad code example]**
> ```
> execute 'curl -k https://example.com/install.sh | bash'
> ```
>
> This one flag... opens the door to **Man-in-the-Middle attacks**. An attacker can intercept the download and inject malicious code.
>
> **[PAUSE]**
>
> Cookstyle didn't catch this. So I built a cop that does."

---

## SECTION 2: The AI Workflow
**⏱️ 0:45 – 1:30 | 45 seconds**

### 📺 ON-SCREEN TEXT (Animated Flowchart):
```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   EXPLORE    │ → │  IMPLEMENT   │ → │    REFINE    │ → │    VERIFY    │
│              │    │              │    │              │    │              │
│ Chain-of-    │    │ Constraint-  │    │ Human Code   │    │ RSpec Tests  │
│ Thought      │    │ Based Gen    │    │ Review       │    │ (27 specs)   │
└──────────────┘    └──────────────┘    └──────────────┘    └──────────────┘
```

### 🎬 VISUAL: 
Screen share → ChatGPT conversation

### 📝 SCRIPT:

> "Now, I come from a **Python** background. Ruby was new to me.
>
> So instead of struggling alone, I used **ChatGPT as a pair programmer**.
>
> **[HIGHLIGHT: The prompt on screen]**
>
> My first prompt wasn't *'write me a cop.'* It was:
>
> **[READ FROM SCREEN]**
> *'Explain Cookstyle's architecture like I'm a Python developer who knows Pylint.'*
>
> **[PAUSE]**
>
> This gave me the mental model I needed. Every cop inherits from `RuboCop::Cop::Base`. Every cop analyzes the **Abstract Syntax Tree**.
>
> Once I understood the *why*, generating the *what* became easy."

---

## SECTION 3: The Implementation
**⏱️ 1:30 – 2:30 | 60 seconds**

### 📺 ON-SCREEN TEXT (Code Callouts):
```
PERFORMANCE ────→ RESTRICT_ON_SEND = %i[execute bash sh ...]
                  "Only check shell resources, skip everything else"

ACCURACY ───────→ INSECURE_COMMAND_REGEX = /\b(curl|wget)\b.*\b(-k|--insecure)\b/
                  "\b = word boundary = no false positives"
```

### 🎬 VISUAL: 
VS Code → `insecure_curl_wget_download.rb`

### 📝 SCRIPT:

> "Let me show you the implementation.
>
> **[ZOOM: Line 55-56]**
>
> First, **performance**. See this `RESTRICT_ON_SEND`?
>
> This tells RuboCop: *Only run this cop on shell resources like `execute`, `bash`, or `powershell_script`.*
>
> Without this, the cop would scan **every single line** of code. With this, it's surgical.
>
> **[ZOOM: Line 59]**
>
> Second, **accuracy**. This regex was the hardest part.
>
> **[HIGHLIGHT: \b in the regex]**
>
> The AI's first version would have flagged `check-kernel` as an error because it contains `-k`.
>
> **[PAUSE - let that sink in]**
>
> That's a **false positive**. And false positives make developers ignore linters.
>
> So I added these **word boundaries** — the `\b` — which say: *only match `-k` when it's a standalone flag, not part of another word.*
>
> **[ON-SCREEN: Side-by-side comparison]**
> ```
> ❌ check-kernel    → NOT flagged (correct!)
> ❌ curl -K config  → NOT flagged (uppercase K is different)
> ✅ curl -k url     → FLAGGED (this is the real threat)
> ```
>
> This is where **human judgment** beats pure AI generation."

---

## SECTION 4: The Test Suite
**⏱️ 2:30 – 3:20 | 50 seconds**

### 📺 ON-SCREEN TEXT:
```
TEST COVERAGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ 11 Positive Tests (catches bad code)
✓ 16 Negative Tests (ignores safe code)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: 27 specs | 0 failures
```

### 🎬 VISUAL: 
VS Code → `insecure_curl_wget_download_spec.rb`

### 📝 SCRIPT:

> "Now let's prove it works.
>
> **[SCROLL: Show the test file]**
>
> I wrote **27 test cases**. But the most important ones are the **negative tests**.
>
> **[HIGHLIGHT: A negative test]**
>
> See this? I'm testing that `check-kernel --status` does **NOT** trigger an error.
>
> If my regex was wrong, this test would fail. It doesn't.
>
> **[SWITCH: Terminal]**
>
> Let me run the full suite...
>
> **[TYPE AND ENTER]**
> ```
> bundle exec rspec spec/rubocop/cop/chef/security/insecure_curl_wget_download_spec.rb
> ```
>
> **[WAIT: 3-5 seconds for output]**
>
> **[POINT TO SCREEN]**
>
> **27 examples. Zero failures.** All green.
>
> **[ON-SCREEN: Green checkmark animation]**"

---

## SECTION 5: Conclusion
**⏱️ 3:20 – 4:00 | 40 seconds**

### 📺 ON-SCREEN TEXT (Final Slide):
```
┌─────────────────────────────────────────────────┐
│                                                 │
│   Chef/Security/InsecureCurlWgetDownload        │
│                                                 │
│   ✓ Prevents MITM attacks in Chef cookbooks    │
│   ✓ Zero false positives                       │
│   ✓ 27 passing tests                           │
│   ✓ PR #1051 submitted                         │
│                                                 │
│   github.com/chef/cookstyle/pull/1051          │
│                                                 │
└─────────────────────────────────────────────────┘
```

### 🎬 VISUAL: 
Face on camera

### 📝 SCRIPT:

> "So what did I deliver?
>
> **[COUNT ON FINGERS]**
>
> **One:** A security cop that protects Chef infrastructure from a real vulnerability.
>
> **Two:** A test suite that proves it works with **zero false positives**.
>
> **Three:** Clean, documented code that's ready for production.
>
> **[PAUSE]**
>
> I used AI to learn Ruby faster and generate boilerplate. But the **architecture decisions**, the **edge case handling**, and the **quality bar** — that was me.
>
> **[SMILE]**
>
> The pull request is live. PR number **1051**.
>
> Thank you for watching."

---

# 📋 POST-PRODUCTION NOTES

## Suggested B-Roll / Cutaway Shots
| Timestamp | Cutaway |
|-----------|---------|
| 0:15 | Code snippet of `curl -k` with red highlight |
| 0:35 | Diagram: MITM attack flow |
| 1:00 | ChatGPT interface screenshot |
| 2:00 | Split screen: Bad regex vs Good regex |
| 3:00 | Terminal showing green test output |
| 3:45 | GitHub PR screenshot |

## Key Phrases to EMPHASIZE (speak slower)
- "Man-in-the-Middle attacks"
- "zero false positives"
- "word boundaries"
- "human judgment"
- "27 examples, zero failures"

## Pacing Tips
- **Fast sections:** Technical explanation (keep momentum)
- **Slow sections:** Problem statement, conclusion (let it land)
- **Pause after:** Key revelations ("This is where human judgment beats pure AI")

---

# 🎯 ONE-PAGE CHEAT SHEET (Print This)

```
INTRO (45s)
→ "curl -k opens door to MITM attacks"
→ "Cookstyle didn't catch this. I built a cop that does."

AI WORKFLOW (45s)  
→ "ChatGPT as pair programmer"
→ "Understand the WHY before the WHAT"

IMPLEMENTATION (60s)
→ RESTRICT_ON_SEND = performance
→ \b word boundary = accuracy
→ "Human judgment beats pure AI"

TESTING (50s)
→ 27 tests, 16 are NEGATIVE tests
→ Run specs → All green

CONCLUSION (40s)
→ Security cop, zero false positives, PR #1051
→ "AI for boilerplate, human for quality"
```

---

**Good luck with your recording! 🎬**
