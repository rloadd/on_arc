# Testing ARC


We can run the same tests that the development team has integrated in CI/CD. More precisely, there is a makefile that allows you to build the artifacts of the project, to run the tests and finally to stop everything when the tests are done.

```
git clone https://github.com/bitcoin-sv/arc
cd arc
make clean_restart_e2e_test
```

In case you are only interested on review the result of the tests you can discard the rest of console logs using this sentence instead:

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


