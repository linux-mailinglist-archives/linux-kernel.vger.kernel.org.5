Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA827DFBE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjKBVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjKBVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:06:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE118E;
        Thu,  2 Nov 2023 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698959203;
        bh=IL1UXN48/wBfVZBy7nalkv0yCuch54ENh6QZaU69oGM=;
        h=Date:From:To:Cc:Subject:From;
        b=CpwvTiedvH6WHKYigSNccJgQtFGplu9KFU+0EnL2pIeHuQsdduaytqtxJq4YNkzwx
         +SAApTo0EoWpYR1xIxRHmp5+lUCA1VfsnBSDej/iAAoXesRUoOnQP+bwtAX2u+4Gdv
         SH0KX0ts3pchGrVdCVsGJcRv5kXmvPJ9TTo3w4YNDDz8WCBhxDVY/futBigXlPUzkC
         2z/4UkvrXz9c8Yp4rxQLPTcX3gnB/nkey6/KnTgQROIr+8nV6+V0cGDA5x3yMCxDNX
         XPAbCMPBbcsQOrl9nEu5sxigFGdd6u2Laj9VIqqRHYbOZ4gyj27XWFOlo3RcCOLm/U
         ZpePN1tiEmXLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLxJL6Rw5z4xPf;
        Fri,  3 Nov 2023 08:06:42 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 08:06:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the modules tree
Message-ID: <20231103080642.468b331a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZF3a7bZ0OaRHFDtp7DcG8u0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZF3a7bZ0OaRHFDtp7DcG8u0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  3111add7f414 ("module: Annotate struct module_notes_attrs with __counted_=
by")
  331e833a7606 ("module: Fix comment typo")
  dc95e422c283 ("module: Make is_valid_name() return bool")
  bac202d3712f ("module: Make is_mapping_symbol() return bool")
  b72d5a66766d ("module/decompress: use vmalloc() for gzip decompression wo=
rkspace")
  c7540b27da9e ("MAINTAINERS: add include/linux/module*.h to modules")
  130afb8ce111 ("module: Clarify documentation of module_param_call()")

These are commits

  ea0b0bcef491 ("module: Annotate struct module_notes_attrs with __counted_=
by")
  fd06da776130 ("module: Fix comment typo")
  04311b9b3063 ("module: Make is_valid_name() return bool")
  60da3640b07c ("module: Make is_mapping_symbol() return bool")
  3737df782c74 ("module/decompress: use vmalloc() for gzip decompression wo=
rkspace")
  62eedac26415 ("MAINTAINERS: add include/linux/module*.h to modules")
  2c7ccb3c362b ("module: Clarify documentation of module_param_call()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZF3a7bZ0OaRHFDtp7DcG8u0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVED2IACgkQAVBC80lX
0GySBAf/eUr6CR8sY5faCQY1OANtb3DURLndV4epd0latXhi8Y1P0GeGyNXfUbGc
sYaYrjhat+ExSvMiD7Z1Oan9mc6+yYQZGTV9tRh01GzmeZG/dPzY7pYFoxUXqD30
QUDdDwY5G6fALpLxv1m33HAHyE/eec6eUHdhI9kj/BIm18+b0g4ry0c0fxl01GuD
8ULcv2FqtsEHL3SJB7c/1gdMq+J8lSTDqL3UXZooiwiFMORgJZeUQpFo0+08mO08
FPlxXFkfqguP1W1B+HvkmX8Zr1mPESqGCzBQgxUK+98DVvc9QGaCkRGPjxJlrRXr
/2AoGvn5uP8iRDxtqKRXzffCQNDcKw==
=s/ID
-----END PGP SIGNATURE-----

--Sig_/ZF3a7bZ0OaRHFDtp7DcG8u0--
