

# Important

THIS IS NOT OFFICIAL DOCUMENTATION ON THE Bitcoin SV ARC PROJECT. Authoritative documentation can be found at:

  * https://bitcoin-sv.github.io/arc/
  * https://github.com/bitcoin-sv/arc
  * https://www.bsvblockchain.org/features/arc
  

This repo contains tips and suggestions for getting up and running and testing ARC infrastructure while developers are building it. The following recipes build artifacts strictly based on the content of the official https://bitcoin-sv.github.io/arc/ repo isolated in docker containers. PLEASE BE CAREFUL AS THE ARC CODE IS BEING UPDATED IN REAL TIME AND MAY BE IMMATURE IN SOME PARTS.

## What is ARC

ARC is an ambitious cloud-native open source project sponsored by the Bitcoin Association to be the interface with the Bitcoin SV network.

ARC is a large project pursuing an ambitious goal of performance in transactions per second. From a software project point of view, it is based on microservices designed to scale independently, native cloud technologies, performance-enhancing storage and data structures, continuous integration of the code lifecycle, testing and code quality, various dimensions of observability, etc.

From the functionality point of view it is basically a transaction processor that implements a state machine for these transactions, which interacts with the network managing synchronous and asynchronous to achieve the best performance and offer the possibility to simplify third party applications.


## Mission: improve documentation

First, this work starts with understanding ARC itself. For this we have directly read the source code uploaded to github and visited the documentation published in the different websites of the BSV ecosystem. 

Second, the ARC is being deployed right now (December 2023). Some details or dysfunctions might change as they are counted, so some claims or depth of claims need to be filled in slowly.

Finally, this repo is a best effort project. Apologies for any inaccuracies, inconvenience if any misunderstandings occur, and apologies if my update pace is muuuuuch slower. Official sources are listed above.

At https://rloadd.github.io/on_arc/ (github pages of this repo) we are unifying the ARC documentation and expanding some parts that can speed up the understanding for those who want to deploy their own ARC instance. The following sections of this README are a shortcut to running ARC for testing purposes and will eventually be included in the attached github pages as well.


## Testing

Why does the tests appear first ? That's where I would start. Surely to believe that ARC works you have to be able to run it, recognize microservices and see how transactions evolve. By taking the tests provided in the official repo and stitching them together with other ideas we can test it as a toy deployment at home.

### Testing as dev

We can run the same tests the development team has integrated in CI/CD. More precisely, there is a Makefile that allows you to build the artifacts of the project, to run the tests and finally to stop everything when the tests are done.

```
git clone https://github.com/bitcoin-sv/arc
cd arc
make clean_restart_e2e_test

```


In case you are only interested on review the result of the tests you can discard the rest of console logs using this sentence instead:

```
make clean_restart_e2e_test 2>&1 |grep test
``` 

Typically you get something like this:

