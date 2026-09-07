# agenix recipient map. Consumed only by the `agenix` CLI (`just secret-edit`),
# never by the nix build. Encrypted blobs live next to this file as *.age.
let
  # Shared age recipient. Generate once, back it up (iCloud Drive / AirDrop),
  # then replace the placeholder below:
  #   mkdir -p ~/.config/agenix
  #   age-keygen -o ~/.config/agenix/key.txt
  #   age-keygen -y ~/.config/agenix/key.txt   # prints the age1... line
  shared = "age1PLACEHOLDER0000000000000000000000000000000000000000000000000";
in
{
  "git-local.age".publicKeys = [ shared ];
  "git-work.age".publicKeys = [ shared ];
}
