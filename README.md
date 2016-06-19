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

## Examples

The most common place I find these types of wrappers useful is when testing
access privileges on users. Instead of testing each user type independently,
they can all be tested at once with an easy to read and understand syntax

so

```rb
context 'admin' do
  subject(:user) { build(:user, :admin) }

  it { is_expected.to have_property_a }
  ...
end

context 'normie' do
  subject(:user) { build(:user, :admin) }

  it { is_expected.not_to have_property_a }
  ...
end

...

```

can be re-written as
```rb
%i[admin normie super_admin another_type].each do |user_type|
  subject(:user) { build(:user, user_type) }
  let(:is_an_admin) { %i[admin super_admin].include? user_type }
  
  it { is_expected.when(is_an_admin).with_inverse.to have_property_a }
  ...
end
```    

Another common place is when testing page content, again usually user type based.
Can very easily combine otherwise repetitive expectations into single tests  
