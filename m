Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ABD78BCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjH2Cj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjH2Cj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFA139;
        Mon, 28 Aug 2023 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693276759;
        bh=XXHjg3XzdGkuaVJeeZDgaiYGToYjKp+PLygQB0b7g88=;
        h=Date:From:To:Cc:Subject:From;
        b=k9pp/Kvz/9jECuVHYlTVqU+J08wq6b4PvImvtttLTVITsRw5/7sPDna5scFFao48R
         7ZdIF6F2zqu2JPPSKNu9lHQF3pYqsaweDL5IMBBWpNN6gW4+rV3at4E7SvXSOwT/P/
         Xjfi0sCoZwVZQIe/TQhob7+6lOtYQsnmivXx3Sg+s1ia8vPObvXeK6atmrzG0fpoYU
         ubJTHzKuQRAb+fxDzVIQGJn0SIrAAXfAENhovqaXx/DRUnoMLNo14RofliOQw4AbPp
         tu2vao4MpnD+GQRrAcxicGhb6vPo+d/Lzd16MSRqxMPQyCv8qZjBHHDkFj5jy6ep5O
         iQGfrRqU3vKQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZWpb1YfSz4wd0;
        Tue, 29 Aug 2023 12:39:19 +1000 (AEST)
Date:   Tue, 29 Aug 2023 12:39:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bitmap tree
Message-ID: <20230829123918.2207c920@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5qTx5I5ZB9LyTsMnF/1A_E8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5qTx5I5ZB9LyTsMnF/1A_E8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a566b312d982 ("bitmap: Remove dead code, i.e. bitmap_copy_le()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/5qTx5I5ZB9LyTsMnF/1A_E8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtWlYACgkQAVBC80lX
0GyP1wf+K2gtyh7TVI25a4Pll9KmTX1Vz2DDOkyFX2XJo/Al/lG7+VFJ6gyHYY/z
mAlLtPhya7FAhTjK33i1SgKqKYC5rZriilBZqcZ1/OMaxTHTTamq35Mu9ej8974R
JCZHj2GwM9F3ucBSmmtAcarAowkrYlRve/DkFklQ+yX+E2BDHMc72Uq25lgpg8O5
kv6jwutvA0aoemE2C9j3FHxSCNEwuRzeKrEFEF7B/4SVjxgbgbc6FEPysPgPFvN/
zt0u3c+Ci2Kyd1WxXZQKKyWU4b7IsEjTdro5y27x2mP57vkp50HIVC4dHPKKS2iF
94yH23jt7segjFqzKugmCRDANVPQIA==
=lE+b
-----END PGP SIGNATURE-----

--Sig_/5qTx5I5ZB9LyTsMnF/1A_E8--
