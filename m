Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F677C53B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjHOBmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjHOBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:41:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E0173D;
        Mon, 14 Aug 2023 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692063704;
        bh=vGIDhLkr9Dov1aNaGYpik4Rt9PrIxi/DD+YTYK7vcuo=;
        h=Date:From:To:Cc:Subject:From;
        b=YoGMK0oRZePdpbJ6OfTPEbh88smcRVJn2nwZHr07JQwZ4EIl6FBhwQde8e/5KHlNX
         UHs+a5gLVsyYFIll37cMIQ0Jvmfp18H0z1b8YBCne3WpWvFPLRPa93zVUtG5na8m+A
         uhx2QLvs92Jo0Gnbx/5/+/hPidEuChoiDULTCjEOFWeKYMs0QkAVHu9z/iPC/zbT7V
         b7I67av19CblVJqzmaFkdujk/b5AFM25GF1YbpWD2FehdfHWAI3Ob9rAMVemfNpL14
         5QjvFfHFVaI4yCTPacEDiR8bndlO0bSThgWVWVAvGcrpABrFKBLvBq8Ho4QBJE29D2
         mO62ibBGYJUlA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvBc3dbkz4wxQ;
        Tue, 15 Aug 2023 11:41:44 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:41:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the aspeed tree
Message-ID: <20230815114143.23e4b2ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pAwXJDD+Rv_sGfE2__UHwKe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pAwXJDD+Rv_sGfE2__UHwKe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc-fixes tree as different
commits (but the same patches):

  0955e3867b54 ("soc: aspeed: socinfo: Add kfree for kstrdup")
  c5835b6e7aff ("soc: aspeed: uart-routing: Use __sysfs_match_string")

These are commits

  6e6d847a8ce1 ("soc: aspeed: socinfo: Add kfree for kstrdup")
  e4ad279ae345 ("soc: aspeed: uart-routing: Use __sysfs_match_string")

in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/pAwXJDD+Rv_sGfE2__UHwKe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa19cACgkQAVBC80lX
0GzZ1wf+Jjh4ob2jo/TPH74eksAtQ9UQqlQCppkKkebjHGffhnnEJ/eFILA4ZrKN
vfc/HVww5Fweyjk5mPalCTRYp3ntjiu9O+xcHgA0CzhPc1m+KsJYb/kXMISKNVdJ
MfW45iPpyR8//xQ3/cYWYYqxsoblDcl6Vx91eFXrY/3ppNBJAMl6gfPq3xikGwCC
iFHdkGC6V0c/l3N82zP0sPHsArbHvFxo1DdhToWFu4vqaxCShH/QEmyIwXkVvwMw
wXtMYali5XYt2PpQvYPP51joqcdQ5E+GbLJD1tGb1p+QPdCWWgnzhu+BAfrl5sES
omal10Eo3CvuxcM/MdxA6ZDx78OJnQ==
=vKqM
-----END PGP SIGNATURE-----

--Sig_/pAwXJDD+Rv_sGfE2__UHwKe--