```
$ make clean_restart_e2e_test 2>&1 |grep test
docker container stop test-tests-1 || true
Error response from daemon: No such container: test-tests-1
docker container stop test-arc-1 || true
Error response from daemon: No such container: test-arc-1
docker container rm test-tests-1 || true
Error response from daemon: No such container: test-tests-1
docker container rm test-arc-1 || true
Error response from daemon: No such container: test-arc-1
docker rmi test-tests || true
Error response from daemon: No such image: test-tests:latest
docker rmi test-arc || true
Error response from daemon: No such image: test-arc:latest
cd ./test && docker-compose down
Stopping test_db_1 ... 
Stopping test_db_1 ... done
Removing test_db_1 ... 
Removing test_db_1 ... done
Removing network test_default
cd ./test && docker-compose up -d node1 node2 node3 db migrate
Creating network "test_default" with the default driver
Creating test_db_1 ... 
Creating test_db_1 ... done
cd ./test && docker-compose up --exit-code-from tests tests arc
test_db_1 is up-to-date
Creating test_arc_1 ... 
Creating test_arc_1 ... done
Creating test_tests_1 ... 
Creating test_tests_1 ... done
Attaching to test_arc_1, test_tests_1
tests_1    | 2023/12/10 12:09:39 WARN: No config file 'settings.conf'
tests_1    | 2023/12/10 12:09:39 WARN: No local config file 'settings_local.conf'
tests_1    | 2023/12/10 12:09:39 current block height: 1614
tests_1    | === RUN   TestBatchChainedTxs
tests_1    | === RUN   TestBatchChainedTxs/submit_batch_of_chained_transactions_-_ext_format
tests_1    |     utils.go:68: new address: mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX
tests_1    |     utils.go:72: new private key: cUXU5XahdZaqnvDKTC559aSDLsuHY31r1HwrQCyafT5xpto625Gf
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     arc_txt_endpoint_test.go:126: generated 100 block(s): block hash: 072c6ecae279a2597f1269f078a33c07c481d8d76c5a8bed6defdf2d3a940aa3
tests_1    |     arc_txt_endpoint_test.go:128: generated address: mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX
tests_1    |     arc_txt_endpoint_test.go:130: sent 0.001000 to mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX: 52c650caa34c06ca26136ef6062cd8cadb8292051f9ac5fa631676f4562fdc08
tests_1    |     arc_txt_endpoint_test.go:132: sent 0.020000 to mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX: bb6e070f883ddc0aa1086f40fe883b07c7db60939b905f4af17cc2529e3090d7
tests_1    |     arc_txt_endpoint_test.go:133: sent 0.02 BSV to: bb6e070f883ddc0aa1086f40fe883b07c7db60939b905f4af17cc2529e3090d7
tests_1    | Amount to generate: 1
tests_1    |     arc_txt_endpoint_test.go:135: generated 1 block(s): block hash: 1348a3de82ab8d6a7b0828543389213607e45b2266f63b9fb5a2eac1e8ca52f6
tests_1    |     arc_txt_endpoint_test.go:136: generated 1 block: 1348a3de82ab8d6a7b0828543389213607e45b2266f63b9fb5a2eac1e8ca52f6
tests_1    | UTXO Txid: 52c650caa34c06ca26136ef6062cd8cadb8292051f9ac5fa631676f4562fdc08, Amount: 0.001000, Address: mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX
tests_1    | UTXO Txid: bb6e070f883ddc0aa1086f40fe883b07c7db60939b905f4af17cc2529e3090d7, Amount: 0.020000, Address: mipcEWt3rESeuKjhz6rMgAV8Ygwa1ygNVX
tests_1    | --- PASS: TestBatchChainedTxs (15.01s)
tests_1    |     --- PASS: TestBatchChainedTxs/submit_batch_of_chained_transactions_-_ext_format (15.01s)
tests_1    | === RUN   TestPostCallbackToken
tests_1    | === RUN   TestPostCallbackToken/post_transaction_with_callback_url_and_token
tests_1    |     utils.go:68: new address: mqtutuZLxw5x68NSHccF6SWLH98U8ampKw
tests_1    |     utils.go:72: new private key: cMocWYxbqSdLiCYNQph6Yj6GvtdPdsiNCZg8qokfZdvTVPHyvBrf
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     arc_txt_endpoint_test.go:256: generated 100 block(s): block hash: 2070ffdea52893da757850438c62c0f9bc8b96dd22b3279ba449c13553453d5e
tests_1    |     arc_txt_endpoint_test.go:258: generated address: mqtutuZLxw5x68NSHccF6SWLH98U8ampKw
tests_1    |     arc_txt_endpoint_test.go:260: sent 0.001000 to mqtutuZLxw5x68NSHccF6SWLH98U8ampKw: 4ca23192a8ca34dcaa22d11cc48092dae5b737f15f38028abedf6f1a1c17667a
tests_1    |     arc_txt_endpoint_test.go:262: sent 0.020000 to mqtutuZLxw5x68NSHccF6SWLH98U8ampKw: 53bad32e940ae5be972e0edcb1d0d7d11796a3f14297eb625ceb7836138b8ad7
tests_1    |     arc_txt_endpoint_test.go:263: sent 0.02 BSV to: 53bad32e940ae5be972e0edcb1d0d7d11796a3f14297eb625ceb7836138b8ad7
tests_1    | Amount to generate: 1
tests_1    |     arc_txt_endpoint_test.go:265: generated 1 block(s): block hash: 686bbb1eeca78b6b93079a65e55a51c14acfb9dc4cab61ad1c5e5ef6244c5f63
tests_1    |     arc_txt_endpoint_test.go:266: generated 1 block: 686bbb1eeca78b6b93079a65e55a51c14acfb9dc4cab61ad1c5e5ef6244c5f63
tests_1    | UTXO Txid: 4ca23192a8ca34dcaa22d11cc48092dae5b737f15f38028abedf6f1a1c17667a, Amount: 0.001000, Address: mqtutuZLxw5x68NSHccF6SWLH98U8ampKw
tests_1    | UTXO Txid: 53bad32e940ae5be972e0edcb1d0d7d11796a3f14297eb625ceb7836138b8ad7, Amount: 0.020000, Address: mqtutuZLxw5x68NSHccF6SWLH98U8ampKw
tests_1    | Amount to generate: 10
tests_1    |     arc_txt_endpoint_test.go:365: starting callback server
tests_1    |     arc_txt_endpoint_test.go:342: callback received, responding bad request
tests_1    |     arc_txt_endpoint_test.go:355: callback received, responding success
tests_1    |     arc_txt_endpoint_test.go:372: generated 10 block(s): block hash: 388c43193458a0709cfd96739a12acb5cf3ffbaccbc9401f32fc478e66ae67f3
tests_1    |     arc_txt_endpoint_test.go:378: callback iteration 0
tests_1    |     arc_txt_endpoint_test.go:378: callback iteration 1
tests_1    |     arc_txt_endpoint_test.go:309: shutting down callback listener
tests_1    | --- PASS: TestPostCallbackToken (19.44s)
tests_1    |     --- PASS: TestPostCallbackToken/post_transaction_with_callback_url_and_token (19.44s)
tests_1    | === RUN   Test_E2E_Success
tests_1    |     utils.go:68: new address: mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD
tests_1    |     utils.go:72: new private key: cSSQtj6J4FqJPckhMctaTG77t698bCe6pd2ecsKJuZwBF7wHuTmD
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     arc_txt_endpoint_test.go:523: generated 100 block(s): block hash: 3281cfabc64ae6b1477262c2d9c3c1f7094ea4a3a3d65c5748422e25b92fe642
tests_1    |     arc_txt_endpoint_test.go:524: generated address: mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD
tests_1    |     arc_txt_endpoint_test.go:526: sent 0.001000 to mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD: 2bde0c29a8d27dc862efea1322134d778b02be6bef5b5e35fdf9d0065cb7fabb
tests_1    |     arc_txt_endpoint_test.go:528: sent 0.020000 to mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD: f79d97d8de6f81ab6490d9164b6f3fb01766f9965c6b0d1cb04894438d13f224
tests_1    |     arc_txt_endpoint_test.go:529: sent 0.02 BSV to: f79d97d8de6f81ab6490d9164b6f3fb01766f9965c6b0d1cb04894438d13f224
tests_1    | Amount to generate: 1
tests_1    |     arc_txt_endpoint_test.go:531: generated 1 block(s): block hash: 593c0b6492e66bc53dd843d755b2b7d49d44d786a93bad37cffdf1c9dc63954d
tests_1    |     arc_txt_endpoint_test.go:532: generated 1 block: 593c0b6492e66bc53dd843d755b2b7d49d44d786a93bad37cffdf1c9dc63954d
tests_1    | UTXO Txid: f79d97d8de6f81ab6490d9164b6f3fb01766f9965c6b0d1cb04894438d13f224, Amount: 0.020000, Address: mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD
tests_1    | UTXO Txid: 2bde0c29a8d27dc862efea1322134d778b02be6bef5b5e35fdf9d0065cb7fabb, Amount: 0.001000, Address: mkoFrAqxSM8r4yXbiefBa7QBQySseMfPfD
tests_1    | Transaction status: SEEN_ON_NETWORK
tests_1    | Amount to generate: 10
tests_1    |     arc_txt_endpoint_test.go:451: generated 10 block(s): block hash: 7b971fd345db3e119aa5a1d74f72f380918fad941f8c93b014eb2b1e0e45411d
tests_1    | Transaction status: MINED
tests_1    | --- PASS: Test_E2E_Success (39.26s)
tests_1    | === RUN   TestPostTx_Success
tests_1    |     utils.go:68: new address: mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U
tests_1    |     utils.go:72: new private key: cRLyWZzxwc6Phok4PTSYXLTarNgXYQEcZyKw5zbazxJD47iLm7vt
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     arc_txt_endpoint_test.go:523: generated 100 block(s): block hash: 4243a7a4e12c8c0708d50199fab3a208d89023e533d8c069893bab1be17138cc
tests_1    |     arc_txt_endpoint_test.go:524: generated address: mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U
tests_1    |     arc_txt_endpoint_test.go:526: sent 0.001000 to mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U: 11ccc4cd03c8ed713600a73a6489e73ee7a12d440b2b8be5cd574d8ecca4b594
tests_1    |     arc_txt_endpoint_test.go:528: sent 0.020000 to mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U: 5b877c7e7eeced0bb96d7769f50bc56ea3003a3bddc1b36b0f32467b82729af6
tests_1    |     arc_txt_endpoint_test.go:529: sent 0.02 BSV to: 5b877c7e7eeced0bb96d7769f50bc56ea3003a3bddc1b36b0f32467b82729af6
tests_1    | Amount to generate: 1
tests_1    |     arc_txt_endpoint_test.go:531: generated 1 block(s): block hash: 52f602b7642b47f4f19d68b3b8a389cfc3140ee42713e5eaffba47cd25c1fafd
tests_1    |     arc_txt_endpoint_test.go:532: generated 1 block: 52f602b7642b47f4f19d68b3b8a389cfc3140ee42713e5eaffba47cd25c1fafd
tests_1    | UTXO Txid: 11ccc4cd03c8ed713600a73a6489e73ee7a12d440b2b8be5cd574d8ecca4b594, Amount: 0.001000, Address: mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U
tests_1    | UTXO Txid: 5b877c7e7eeced0bb96d7769f50bc56ea3003a3bddc1b36b0f32467b82729af6, Amount: 0.020000, Address: mp1StWpmE8deTz6qgpDFkpHgcTokYjGn7U
tests_1    | --- PASS: TestPostTx_Success (13.21s)
tests_1    | === RUN   TestPostTx_BadRequest
tests_1    | --- PASS: TestPostTx_BadRequest (0.00s)
tests_1    | === RUN   TestPostTx_MalformedTransaction
tests_1    | --- PASS: TestPostTx_MalformedTransaction (0.00s)
tests_1    | === RUN   TestPostTx_BadRequestBodyFormat
tests_1    | --- PASS: TestPostTx_BadRequestBodyFormat (0.00s)
tests_1    | === RUN   TestMerklePath
tests_1    | === RUN   TestMerklePath/post_transaction_-_check_returned_Merkle_path
tests_1    |     utils.go:68: new address: n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN
tests_1    |     utils.go:72: new private key: cSZ4GrYsMDiu3Ka8RycwfC7o5pBFr7f2MuUNRgVkHbxXiPmYzzbJ
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     arc_txt_endpoint_test.go:571: generated 100 block(s): block hash: 2e98ef3874075f78e2c056077045ad685329f25870109b2f6b15fadbf45815cd
tests_1    |     arc_txt_endpoint_test.go:573: generated address: n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN
tests_1    |     arc_txt_endpoint_test.go:575: sent 0.001000 to n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN: d9da23ecfc4824648b91afc1b7383b94517431406eca033aaf196eabbe6c07de
tests_1    |     arc_txt_endpoint_test.go:577: sent 0.020000 to n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN: ccff6ac191f2969ba1f933495901937a23709ab691e6855a22dde3d5616a73b0
tests_1    |     arc_txt_endpoint_test.go:578: sent 0.02 BSV to: ccff6ac191f2969ba1f933495901937a23709ab691e6855a22dde3d5616a73b0
tests_1    | Amount to generate: 1
tests_1    |     arc_txt_endpoint_test.go:580: generated 1 block(s): block hash: 7a065143fdfa492ff0a5db0ff36e6629d5b6c3d4713936da87e79e992304863e
tests_1    |     arc_txt_endpoint_test.go:581: generated 1 block: 7a065143fdfa492ff0a5db0ff36e6629d5b6c3d4713936da87e79e992304863e
tests_1    | UTXO Txid: ccff6ac191f2969ba1f933495901937a23709ab691e6855a22dde3d5616a73b0, Amount: 0.020000, Address: n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN
tests_1    | UTXO Txid: d9da23ecfc4824648b91afc1b7383b94517431406eca033aaf196eabbe6c07de, Amount: 0.001000, Address: n2n2CWBiBvGytYW5DPkSjVXPqNf45f2ueN
tests_1    | Amount to generate: 10
tests_1    |     arc_txt_endpoint_test.go:612: generated 10 block(s): block hash: 653cf56c6efc5712a219e7600bf35f43f9452f57060aa8b3cee1b150da2c500c
tests_1    |     arc_txt_endpoint_test.go:621: BUMP: fd5c0801020000d996f6da79dbf0588251428a1a3bb137565514c5a17c801ff5011e906d3d8f8b0102b5daee0b4f26594d129ce1c80d2044b6ee925bec14677019be01b792b8bc44f7
tests_1    |     arc_txt_endpoint_test.go:628: BUMPjson: {"blockHeight":2140,"path":[[{"offset":0,"hash":"8b8f3d6d901e01f51f807ca1c514555637b13b1a8a42518258f0db79daf696d9"},{"offset":1,"hash":"f744bcb892b701be19706714ec5b92eeb644200dc8e19c124d59264f0beedab5","txid":true}]]}
tests_1    | --- PASS: TestMerklePath (20.09s)
tests_1    |     --- PASS: TestMerklePath/post_transaction_-_check_returned_Merkle_path (20.09s)
tests_1    | === RUN   TestDoubleSpend
tests_1    | === RUN   TestDoubleSpend/submit_tx_with_a_double_spend_tx_before_and_after_tx_got_mined_-_std_format
tests_1    |     utils.go:68: new address: n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4
tests_1    |     utils.go:72: new private key: cP3rTgnWVUqmSBiZspodyMkw7WYNZCecmp79UhvC47n2sVMpGhXG
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     double_spend_test.go:34: generated 100 block(s): block hash: 7ba3d8178a31672da6f1e70d4de2f0acd161d476119bc0618db89e281b9d74be
tests_1    |     double_spend_test.go:36: generated address: n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4
tests_1    |     double_spend_test.go:38: sent 0.001000 to n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4: b8f92e3b8d832159f3baff28fb6e597cae681fa1a6ed54ee9a33f0e173ec5383
tests_1    |     double_spend_test.go:40: sent 0.020000 to n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4: 3fd4d5a825186524f38cd68b1eae4ee44c16e660200b19bece23b6ada4051047
tests_1    |     double_spend_test.go:41: sent 0.02 BSV to: 3fd4d5a825186524f38cd68b1eae4ee44c16e660200b19bece23b6ada4051047
tests_1    | Amount to generate: 1
tests_1    |     double_spend_test.go:43: generated 1 block(s): block hash: 7e2a6d413818b05b1573d74de866b14238a3403aac513918e47a6d4e3ca2f8d8
tests_1    |     double_spend_test.go:44: generated 1 block: 7e2a6d413818b05b1573d74de866b14238a3403aac513918e47a6d4e3ca2f8d8
tests_1    | UTXO Txid: 3fd4d5a825186524f38cd68b1eae4ee44c16e660200b19bece23b6ada4051047, Amount: 0.020000, Address: n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4
tests_1    | UTXO Txid: b8f92e3b8d832159f3baff28fb6e597cae681fa1a6ed54ee9a33f0e173ec5383, Amount: 0.001000, Address: n3Sff47GU7Ed6yZviv1FeJ5upXTUZZYTP4
tests_1    | Amount to generate: 10
tests_1    |     double_spend_test.go:68: generated 10 block(s): block hash: 4ced9205c61dcffec2ed662b9fbc509bff32c671d8b5e945abdddf8a63d2d99b
tests_1    | === RUN   TestDoubleSpend/submit_tx_with_a_double_spend_tx_before_and_after_tx_got_mined_-_ext_format
tests_1    |     utils.go:68: new address: mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H
tests_1    |     utils.go:72: new private key: cRdwCNbqPxN93yndPFKU3wSwrXbwSJQcCTJ49gcLyrTMXh4RHHrp
tests_1    |     utils.go:78: account test-account created
tests_1    | Amount to generate: 100
tests_1    |     double_spend_test.go:34: generated 100 block(s): block hash: 2d56a0b0c79079d4c4d54021eee0ede7e12f276494110f9d39fe04b324f46675
tests_1    |     double_spend_test.go:36: generated address: mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H
tests_1    |     double_spend_test.go:38: sent 0.001000 to mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H: 1a507c4b1d227c92414b668c117ae07f3954dd8cda408b8cab08ac9972b6a990
tests_1    |     double_spend_test.go:40: sent 0.020000 to mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H: 4e6973ad77d089bcc2b91974101700520d233ce9d50706f7d0984686aa951142
tests_1    |     double_spend_test.go:41: sent 0.02 BSV to: 4e6973ad77d089bcc2b91974101700520d233ce9d50706f7d0984686aa951142
tests_1    | Amount to generate: 1
tests_1    |     double_spend_test.go:43: generated 1 block(s): block hash: 7d251b6143a1b56af32e17b5d07cfd732711b4ed5d5671d52251b0defc2ac2c5
tests_1    |     double_spend_test.go:44: generated 1 block: 7d251b6143a1b56af32e17b5d07cfd732711b4ed5d5671d52251b0defc2ac2c5
tests_1    | UTXO Txid: 4e6973ad77d089bcc2b91974101700520d233ce9d50706f7d0984686aa951142, Amount: 0.020000, Address: mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H
tests_1    | UTXO Txid: 1a507c4b1d227c92414b668c117ae07f3954dd8cda408b8cab08ac9972b6a990, Amount: 0.001000, Address: mp3gLUMRdTWk6CGSiu2bbSWxjT7zVygJ3H
tests_1    | Amount to generate: 10
tests_1    |     double_spend_test.go:68: generated 10 block(s): block hash: 7c517956ed59bcc1e99f8178780e1e6f649454569fe33645ac9c1e538d4f88b8
tests_1    | --- PASS: TestDoubleSpend (50.66s)
tests_1    |     --- PASS: TestDoubleSpend/submit_tx_with_a_double_spend_tx_before_and_after_tx_got_mined_-_std_format (25.19s)
tests_1    |     --- PASS: TestDoubleSpend/submit_tx_with_a_double_spend_tx_before_and_after_tx_got_mined_-_ext_format (25.47s)
tests_1    | PASS
tests_1    | ok         e2e_tests       157.714s
test_tests_1 exited with code 0
Stopping test_arc_1   ... 
Stopping test_arc_1   ... done
cd ./test && docker-compose down
Stopping test_db_1 ... 
Stopping test_db_1 ... done
Removing test_tests_1 ... 
Removing test_arc_1   ... 
Removing test_db_1    ... 
Removing test_arc_1   ... done
Removing test_db_1    ... done
Removing test_tests_1 ... done
Removing network test_default

```


