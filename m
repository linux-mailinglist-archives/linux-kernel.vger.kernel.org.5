Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732067EAA07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjKNFQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjKNFQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:16:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DE19F;
        Mon, 13 Nov 2023 21:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699938974;
        bh=3B4Pr5YTBvByTHh9adCE1KaaMEmXcMYtHp1nN079D3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7Hd5D4QMMMHuood30PVlqEChXEl8wvyDLiJztdlak5enn/yl6zeiFYn/gIjaJr5L
         GPdKfaFW4RNxlvTYez1ys25vQuBNzc5MkWbHNgkGAGonrv+1fbvz3tiJVpCeJJrIUz
         D9nH4EDbbM5B594RuYDxSTfW+oNWd/pbU7izvnpcHQyTX3bBixq0/5IZGgCTUZjd1O
         zq2k875zqfhEHeU9RZJ2MUXXV1xDUQ2HfU7opxwQg9gmb4EJoxRuT/rinVwQWpI9JJ
         3IfAuYZybwXpZnvOUBosz+GYlN9iE6Cp7ZSL2hAoIbH0SA5YApSoVMj3bcXX8bNUYC
         k1hRQ6x6w1Jyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STvf60P8Xz4wcj;
        Tue, 14 Nov 2023 16:16:14 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 16:16:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: the fetch of the tomoyo tree failed
Message-ID: <20231114161611.256f0239@canb.auug.org.au>
In-Reply-To: <7c814d59-fd95-40f4-80ba-237bead3de69@I-love.SAKURA.ne.jp>
References: <20231017163242.62af10b3@canb.auug.org.au>
        <20231114144510.49fd3688@canb.auug.org.au>
        <7c814d59-fd95-40f4-80ba-237bead3de69@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mSghKTnbc3L6YoNBh=UZzqR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mSghKTnbc3L6YoNBh=UZzqR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Tue, 14 Nov 2023 13:49:29 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKU=
RA.ne.jp> wrote:
>
> Unfortunately, it seems that OSDN became unresponsive after OSDN was acqu=
ired by
> OSCHINA ( https://www.oschina.net/news/250642/oschina-acquired-osdn ).

Bad luck :-(

> I'm considering migrating to a different platform.

Maybe git.kernel.org? ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/mSghKTnbc3L6YoNBh=UZzqR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVTApsACgkQAVBC80lX
0Gzh/Af/d3S/kPUkTsXyq8PwSAMjoDe/f2Uh/Gw1WQHEbnauBgJSumDtBDqcG6N0
8h6XmpwknAQE2dMUFuUc9PcwhT0py1smAh50+BZDvwXAMx0m409KSYXnz4AOh1Pw
T6SGNbYYo+lKjfJtSLDklWmIO3Wymwun85HR3Op+gng67CT2h212OtzrvCqnwC1Y
7H4qgN9Yg8qLkZ0rCuQDAZDsHF4+JgVrEzO+xd07UgzN0ZcZ95erJVl7THk49CXT
E6iGEPo/MzHESricioawbCre+am48fRPZ0QqGjGVevpzZ8Q2vMix6kHcSydt/c1e
1CntfGtdr3EC+wu/6pwX2JMtQTKwSw==
=lIEh
-----END PGP SIGNATURE-----

--Sig_/mSghKTnbc3L6YoNBh=UZzqR--
