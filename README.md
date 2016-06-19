# RSpec when syntax

RSpec::When lets you describe both optional expectations and expectations
with inverses. This helps DRY up otherwise complicated or repetitive tests.

## Installation

```sh
$ gem install rspec-when
```

## Usage

#### Plain `when` syntax

```rb
expect(user).when(an_admin).to have_all_access
```

Provides syntactic sugar for

```rb
if an_admin
  expect(user).to have_all_access
end
```

#### Compound `when.with_inverse` syntax

```rb
expect(user).when(an_admin).with_inverse.to have_all_access
```

Provides syntactic sugar for

```rb
if an_admin
  expect(user).to have_all_access
else
  expect(user).not_to have_all_access
end
```

Typical usage is when abstracting common expectations into a helper method to
DRY up tests where testing the inverse expectation is also required.