### Custom tests, official source code

We may be interested in running a persistent ARC deployment to play with a different set of operations. Using then the main tests (presented above) as a base, we can try other ways to test ARC.

Throughout this section docker images are built by cloning the repo, compiling and staging. Nothing has to be cloned, installed or compiled separately, except, obviously, the Docker environment and tools. To simplify the operation we are going to use only docker desktop os support, but the same can be done with any flavor of kubernetes.

This repo provides a config.yaml and some other configuration files aligned with the provided docker-compose files.

#### Simplest infrastructure

Each service in its own separated container. Just one container by service.

```
git clone https://github.com/rloadd/on_arc #this repo
cd on_arc/deployments/monolithic
make startup
```

Containers lifted:

```
$ docker ps
CONTAINER ID   IMAGE                         COMMAND                  CREATED          STATUS                    PORTS                                                                                               NAMES
ee1e00cc4bde   arc-image:latest              "/service/arc -callb…"   21 minutes ago   Up 20 minutes             0.0.0.0:8021->8021/tcp, :::8021->8021/tcp                                                           arc-callbacker
2edf9e4c16a5   arc-image:latest              "/service/arc -metam…"   21 minutes ago   Up 20 minutes             0.0.0.0:8001->8001/tcp, :::8001->8001/tcp                                                           lb-metamorph
9fe22388f393   arc-image:latest              "/service/arc -block…"   2 hours ago      Up 20 minutes             0.0.0.0:8011->8011/tcp, :::8011->8011/tcp                                                           arc-blocktx
91fabc670b7b   arc-image                     "/service/arc -api=t…"   2 hours ago      Up 20 minutes             0.0.0.0:9090->9090/tcp, :::9090->9090/tcp                                                           arc
8280e1622824   postgres:14                   "docker-entrypoint.s…"   2 hours ago      Up 20 minutes (healthy)   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                                           arc-db
e256290541f4   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:48332->18332/tcp, :::48332->18332/tcp              arc-node2
e6ad47689ad8   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:58332->18332/tcp, :::58332->18332/tcp              arc-node3
e2e9e4e1ec42   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   2 hours ago      Up 20 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 28332/tcp, 0.0.0.0:18332->18332/tcp, :::18332->18332/tcp   arc-node1

```

