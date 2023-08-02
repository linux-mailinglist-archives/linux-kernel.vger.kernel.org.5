Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7A76DADB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHBWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHBWcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05598C3;
        Wed,  2 Aug 2023 15:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEB261B49;
        Wed,  2 Aug 2023 22:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64491C433C8;
        Wed,  2 Aug 2023 22:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691015569;
        bh=jcZLzzbL9wnv1JEHajJmzq503m5f5HVduTznpCsCWvw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DRDzq6PTQMyiaQpla5kRhe9EUpXUWOVAepi7seaIS6scR4PXg6HfWk1wUuaCHG1XK
         wmlr0FkPsWAKWfd7sIfNMXYRtwcIaiklF2GlDKbH0Fm31Xq2mg7tXO8AlVMuN2Z+Eq
         ocqSUg0ZMAloSZ5+K9ZyHtx/OsizdwkB0ICJC5L+LPwic8XOaCtjDs9PJt1toW5XfW
         eq6EIKW+D/whKUcdFXO38EpuFhX/tLq6NEzVdxJMlLUiPc0vwu/tQZB1jdInT70TcX
         ys0V2E9oBVbakzpdT43IoSETPE2i11t6C4QEHAa+/vTpZ+w96LghdV7YVbmgBmPIns
         nDpuCY+4iqfkA==
Message-ID: <b1f2b859-d223-eb90-994b-8741ab7af087@kernel.org>
Date:   Thu, 3 Aug 2023 00:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: man-pages-6.05.01 released
Content-Language: en-US
From:   Alejandro Colomar <alx@kernel.org>
To:     linux-man <linux-man@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Sam James <sam@gentoo.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Marcos Fouces <marcos@debian.org>,
        Luna Jernberg <droidbittin@gmail.com>
References: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
Organization: Linux
In-Reply-To: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BSJFrqdY1NMfQWTGqKdCMem5"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BSJFrqdY1NMfQWTGqKdCMem5
Content-Type: multipart/mixed; boundary="------------xkFL6XKMFEJ0800gUNJSnMcs";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: linux-man <linux-man@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, Sam James <sam@gentoo.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Marcos Fouces <marcos@debian.org>, Luna Jernberg <droidbittin@gmail.com>
Message-ID: <b1f2b859-d223-eb90-994b-8741ab7af087@kernel.org>
Subject: man-pages-6.05.01 released
References: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
In-Reply-To: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>

--------------xkFL6XKMFEJ0800gUNJSnMcs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gidday!

On 2023-08-01 15:19, Alejandro Colomar wrote:
> Gidday!
>=20
> I'm proud to announce:
>=20
> 	man-pages-6.05 - manual pages for GNU/Linux
>=20
> The release tarball is already available at <kernel.org>
>=20
> Tarball download:
> 	<https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
> Git repository:
> 	<https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>

There was a small problem while packaging for Debian.  quilt(1)
produces a .pc/ dir in the root of the repository, and the patches
stored in there confuse the build system to try to lint those patches
as if they were manual pages.  If you successfully packaged 6.05
without noticing this issue, you can safely ignore this bugfix
release.  If you noticed the issue, or haven't yet started, I suggest
you package 6.05.01.

Changes since man-pages-6.05:

man-pages-6.05.01:

-  Build system:
   -  Ignore dot-dirs within $MANDIR


Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------xkFL6XKMFEJ0800gUNJSnMcs--

--------------BSJFrqdY1NMfQWTGqKdCMem5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTK2YYACgkQnowa+77/
2zKNMA/6AiQF3ZR0PVEVVieuI7CBClQzPaZ0RJwdP+VMpFOJNT04CfK+gZdCvdvc
80BYTrnLQSU8DjY+6ikCtyMg4i19mDw+AMTZbWsFy7Wu/NWbu9zxImuy92U5DjdD
bx5z3Yf/zIkjkrtKLD3mPqA4R5+MIJJnmJx4FY4FlZAB0mZ2g380SKFjJJtvkrFj
wcGljj638YMRYfw0PL2REx4hhPIbwPuUUe49/7wkO0mrbjDUNTbP7EbLNcBtM73o
h+rVnJim3EonVe34btWcVCn0uljKiQOxOSNu2d2r+lxscHii0i5tr+mr0YyLLGIO
bfNeVMv1t5m1FJqvgPnYvY+PCwsWx3XoscGxZfJCqRs4muxTCE3o+DAWWB1uh9Hm
t60wgbWOeUv5Wnb0wZn95570iQgGo8/x7uOVCNksFcZU8pKCOpGafcIXSNjbQ9aT
W9LiU1POVAN+/vT0rb7JW6P4kjjO8rRoKgfmF3fiPD2aHt5hSR2ODuuFUujBoIlA
UJ75bfr2PvX8NB5QckWPrg5YlDqUDydOGfnJYyPNNiJ4MiyTwSDQL1p0ptDV1pQ6
nMRwcQfKCh14N0u5IO9qyPTWwtZlX56P85EAs/6FeiR3ZVAlzaLnd0E6bKcUIyzJ
2bXQ7bmkGYDPTPNPF8/Phaw24NF1mZ7HUwaFr8iYg0/usANRSWQ=
=ci5d
-----END PGP SIGNATURE-----

--------------BSJFrqdY1NMfQWTGqKdCMem5--
