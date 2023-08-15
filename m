Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D525677C563
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjHOBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjHOBpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:45:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200A1729;
        Mon, 14 Aug 2023 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692063942;
        bh=gIBERUdUoRYRXHSxqAL5rLsSBgZXFQ1VeKtYxW/AfUE=;
        h=Date:From:To:Cc:Subject:From;
        b=jku1Rt/ftvZ/X/5Ofgfe7CAFg/oLaP7zWMpFkzL+nx7PtIcjeH4el1ycPBSYmKx6S
         ViTkPWfDft7Xi+lreybIBS/ay5MxHAibSYjCyzSqaT3Pxqw4MblMZu0JW3RkoGDblQ
         6TRo3UlzNfmGGdjPidbmUEMkt0PTj4DA3G9U6qQGirnfacOfTx1PzKGqmcTyeK9OQc
         HckZ4RgXjHoQbqSszDsljaCCpVs9+6c1zu+5mtLZR8XlV9u2+BL69VjjkAC5KU4Prv
         tQOgzaOa7JA6KKdfaIGNofYASkVCow8mBLbqKrv4Om5RsvH9c+r8dazYD5UR+twzsK
         d+o6oBoflZN4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvH86QW6z4wZx;
        Tue, 15 Aug 2023 11:45:40 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:45:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the at91 tree
Message-ID: <20230815114539.1c20574e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7XC2skMNb5UcVU/L3x_FmEU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7XC2skMNb5UcVU/L3x_FmEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  163edfdfd9d1 ("ARM: dts: at91: remove duplicated entries")

This is commit

  2ad41a987209 ("ARM: dts: at91: remove duplicated entries")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7XC2skMNb5UcVU/L3x_FmEU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa2MQACgkQAVBC80lX
0GxI6ggAkb5024V2QYroegE0i5k0jWuC0HKbd3nBVJOT5UcEYXw1hLMGRAZCh1ic
kaXwOqdpfqgKZeykxgiYFyhOA6pH7pfs4wkEF/AikjFNKzsfBemNuA0BlvVBBaA+
2eGgzpxURlGxh8Bl4vbdtH4MmVvk65MweX4ScEkD/vbYnN/4KppsZbdTm6Y+4y0w
+vlFrQ68sMs9mdsdo+3TSM0bVNmLRs3Ev5og3yMHA+eM6GRMCGpWW8qEBmwHYqG8
31inq5DJeYcrEIyY+MJH6v65/7gU6PeGABa4PSniqS6D54Enh6kke9RdQ70hz5QG
amuA4J+4EKFChV3vJf501wE7oiVAxg==
=yGpd
-----END PGP SIGNATURE-----

--Sig_/7XC2skMNb5UcVU/L3x_FmEU--