Afterwards, unnecessary artifacts can be eliminated performing a "clean":

```
make clean  #clean_full is harder
```


#### Balanced microservices

A little hack with docker-compose let us to run multiple instances of API and Metamorph services. Nginx do the magic.

```
make startup-replica

```

Several containers are launched for some services.

```
$ docker ps
CONTAINER ID   IMAGE                         COMMAND                  CREATED          STATUS                   PORTS                                                                                               NAMES
3a3fbc59ca59   nginx:stable-alpine           "/docker-entrypoint.…"   5 minutes ago    Up 5 minutes             0.0.0.0:8001->80/tcp, :::8001->80/tcp                                                               lb_metamorph
1f391ffa12c3   arc:latest                    "/service/arc -callb…"   5 minutes ago    Up 5 minutes             0.0.0.0:8021->8021/tcp, :::8021->8021/tcp                                                           arc_callbacker
2dbe896f8c06   nginx:stable-alpine           "/docker-entrypoint.…"   5 minutes ago    Up 5 minutes             80/tcp, 0.0.0.0:9090->9090/tcp, :::9090->9090/tcp                                                   arc
24ff4aefc876   arc:latest                    "/service/arc -metam…"   5 minutes ago    Up 5 minutes             0.0.0.0:32862->8001/tcp, :::32862->8001/tcp                                                         decoupled_metamorph_3
1d0b15bf9ea4   arc:latest                    "/service/arc -metam…"   5 minutes ago    Up 5 minutes             0.0.0.0:32863->8001/tcp, :::32863->8001/tcp                                                         decoupled_metamorph_2
c414bec88ca5   arc:latest                    "/service/arc -metam…"   5 minutes ago    Up 5 minutes             0.0.0.0:32861->8001/tcp, :::32861->8001/tcp                                                         decoupled_metamorph_1
775b97354904   arc                           "/service/arc -api=t…"   5 minutes ago    Up 5 minutes             0.0.0.0:32859->9090/tcp, :::32859->9090/tcp                                                         decoupled_api_1
13e2f37deba2   arc                           "/service/arc -api=t…"   5 minutes ago    Up 5 minutes             0.0.0.0:32860->9090/tcp, :::32860->9090/tcp                                                         decoupled_api_2
9019543c6136   arc:latest                    "/service/arc -block…"   5 minutes ago    Up 5 minutes             0.0.0.0:8011->8011/tcp, :::8011->8011/tcp                                                           arc_blocktx
9ff06d5bf14c   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   5 minutes ago    Up 5 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:58332->18332/tcp, :::58332->18332/tcp              arc_node3
de8ba9490b7d   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   5 minutes ago    Up 5 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 0.0.0.0:48332->18332/tcp, :::48332->18332/tcp              arc_node2
45d25dff8c1a   bitcoinsv/bitcoin-sv:1.0.15   "/entrypoint.sh /ent…"   5 minutes ago    Up 5 minutes (healthy)   8332-8333/tcp, 9332-9333/tcp, 18333/tcp, 28332/tcp, 0.0.0.0:18332->18332/tcp, :::18332->18332/tcp   arc_node1
bffa1a9711cd   postgres:14                   "docker-entrypoint.s…"   5 minutes ago    Up 5 minutes (healthy)   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                                           arc_db

```



