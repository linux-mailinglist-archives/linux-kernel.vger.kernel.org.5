Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468F78A29C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjH0WUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjH0WTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:19:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CAC127;
        Sun, 27 Aug 2023 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693174779;
        bh=pakHnLAK+A4WYYYOkxhkLuJJtz22sbUwnWuC5ymutlk=;
        h=Date:From:To:Cc:Subject:From;
        b=J/ZjwEW4u3kQL4RXjyT0Iz0yeM59quSZeC6sx0g1XT3LA7d2cLyi4OH0N10i1R0D/
         jmb8mf0KtsAuXvFVjDMZ5u+aVYsTvnbZq2qsQ//9/fsKlzuAoJq3t1TuXCN/U8I+DG
         mgrbSuazAGp3vIlbA33/LbTCaz1dR/lmXPpKy4QwkqwYOwHr2YIrojSAtnmYcFiBq3
         K2MH/+rMxoDkrm2lvLPP02ENQk/UR5ZWAd0ldpFDaaUwzYLbBZ8K1h9BuJEsp1Vm81
         URzabGVpcajQ55ag0CGwqx70KO4ltA3kzH2J4ifam1z6Cj2r8hMPLJ3/8uQ/acXw55
         dO/W659/ZvgMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYp5R1Qkgz4wZs;
        Mon, 28 Aug 2023 08:19:38 +1000 (AEST)
Date:   Mon, 28 Aug 2023 08:19:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the loongarch tree
Message-ID: <20230828081936.04a37e50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E7eGcE2FPKIhEnjza+rVi0m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E7eGcE2FPKIhEnjza+rVi0m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8968eb010689 ("LoongArch: Add basic KGDB & KDB support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/E7eGcE2FPKIhEnjza+rVi0m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTry/gACgkQAVBC80lX
0GzUoQf+MtAO33Bj0/4yFJwX3Q7RSJZGbSkzzf+k3nyFwJqvxlN+LcoKQT3p5aqN
YE3ajU8Djr+1of9GLnAGYnmFo/2jXRmJMNTriS2/19tw1iR+siLwzqYs4Q3nZRjt
qJqs9HoOMtZTNkEkCRisMICoB34cpV7Glz+eGrf8lAl1xHzZFUgrM52QV4FbgpPE
5dCvfsKR/8HskfdEYpQ7g0V5/rwN7dI9gLPbsi9rpLpeQ9sAZ3r4XpDSuiahlsXE
bt23nW5l2vLte8k65CC48w8YVBGzu51S4boMfuGHjcj9d+MjpcUHUE076v61a88B
OPFqZOR1Act3fQKwffx8B7ZRCH3y/w==
=2Xb+
-----END PGP SIGNATURE-----

--Sig_/E7eGcE2FPKIhEnjza+rVi0m--
