Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61176888B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjG3VwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 17:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3VwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:52:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B411B5;
        Sun, 30 Jul 2023 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690753932;
        bh=he+8kSSLCJXfnS7OdYG7KIKqWIsbeGV43XmV9+7hHbo=;
        h=Date:From:To:Cc:Subject:From;
        b=RaXknVD8aR7NPSzsLMiBrZWPdNjqTbzNZ47WngSQTavCMYdhwrzGiW30d01+g2/WN
         HDVWBLaHiWIqp6PEy5D4l6tQDSPyrzBwyXlEbUhy9Lpkn0g5IoFgLCscUGoRiK3urF
         ltxQQl/+6MaWN06Dj7UrNbBUiP63dUqHMSQ8wOhoYzJJ323DOdp/FiawlOfpus/4+M
         WvxLXGdEuw1wzBQrKoCINu/mvrA9aPdjWAfPGXOxJMpvvFtjX8RkA4/Q1W8GNn/D26
         XafH/mSOXG1KMWKHg2zS4AAefscCpQ6vcU+GoRD5g6PahWM3dbaemsw+sz4xWgSmE4
         wwLStCDK3UZ5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDZph1BYCz4wbv;
        Mon, 31 Jul 2023 07:52:11 +1000 (AEST)
Date:   Mon, 31 Jul 2023 07:51:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the loongarch tree
Message-ID: <20230731075155.739e5a2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nSaWvEUqIFW.wjLZ8O8G+Ri";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nSaWvEUqIFW.wjLZ8O8G+Ri
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  bdc86a68be08 ("LoongArch: Cleanup __builtin_constant_p() checking for cpu=
_has_*")
  a9b000c11611 ("LoongArch: BPF: Fix check condition to call lu32id in move=
_imm()")
  27a4ebe0b5ed ("LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArc=
h")
  1bdb8a673df0 ("LoongArch: Fix return value underflow in exception path")
  afd22cada106 ("LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handl=
ing")
  d4a1397e5d61 ("LoongArch: Fix module relocation error with binutils 2.41")
  4d57f619c06b ("LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'")

These are commits

  1e74ae32805b ("LoongArch: Cleanup __builtin_constant_p() checking for cpu=
_has_*")
  4eece7e6de94 ("LoongArch: BPF: Fix check condition to call lu32id in move=
_imm()")
  de0e30bee86d ("LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArc=
h")
  e66d511fc922 ("LoongArch: Fix return value underflow in exception path")
  83da30d73b86 ("LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handl=
ing")
  03c53eb90c0c ("LoongArch: Fix module relocation error with binutils 2.41")
  54c2c9df083f ("LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/nSaWvEUqIFW.wjLZ8O8G+Ri
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG23wACgkQAVBC80lX
0Gz0tggAoFCCWF0X5aLTX/7/jou2nDakjFMFHy9myobZs5zikJuInUEJWK3FpF7J
gOW45zZjQkY0vvJ394/ZywdMGsE7sQNJuoFUZGyVm90FHQNWHtUHqryJysSQTtJC
zTPsFakj2cSWDvzgS1FHF9mxTQEFonnIGSnqyoQ6xTpNoHKnHvZfEIx4D+8JqMGy
hptt3U7w3HRWkTfq7PeWEiMbee365Vb8lWltz1GWVBCDcDhqjLnlq+tEfFUNBm8I
wA7r2LgRX2+ugFq6TgROYxXmjiSkyvhii5aYK6qE0UFV29SpNxf1X1QXlmOPfAno
qSIPFc2SgQFpAe64/YxEJNO+FMyxmA==
=j9lb
-----END PGP SIGNATURE-----

--Sig_/nSaWvEUqIFW.wjLZ8O8G+Ri--
