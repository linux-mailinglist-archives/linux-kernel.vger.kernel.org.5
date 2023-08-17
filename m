Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCC780152
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355893AbjHQWy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355885AbjHQWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:54:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB62A2112;
        Thu, 17 Aug 2023 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692312864;
        bh=tt7bxUQu7eRBhfRaoSW30I/9KutvJGo07/6n+OPETbM=;
        h=Date:From:To:Cc:Subject:From;
        b=Z4TTQe6yha1GS33oHkAVJcTPBmSt5ENylB5QNVNs3Vy1Qer1Z2uvv3BBz7aAg0yZB
         AAHSpjOT28ZH9zSgcRkggjoA6iLjrDIx9435ZRJ9pnutdtW30kQgpW1iM6HzpYMaxO
         jvaVFWCkI/YmKyzNkShWR8bvND2gsi7TXQYHtGYGAqHDz+sqfKNT/Vpoom/b0+NjDE
         01Per4rmLUk/yt78oatiugyea6I3ZutDfQEivxIxWXJiCrTg4ivLGPKDPrAaflzjNJ
         IjkdIfEn2YGXBgHJbxJ4ctcFyNCKaMmKSGQj+UUHeDKaWSRq4BuTU+4VvqRYG5JYHp
         oych2OPYH2Ymw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRgL838VSz4wxy;
        Fri, 18 Aug 2023 08:54:24 +1000 (AEST)
Date:   Fri, 18 Aug 2023 08:54:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nfsd tree
Message-ID: <20230818085423.436d3b72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xaPeJiI=oQ602Q6H1JBzsaj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xaPeJiI=oQ602Q6H1JBzsaj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  7f55e3c57a81 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg=
")

This is commit

  c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg=
")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xaPeJiI=oQ602Q6H1JBzsaj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTepR8ACgkQAVBC80lX
0Gw6xgf+NpXr6ksUGQ+HNNuzxwYeKgDSL622gaY5DkHycsiwntxiduGlFXynM7eU
tY3ZUflg71/piWgeEbQd89XZ0kguccMJ95Nmc4fR4LYVe80AmBMJMLjEcWC2Z0bN
GeBmOIjfQr8tJghDfwoi0IcpscNLKYAk4mbSyS5cXDcF9F5kjV6dmBgudMJdltNM
AIgoneF4NfEbF14A4ILjKHCZuN/1FR6ED3uWIQzbvFizG3qRsKaxBYli6wFr9fJ6
cIuFQSoKNzM4ji9OA2Z0Ds+onMAIxdGJR3A2T28lgUaXWxBwPnlp2Bmh0uTqE43B
Ch0ylfEEDkW2v4TueZd2SHT94H/MUw==
=BW+3
-----END PGP SIGNATURE-----

--Sig_/xaPeJiI=oQ602Q6H1JBzsaj--