The results of testing are:

```
$ docker logs arc_tests
2023/12/11 18:55:41 WARN: No config file 'settings.conf'
2023/12/11 18:55:41 WARN: No local config file 'settings_local.conf'
2023/12/11 18:55:41 current block height: 2029
=== RUN   TestBatchChainedTxs
=== RUN   TestBatchChainedTxs/submit_batch_of_chained_transactions_-_ext_format
    utils.go:68: new address: mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg
    utils.go:72: new private key: cPsUeETGVZ8vCJrD6FM1kWj6pKX9PLkFDyxwVvuitPqxVH84JGbM
    utils.go:78: account test-account created
Amount to generate: 100
    arc_txt_endpoint_test.go:126: generated 100 block(s): block hash: 626c112996af28bedbbf2bacf5969467a0f5f511a3579cde06b9d66e48ba56d9
    arc_txt_endpoint_test.go:128: generated address: mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg
    arc_txt_endpoint_test.go:130: sent 0.001000 to mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg: d5b242acaf647d5dbbd57646d2ac29227925741354bdfdbca850e4083e33e6c4
    arc_txt_endpoint_test.go:132: sent 0.020000 to mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg: 3b33945d3bfa2490332e4f90a57abfb6b33662d201d3634c138b57d668649530
    arc_txt_endpoint_test.go:133: sent 0.02 BSV to: 3b33945d3bfa2490332e4f90a57abfb6b33662d201d3634c138b57d668649530
Amount to generate: 1
    arc_txt_endpoint_test.go:135: generated 1 block(s): block hash: 442eda0b638af4053bd7eee88f21c0993766c0521e5bb189a8110725be0c01a0
    arc_txt_endpoint_test.go:136: generated 1 block: 442eda0b638af4053bd7eee88f21c0993766c0521e5bb189a8110725be0c01a0
UTXO Txid: 3b33945d3bfa2490332e4f90a57abfb6b33662d201d3634c138b57d668649530, Amount: 0.020000, Address: mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg
UTXO Txid: d5b242acaf647d5dbbd57646d2ac29227925741354bdfdbca850e4083e33e6c4, Amount: 0.001000, Address: mwXSfxuAH1Y7dvV1QRJ9niyzE25rnCzjTg
--- PASS: TestBatchChainedTxs (14.71s)
    --- PASS: TestBatchChainedTxs/submit_batch_of_chained_transactions_-_ext_format (14.71s)
=== RUN   TestPostCallbackToken
=== RUN   TestPostCallbackToken/post_transaction_with_callback_url_and_token
    utils.go:68: new address: miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8
    utils.go:72: new private key: cQqXsbDTwVDpxQvRXWkDZF3dX8Pg4gETtkAgJFCQ3YMqk8zZrcfi
    utils.go:78: account test-account created
Amount to generate: 100
    arc_txt_endpoint_test.go:256: generated 100 block(s): block hash: 068b47be4a4da072bba02b01f9a706355b3fa14903f8ed50ea08e4263d4fe8c6
    arc_txt_endpoint_test.go:258: generated address: miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8
    arc_txt_endpoint_test.go:260: sent 0.001000 to miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8: ebcaf452a737251bcf7aec2373d320a8766332d1192527665af8f12b9642b8cf
    arc_txt_endpoint_test.go:262: sent 0.020000 to miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8: 40910e3a5c8cfa1e41ca165abedbffdd8fac49333099212e853b0f09cf4eb10b
    arc_txt_endpoint_test.go:263: sent 0.02 BSV to: 40910e3a5c8cfa1e41ca165abedbffdd8fac49333099212e853b0f09cf4eb10b
Amount to generate: 1
    arc_txt_endpoint_test.go:265: generated 1 block(s): block hash: 0baf7aeae30c31a438d76e4c878e6ad52c23a3446c31d2cacd07f7a93076f885
    arc_txt_endpoint_test.go:266: generated 1 block: 0baf7aeae30c31a438d76e4c878e6ad52c23a3446c31d2cacd07f7a93076f885
UTXO Txid: 40910e3a5c8cfa1e41ca165abedbffdd8fac49333099212e853b0f09cf4eb10b, Amount: 0.020000, Address: miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8
UTXO Txid: ebcaf452a737251bcf7aec2373d320a8766332d1192527665af8f12b9642b8cf, Amount: 0.001000, Address: miXbV3w4qRPaXn1sAb2oskJRyXa4ezBYe8
Amount to generate: 10
    arc_txt_endpoint_test.go:365: starting callback server
    arc_txt_endpoint_test.go:372: generated 10 block(s): block hash: 6cf301552e7456f68c68e003f28a91e40347efb278d96d3dbdc57a048b7cc626
    arc_txt_endpoint_test.go:378: callback iteration 0
    arc_txt_endpoint_test.go:392: callback not received
    arc_txt_endpoint_test.go:309: shutting down callback listener
--- FAIL: TestPostCallbackToken (34.98s)
    --- FAIL: TestPostCallbackToken/post_transaction_with_callback_url_and_token (34.98s)
FAIL
FAIL    e2e_tests       49.738s
FAIL

```

