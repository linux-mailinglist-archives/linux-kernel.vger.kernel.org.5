Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72D7ACC70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjIXWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXWPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:15:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA5FB;
        Sun, 24 Sep 2023 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695593711;
        bh=/aPhWsKVnXOMpzKdoh51cLpxyDDtledOkHU+7Q5ovt8=;
        h=Date:From:To:Cc:Subject:From;
        b=Fd8HbmgmCQl7rUvCY3fcexif/CJ8vEVfCWOwDeNNyx0DUtuf6MRDePUQu4rq3GKO6
         fLrFTfj5fkB8q9upZfBhOsoOYbNk9eJ8Rju7M14mwPurJwbewODt6I/E0K66EXWkys
         v4Qv8S3jbDZfwbjC6p9z2u4mn4yCFvZZFsZD86Otq9iCZWyyn/0w4I8X4+N4kysg+G
         pMQFMg7XW94jzVrpFvzY56RUBv22CnO6CN65fB+0Zq4D5egjoJdRrM3tYSyxJHTmkQ
         BWqKjr9KQoGV9AuDfoPP39AKjDZfnbWmOjEcpHuO8xdh4VKLs06w8sKQSNTIBERAnn
         yC6jTzxm74F6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv0gM503Tz4x5k;
        Mon, 25 Sep 2023 08:15:11 +1000 (AEST)
Date:   Mon, 25 Sep 2023 08:15:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the execve tree
Message-ID: <20230925081510.6dacf35e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vQiIO3GqLKeold9CMRM2iQz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vQiIO3GqLKeold9CMRM2iQz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d11362467939 ("elf, uapi: Remove struct tag 'dynamic'")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/vQiIO3GqLKeold9CMRM2iQz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQtO4ACgkQAVBC80lX
0GxzWwf+K18RyNdLSqPEeLBklQI63SwGoBKheDt194KTWIbPzedbMCrW60CrsP09
lU8AdF9tdWKTG90NCLNGzGbvicR9DrqdAToQNZ72/6dXiSDW5uqcDDbpz2BfckNU
BL9OHwB26p5S+NdX5fC2X4+ci+NlPut6MQ4BcA1beqchQ8enLazBjNlPEP2vXlmA
zLbdvgVOa8XKxmNCFqdz9TypIQlUQXGCGk+Q1826H0hGf3OKAZ785URAosN81gKm
DSe7BMcLC9pBJcZdvgjK9y+oGOpXZUhLrdrO9EPSIOP/4C1dbE/ZoUSKGgSKoVEc
/9zCsiLRJongB5KaErt4qAbB0FFOTQ==
=4T9Q
-----END PGP SIGNATURE-----

--Sig_/vQiIO3GqLKeold9CMRM2iQz--
