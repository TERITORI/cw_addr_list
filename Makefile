CODE_ID=182
ADMIN=tori1wpkacz32d7lnfk88c73mau6n42tl8cjux8v6ht
CONTRACT_ADDRESS=tori1tecp8nvfwx5mlkkalxes92vkju3qmssg7z2r79n4xg2uwtrkh9gskuzlqt

artifacts/cw_address_list.wasm:
	docker run --rm -v "$(PWD)":/code \
		--mount type=volume,source=cw_address_list_cache,target=/target \
		--mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
		cosmwasm/rust-optimizer:0.14.0

.PHONY: deploy.testnet
deploy.testnet: artifacts/cw_address_list.wasm
	teritorid tx wasm store --from testnet-adm --chain-id teritori-testnet-v3 --node https://rpc.testnet.teritori.com:443 artifacts/cw_address_list.wasm --gas auto --gas-adjustment 1.3 -y -b block --output json --keyring-backend test

.PHONY: instantiate.testnet
instantiate.testnet:
	teritorid tx wasm instantiate --from testnet-adm --chain-id teritori-testnet-v3 --node https://rpc.testnet.teritori.com:443 $(CODE_ID) '{ "admin": "$(ADMIN)" }' --label 'Collections Whitelist' --admin $(ADMIN) --gas auto --gas-adjustment 1.3 -y -b block --output json --keyring-backend test