1. Step::Precommit happens if self.has_enough_aligned_votes(message) && message.block_hash.is_some() [here](https://github.com/paritytech/parity/blob/master/ethcore/src/engines/tendermint/mod.rs#L409)
2. The generated message is passed as a proposal?
```text
(gdb) frame 12
#12 0x000055a10af4a842 in <ethcore::engines::tendermint::Tendermint as ethcore::engines::Engine<ethcore::machine::EthereumMachine>>::extra_info (
    self=0x7fdeaa5ecd10, header=0x7fde9c5ed178) at ethcore/src/engines/tendermint/mod.rs:454
454                     let message = ConsensusMessage::new_proposal(header).expect("Invalid header.");
(gdb) print header.seal
  seal = Vec<alloc::vec::Vec<u8>>(len: 3, cap: 3) = {Vec<u8>(len: 1, cap: 1) = {5}, Vec<u8>(len: 1, cap: 1) = {128}, Vec<u8>(len: 136, cap: 136) = {
      248, 134, 184, 65, 194, 113, 195, 207, 75, 15, 75, 221, 162, 185, 39, 205, 25, 158, 49, 84, 27, 18, 155, 129, 29, 241, 87, 163, 96, 233, 244,
      186, 0, 224, 165, 253, 14, 230, 78, 177, 91, 103, 220, 229, 79, 236, 250, 194, 83, 137, 120, 216, 160, 161, 178, 154, 207, 79, 103, 190, 17,
      203, 198, 47, 124, 66, 175, 219, 1, 184, 65, 129, 213, 128, 149, 4, 67, 132, 66, 74, 214, 181, 31, 186, 111, 31, 29, 187, 48, 58, 80, 184, 204,
      104, 79, 223, 170, 68, 250, 207, 47, 6, 183, 113, 32, 139, 124, 226, 132, 143, 254, 194, 14, 49, 122, 33, 209, 133, 114, 92, 188, 160, 113,
      195, 47, 229, 25, 42, 37, 116, 82, 58, 171, 121, 163, 1}},
```
3. proposal_signature(header) panics with 'Invalid header.: RlpIsTooShort' (expected H520, found header.seal[1] == 0x80)
4. So, either the generated message shouldn't be treated as a proposal, or the signature field was set incorrectly (RLP_NULL).
5. Looks like the former is true (cf. https://github.com/paritytech/parity/blob/master/ethcore/src/engines/tendermint/mod.rs#L704)
6. Why does extra_info [impl](https://github.com/paritytech/parity/blob/master/ethcore/src/engines/tendermint/mod.rs#L453) for Tendermint assumes that the message is a proposal?

Relevant PR: https://github.com/paritytech/parity/pull/5415

Tenderming spec: http://tendermint.readthedocs.io/en/master/specification/byzantine-consensus-algorithm.html#state-machine-overview

Proposed fix: https://github.com/paritytech/parity/pull/8367
