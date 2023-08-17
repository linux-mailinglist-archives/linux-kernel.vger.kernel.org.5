Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F878014C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355887AbjHQWuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355959AbjHQWus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:50:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3A2722;
        Thu, 17 Aug 2023 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692312639;
        bh=N0MG68vr3j3WzHFy4o59tufO8cRLEKLfPQJtpPpK5co=;
        h=Date:From:To:Cc:Subject:From;
        b=S8quNuPoKbXL/qyFp3Ec1QbG8wxOG12Bfq31wIpNtmKDKlo3P7R3QZe0To6j6ytNN
         OeiVWYIVlmfZBw9C0UPJmot8jIG4U3vyvgIvESAkgQ+GLmV6kmo2A7IejfNLynqwHg
         UqhZg9IbfJN3MrYcEln/CYU1Qaaojmjq2wYF2sbkD4PXhFAb+RgMjuN4KNhWvxlNX2
         QcbelYTN91tTbkNTQEXSFvNWeiuzcn+dqQfLtxOFOLd38dGOTNxh3WPD6EHIpKL5Qv
         D7A1q+rkhMmDqFOaqnVww/37x1B5z7fjFyUK16HDTybSdTTH3l+PL/cBv3lSA7YHRe
         EQRLCIFPK0m4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRgFp5vfLz4wxy;
        Fri, 18 Aug 2023 08:50:38 +1000 (AEST)
Date:   Fri, 18 Aug 2023 08:50:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20230818085038.31d7be4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EaatebsaUIKeM3U+QPPPQ4i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EaatebsaUIKeM3U+QPPPQ4i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  584e70f20bd0 ("gfs2: prevent gfs2_logd from spinning")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/EaatebsaUIKeM3U+QPPPQ4i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTepD4ACgkQAVBC80lX
0GyUkAf/VJMyppkf1m0Iz5Bb6dgZ5yLcb7GEFw6FpazUEF2dlvAoXATc5CrbJmse
bKZzd+Wv/T9tbfYyFuP05y7EPQTNWJj948w1p7Cub4OpgU/CHTUsCJ0pnp9FA/9Z
OhvQmSek7H+/au4zACxu5S3+LdpvQoVTZsHWfpMZKRumv4jRzPNNPGWKzkQKOLcw
VBCExe3sTaoRIZB7b8gLUbc9c6c/5jSKKQNUu3o0XA8KUaj4qjdT9cFD/NunHGLe
RcnawWB4DmQ9H7osKtadlBXyIZSr4e4Wo/wN/U05GNDiAgIdnVACtpXeATczgEBC
eP1p5uGUzMPBHGOiSA+bC7+lh+s9SA==
=mstx
-----END PGP SIGNATURE-----

--Sig_/EaatebsaUIKeM3U+QPPPQ4i--
