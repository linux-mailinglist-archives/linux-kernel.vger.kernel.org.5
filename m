Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBA7DFBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376750AbjKBU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjKBU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:58:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FB1A4;
        Thu,  2 Nov 2023 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698958721;
        bh=Z9hm1IsD57xbA+VBLEg436HiwWyV8amNfvjdSYE3Flw=;
        h=Date:From:To:Cc:Subject:From;
        b=TlfxyWQ7XxJvZJFtJf9u32SNYRcSPEL34EWz6i7NbaZNWHnbFcD8o29fCnksR9Nye
         DM01zL7bEGqJPPZy4RKTEJimDpnNtwv5UWTQGc8A321F1nUcqeU4vwiwUQ/lR/3Am1
         ExHb6kS4/1lVsU+sN1aRGWaONPZVacR0MpYETfUhAvsnCUjSaolM7Y53uEDqoJCYQx
         PeXbg+qU88t07kt7iVVo17adoYasslRWxcMxTuQNv56BtNwT+88DVKzBzTpGd4G1st
         ldQmh5DhcSdKw3JJDzT1rPHhCHluiXmPBceSUjTBjSWkFABuHx+rjBTQ2ifwkmNfyf
         6Kufq0lHjs/tQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLx753PB6z4xQm;
        Fri,  3 Nov 2023 07:58:41 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 07:58:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v tree
Message-ID: <20231103075840.02d66c1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qUhMt4Jh.aK5E3PQQyOB39.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qUhMt4Jh.aK5E3PQQyOB39.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  e8620de3f26b ("riscv: errata: fix T-Head dcache.cva encoding")

This is commit

  8eb8fe67e2c8 ("riscv: errata: fix T-Head dcache.cva encoding")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qUhMt4Jh.aK5E3PQQyOB39.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEDYAACgkQAVBC80lX
0GwfGgf/TnKC8/hRJiCn38KzxRYZ79YxjO5y/SWmkM09quPjqJzGWLXzAIHSl2Np
xJtc0d9FIYANJ7NfK+2mTIcIs44Bfbvy1F+Gfy5E/A/fZfO0gzfx4tGqgMSkrnKf
Pem1IiA+ap2IpAVf20sSpPreJqTwZzhLkBi1NP7r/OFHS0IRrM5hqt3AetKXB3Ru
wdxDaqSNDCR7pWZ/EznfsBoxEJhfwm9TecJyMYPjOht1XWA7eHLpH6iANiG2WIE2
fwBwyerO7th4BWqK2FLXBRTkDdNAUHwjY7lgh/RCXlAJ6lHDosJ5hehh4avrySxJ
RVUHoIgNvBP9TedU07J9sfcqt9o+Eg==
=6W1L
-----END PGP SIGNATURE-----

--Sig_/qUhMt4Jh.aK5E3PQQyOB39.--
