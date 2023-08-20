Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294F782095
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjHTWQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHTWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:16:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158349D;
        Sun, 20 Aug 2023 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692569761;
        bh=LkkEidVlE0Trgy6gpaPNS3Ht0hoYcScCdZ2n3IAi8Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z6EE8NmLph9rW+Azx1Iq3uAOZi34vKM/JpE1qzsbaUKHEF6ecYzivZb+OFvremBtT
         IVBSZLDtYsKgMUEjSw3YHQae1U6m+M0z1Jylutt9JPurJqNN9zh4PwiZ7Qyq8PI2iW
         v+VkJWPX3cdJ9euTBwux2ZcM2azwkYQ5oN+7qoxQXCBlgBkKZkJSKj662EDNlwI2rB
         DR0tjjKQ3MoHkcnUqlr6zbKOeaD3Bwx+DRrCxY739dEkvOTpdPLMGiLIhLpA6T7uy7
         xiLkxZz2JDMvo6FE+bni7jZ8TxwH7DW/Y0itYXsNureb2pK4rGGKDjnvODvb1jRtVb
         G4ArcPw3nSAsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTVLS6fPPz4wZJ;
        Mon, 21 Aug 2023 08:16:00 +1000 (AEST)
Date:   Mon, 21 Aug 2023 08:15:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 v4l-dvb-next tree
Message-ID: <20230821081547.2f96b1a5@canb.auug.org.au>
In-Reply-To: <20230815091157.64424ff1@canb.auug.org.au>
References: <20230815091157.64424ff1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1jXLOgC0UVfObI=a48s9/DZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1jXLOgC0UVfObI=a48s9/DZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Aug 2023 09:11:57 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commits
>=20
>   b7ec3212a73a ("media: bttv: convert to vb2")
>   f5f17f0cb5ab ("media: bttv: use audio defaults for winfast2000")
>   7df8d5cffa87 ("media: bttv: refactor bttv_set_dma()")
>   c9c0df318acd ("media: bttv: move vbi_skip/vbi_count out of buffer")
>   0f5f12e40824 ("media: bttv: remove crop info from bttv_buffer")
>   87df33be0548 ("media: bttv: remove tvnorm field from bttv_buffer")
>   9764252d4bdb ("media: bttv: remove format field from bttv_buffer")
>   04d5356512c6 ("media: bttv: move do_crop flag out of bttv_fh")
>   faebe84ebc75 ("media: bttv: copy vbi_fmt from bttv_fh")
>   79bbd3510ddb ("media: bttv: copy vid fmt/width/height from fh")
>   45b6f5bf1a01 ("media: bttv: radio use v4l2_fh instead of bttv_fh")
>   615c5450278a ("media: bttv: replace BUG with WARN_ON")
>   d1846d72587e ("media: bttv: use video_drvdata to get bttv")
>   33c7ae8f49e3 ("media: i2c: rdacm21: Fix uninitialized value")
>   7c8192e8b489 ("media: coda: Remove duplicated include")
>   54921a8f31d8 ("media: vivid: fix the racy dev->radio_tx_rds_owner")
>=20
> are missing a Signed-off-by from their committer.

These are now in the v4l-dvb tree and still missing their SOBs :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/1jXLOgC0UVfObI=a48s9/DZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTikJMACgkQAVBC80lX
0GxjUAf/T4HjECwybuBVzALmIEZ860WoI8Cz22PewKpIgZfavfRUpgV1OYwvy+mi
YxR0erFsxbKWMP6sVREQ6Ruk4HP58g7Xbbo/RqwUg8jxcluhuFfCSjPwFqPXzOjm
D4dtkWofRyVLZCcSBeDcRZ45T8siD2aRYeajkARdhjcRyL0tB7sfDETOVsUeXTL8
NgpQi4E89Gd2Uh8KLLXhbeUzZV6P7Tv73kewIfUDiNiCTUW0iUbIDeyGLC1/zNk3
QHYs1JjcYhlFrM8DyHjnrvdSXKCEfJ/uZDpWjPRhGmm+J8edX1dv9NjoGBgMmS72
iARq2nQoAsV90Xo/QuHVGMuoInhTTw==
=JUWB
-----END PGP SIGNATURE-----

--Sig_/1jXLOgC0UVfObI=a48s9/DZ--
