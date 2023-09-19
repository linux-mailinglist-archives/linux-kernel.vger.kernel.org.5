Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E507A6CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjISVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjISVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:11:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18DAB3;
        Tue, 19 Sep 2023 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695157912;
        bh=NgnAGEIHsdBI0pbn+fpZFrTFCnksOFYYseJ03xYboq8=;
        h=Date:From:To:Cc:Subject:From;
        b=SbYHV3ZzHk0bIkNbGiM50s+DbiAjLp0gyvuuDfxnLqYMF/bxkqWbImzc/Of0xFJCr
         xWLQDORwRahoahWrbhwKj2n6jk5YuKcYAFHBZWP3rQZBGlapu30+ju1OpFZ1MDNBFT
         Ool0yLuWiwuFPN1yDwZzbentvtKpJhpFj/IM/62UYmeS6qjRQL3fb7DYe/AwlINwdy
         DIkOJepeR8lbkmQ9FigmfPiVOU+APFhIi2UMzQ8MMHlJR+Xi03ib4yst2+Ax+rAW3T
         bCq7ZMS2+MTYdcalmSM54+A7IH+1zEUGLlujh7tGTRn3VOmOyfAfXr9aLqEX4fcWZV
         NZo9o9Qg6vlRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqvVc2VdJz4x09;
        Wed, 20 Sep 2023 07:11:52 +1000 (AEST)
Date:   Wed, 20 Sep 2023 07:11:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the ecryptfs tree
Message-ID: <20230920071150.64736702@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HKvEgpb+exjdiFU45w6uOTc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HKvEgpb+exjdiFU45w6uOTc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  031a0300f2c9 ("ecryptfs: Replace kmap() with kmap_local_page()")

This is commit

  8b70deb8ca90 ("fs/ecryptfs: Replace kmap() with kmap_local_page()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/HKvEgpb+exjdiFU45w6uOTc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUKDpYACgkQAVBC80lX
0GzUHAgAiMYdiM1R7YiCMQSFyyVoZR7q1AAH5Yton+zivVEFo/8ZHDucczMWH+HG
ksslgHFYPaHW11b2uIP/dS05JPMUq5QsPyAcgMbgWQM87jiZtJok+tZjMdQAxP4a
gyPnqMpAo3H7HVaNsGwiBtRAyWUuNr8ToXR82LRN4zpAfH7xBepKiLWn6tWFRgpM
PvZ76SWIU8PKkGcJUCh5Cfjad8xKpJf+wH3/2A04sn/Xf4MjyrSNFqrH3Ob/lbBH
ZjFIkA7Bpya+mWvblDAw+iI2Oatd77Gqv3QR4+N3RgLG+uKk8LbyInUPFcaDnDg1
+vQblHY2Qw4rCE4nlzWKD3YSr+bP0w==
=MrnU
-----END PGP SIGNATURE-----

--Sig_/HKvEgpb+exjdiFU45w6uOTc--
