# Module 2 – Activity 2 – Sum and Average (Dart)

Practice loops by reading several numbers and summarising them.

## What to do

### 1. Fill in your details

Open `student.json` and fill in every field (use the **class code** your
instructor gave you):

```json
{
  "classCode": "1234",
  "fullName": "Juan Dela Cruz",
  "studentNumber": "2026-12345",
  "studentEmail": "juan.delacruz@hau.edu.ph",
  "personalEmail": "juan@example.com",
  "githubAccount": "juandelacruz"
}
```

> **Keep `student.json` identical across all your activities.** The autograder
> cross-checks these fields between your repos, and a mismatch (e.g. a different
> `classCode` in one activity) is flagged. The `classCode` must also match the
> one in your repo name.

### 2. Write the program

Open [`bin/numbers.dart`](bin/numbers.dart). The program must:

1. Read **10 numbers** from the user, one at a time.
2. Compute the **sum** of all 10 numbers.
3. Compute the **average** (the sum divided by 10).
4. Display both the **sum** and the **average**.

Run it yourself:

```bash
dart run bin/numbers.dart
```

Example: entering `1` through `10` should give a sum of `55` and an
average of `5.5`.

## Set up your repo

Before you write any code, create **your own copy** of this activity from the
template. Do not work in the template itself.

1. **Create from the template.** Open the template repo and click
   **Use this template → Create a new repository**.
2. **Set the owner to the course org.** Under *Owner*, choose the **`HAU-6ADET`
   course org**, **not** your personal account.
3. **Name it by the convention** `m<module>a<activity>-<classcode>-<yourname>`.
   For this activity that's **`m2a2-<classcode>-yourname`** (e.g.
   `m2a2-1234-juandelacruz`). The `<classcode>` must match the one you put in
   `student.json`.
4. **Make it Private.** Set *Visibility* to **Private** so classmates can't see
   your work.

Then clone **your** new repo and work there:

```bash
git clone https://github.com/HAU-6ADET/m2a2-<classcode>-yourname.git
cd m2a2-<classcode>-yourname
```

## Running the test

```bash
dart pub get
dart test
```

This activity is graded by **5 tests** (1 point each). They check:

- ✅ `student.json` is completely filled in (1 test)
- ✅ the sum and the average are correct for two different sets of 10 numbers
  (4 tests)

Each part is graded independently, so you earn partial credit for the parts
you finish.

## Confirm your submission

Your repo **is** your submission, so there is nothing to upload anywhere. When the
test passes locally, **commit and push** so your work is recorded:

```bash
git add -A
git commit -m "Activity 2 complete"
git push
```

Pushing triggers the **Autograde** workflow. Confirm your submission landed:

1. Open your repo on GitHub and click the **Actions** tab.
2. Open the latest **Autograde** run and confirm the green ✅ check
   and the "5 / 5 tests passed" summary.
