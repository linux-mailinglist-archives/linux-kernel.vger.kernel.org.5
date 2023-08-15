Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63B77C595
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHOCDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjHOCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:03:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5768E72;
        Mon, 14 Aug 2023 19:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692064988;
        bh=vf4OmwU4fAja08xwSgT4EqdelefESM8T/+GuEqYP47U=;
        h=Date:From:To:Cc:Subject:From;
        b=YiLRSsenRcuP83YrWCJQka6QYzqDq8A7tbp6U0PiRnx8TmxBBEXbV39YMcVI76NR3
         GvN9nAB8idQG0xiKjhrSFjhEJcfCkx40SwPW4FQzzsZooOSv5siAlroUalUnAS/zcb
         fX9vnW/PQ0w/NwuzXIp9aiYcmNKy+24dKmLvBx6LXUNVVGvr8o/91DwJKONzOmHB5d
         k1gQ5/Izal3A9CjjDtmTq3vSJQGhm0kvAI+2vdzriFYj6beZZEbz5nRCTSIbsz5Elu
         qh7IPBDn/oNux9a93jxVQUFSR4xpb6biE5Oe4fjU9dZ0WE5DEaerPKl5nn4Eq5c3fU
         Kn+IMy4X0z0DA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvgJ2v3Jz4wb5;
        Tue, 15 Aug 2023 12:03:08 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:03:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rockchip tree
Message-ID: <20230815120307.3dce0db5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N6UY+O6XmXpIIYHNE5T+_48";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N6UY+O6XmXpIIYHNE5T+_48
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree as different commits
(but the same patches):

  8cbdf5d28809 ("ARM: rockchip: Drop unused includes")
  fc7696e2ae81 ("soc: rockchip: grf: Explicitly include correct DT includes=
")

These are commits

  ab7c1ad11da4 ("ARM: rockchip: Drop unused includes")
  0e7ed4dda9ef ("soc: rockchip: Explicitly include correct DT includes")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/N6UY+O6XmXpIIYHNE5T+_48
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa3NsACgkQAVBC80lX
0GwM3gf/bxCVPJ+09ViNw8ttbN9fc0IvnLUoG4cjm0f+ct2781j6WWO99FQ60I80
nSH2yZeN2i5LCWGIpYAZsWzzr1XT5+ruj2AQv5VY8ZbvRv+ERlUd1aGE50BrHmVI
+s7QO5B6Ro3N2FcT/RsE0FHUMUB+dY9/Ja+CM2aNt31Jp4XOoe8I6/GnQtwwuoq7
/7nmQgz5HSIzrCBtrTfwlHyqC3IeEUQpJcNeojfZU1UWIgfCBzN1jX8op4FEMziu
8b+FQRo0ts/sQrjhjKTA9ldGJR9R7Iu9/sueNz27vTs0fzwQYDulLAg65WL/96Dp
EDRao4Yl2G1PhAhDlq2Gfkc3tJvF8A==
=+1r5
-----END PGP SIGNATURE-----

--Sig_/N6UY+O6XmXpIIYHNE5T+_48--
