Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C87B2987
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjI2AZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2AZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:25:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988E2180;
        Thu, 28 Sep 2023 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695947142;
        bh=xmH8CTpew0v4LZutsweiJ6XiF6f92oVwaptCQVThqtY=;
        h=Date:From:To:Cc:Subject:From;
        b=gTncaHloynzzCeB4kXEN3L6xYzmWIS1JIsD9bTlqkjghi6GilpERGGj1cruqFsESQ
         nNmSPOE7ggafgu+tZoSCZPmJ2iysxJD2xS/tv0YQzEmwdi10cmUcnTBEdWkQMkdOvt
         4gERLi1HcJNIwyN1ebyTvgcYvqkXuZwiQXDYw0/TueqmuXYV3BSgn2GhSfCC3np+0L
         SJSMjZWA/uIHsogjXI9Ob/mHfFFNjZz8AQCMe99lbBK2Laiz7sgFvECa1m7xUHmhW6
         u/sUWAex3KJBYfkzRcuoEow2tCne4eOlu5qSft3474UAp/x0d5MyWRo8Ap2DPvdD/9
         rjEPC+Ylk3sHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RxWN54Ltxz4xMC;
        Fri, 29 Sep 2023 10:25:41 +1000 (AEST)
Date:   Fri, 29 Sep 2023 10:25:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the samsung-krzk tree
Message-ID: <20230929102539.42b11f3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hN8rMBPPDllC+1WBwZSUNgb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hN8rMBPPDllC+1WBwZSUNgb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc-fixes tree as a different
commit (but the same patch):

  471eed5ad217 ("arm64: defconfig: enable syscon-poweroff driver")

This is commit

  d75e870c32f6 ("arm64: defconfig: enable syscon-poweroff driver")

in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/hN8rMBPPDllC+1WBwZSUNgb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUWGYMACgkQAVBC80lX
0GwnHAf+KVVpxUQ+3qp03oGGICxShm3CGiO2XC6i+TssuuBIQFZ2vwTz1pQoQVVj
37aecoy7PnF4bNzkPCjR41sDv7+l+E4V0Ky57XS5raTiFMk5rk1daJO0gz0nnJJ1
+j5wuTKETaED3XJXoWaTLXolBJkCnp+F/J/g58avwlH0S+LZ5iSUvsgf4PBhdC4i
5sNNQ7llT9LeeMBhaVrW/AQWnzOTiQ389kttrKtxvsyC4VSdetAuqU0keBE7xaxu
AJOl22TxcYia1wUsTK1mRUbGpl/n8VpITNKDejz3xo2q9L3FaE4iYK2Ax0Ns8NC2
wtrM0FU6QODHkOMfZTrsxt5zcsm9nQ==
=baLp
-----END PGP SIGNATURE-----

--Sig_/hN8rMBPPDllC+1WBwZSUNgb--
