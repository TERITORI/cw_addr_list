artifacts/cw_address_list.wasm:
	docker run --rm -v "$(PWD)":/code \
		--mount type=volume,source=cw_address_list_cache,target=/target \
		--mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
		cosmwasm/rust-optimizer:0.14.0

.PHONY: deploy.testnet
deploy.testnet: artifacts/cw_address_list.wasm
	teritorid tx wasm store --from game-minter --chain-id teritori-testnet-v3 --node https://rpc.testnet.teritori.com:443 artifacts/cw_address_list.wasm --gas auto --gas-adjustment 1.3 -y -b block --output json --keyring-backend test