Using this deployment, it fails receiving the callback. Work in progress.



### Batching transactions

It is possible to perform batch transactions to test the deployment. The "cmd" utilities are useful for doing speficic and isolated operations with ARC. In this case we can use "broadcaster" to order transactions through ARC.

NOTE: You have to clone the github repo and put your own config.yml in the root of your copy to get the broadcaster working properly.


```
go run cmd/broadcaster/main.go -api=true -consolidate -authorization=mainnet_XXX -batch=100 1000

```


NOTE2: broadcaster in "cmd" fashion doesn't support any option "-config". I've done by my own to launch the same more confortable (hopefully it can be added to the official repo):

```
go run cmd/broadcaster/main.go -config=../arc_cover/decoupled/ -api=true -consolidate -authorization=mainnet_XXX -batch=100 1000

```


## Digging into database data

We can open a console directly to the container to do the full reseach:

```
$ docker exec -it arc-db bash
```

Connection to the data base

```
# psql -h localhost -U arcuser blocktx
```

List of tables
```
blocktx-# \dt
 public | block_transactions_map | table | arcuser
 public | blocks                 | table | arcuser
 public | primary_blocktx        | table | arcuser
 public | schema_migrations      | table | arcuser
 public | transactions           | table | arcuser
```

We can show the schema for the table "transactions"
```
blocktx=# \d transactions
 id          | bigint                   |           | not null | nextval('transactions_id_seq'::regclass)
 hash        | bytea                    |           | not null | 
 source      | text                     |           |          | 
 merkle_path | text                     |           |          | ''::text
 inserted_at | timestamp with time zone |           | not null | CURRENT_TIMESTAMP
```

Querying data from the table
```
blocktx=# SELECT  * from transactions limit 10;
```

Storage used by this table
```
blocktx=# \dt+ transactions
 public | transactions | table | arcuser | permanent   | heap          | 2192 kB |
```



# Querying bitcoin nodes


```
curl --user 'bitcoin:bitcoin'   \
    --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' \
    -H 'content-type:text/plain;' \
    http://127.0.0.1:18332

```