Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713257530A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjGNEnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGNEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:43:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729F1BFB;
        Thu, 13 Jul 2023 21:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689309813;
        bh=0EAZQF0ZRvJDuijbB6biXRyMvZyzpAoOGlG+iMDWv2M=;
        h=Date:From:To:Cc:Subject:From;
        b=ZNgq8rwfLyRlq8jvPoLsN0heU/A8fVoEGg4JlIhNc0a7LcCqBMUgM5iZvTfagEdh3
         SvI+U2YetrRCyrGtRpehcavtw0/Lo6JD9QkmlBywgwfJZd1TehDz7MSn5U365crKpY
         xG8ZdDs4CEJg5DGpJfxvWi8/0NB98oavDyqY1xmfSsnAsSN8Pais//B6lfv4VNomlT
         ziqqYcl/AKAxeEVLFT3X6DVCyAFowAT6PELcHoZmgZ51uKFNoATDEgud9Sh270q8RM
         ABeDGFOzChG6ilvmqGRmUjNnJQBz7zTPqW44JQuri+RyFE0AGYW5EVK/enfJvlfZcE
         chCrSCxHJfyZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2Jl72KNVz4whq;
        Fri, 14 Jul 2023 14:43:31 +1000 (AEST)
Date:   Fri, 14 Jul 2023 14:43:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20230714144330.3c0a4074@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fKTn6Q5x31rwAq0GXu9+Y2N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fKTn6Q5x31rwAq0GXu9+Y2N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in net-next tree as a different commit
(but the same patch):

  a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")

This is commit

  43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")

in the net-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fKTn6Q5x31rwAq0GXu9+Y2N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSw0nIACgkQAVBC80lX
0GxejQgAgCLh4rcnJq9lOAVUVp0lfT6cl9uQwYMnoeOGHYwtnx97bCjvpihuF9D8
0GUPuA+3gDUGH/87myiM9aa4UbSOvxzterLoI34mFN/aUVsbm0aVwFtYrCDqAnGL
ChF89g2lJpA70HsCip6+QPZAolasAGSL+5rO1HRr2edwJ6oH2qffnTT6Kp0mPa0X
LzqId9kuUfjydDVc/FITHJ2nWWfj214+Bz9v4SQcmRHDO91XBmChyjp1NvOg/5ev
/O+gPspr3Tvx+eWrbO9Mxrejy2GOufHvS2h3Kd9qAXG1morzKX4XE1nCGfOu2Yxp
GBXkt5cKi/+gPGjA2LyDG718wY/tZw==
=uFFH
-----END PGP SIGNATURE-----

--Sig_/fKTn6Q5x31rwAq0GXu9+Y2N--
