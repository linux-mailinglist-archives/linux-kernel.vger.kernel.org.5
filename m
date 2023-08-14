Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32E877C3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjHNXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjHNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:12:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A295210E3;
        Mon, 14 Aug 2023 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692054718;
        bh=2iPS43tVbZSejIbGBQv83EcCJM66h69AjH/VQhfeJc4=;
        h=Date:From:To:Cc:Subject:From;
        b=T31A+azZDJxpVCSLb3mvpSSaY77r8RoL9ZAd9dVOHO/t5RHmKInlqxj1hbpmZqj8H
         f/6Tl61NHqNaeqmCiY3LnIuJcaU6IUDZHhonZuPohcNmu+1xUnGKXwVvcuicgCMjFh
         Q27z64pDpt31NsTBi1MlGI0dB2huTZRMbtZOhCzNGKT8Oz/RjRbkAt0pgKE01EZqnR
         pHtUQ3PnVh6oE17YQQ3G3SVDc8aeNyhD+PNhig02vFkrma9F/ErsGZxMxDbUws5jA9
         69Uaj7uLoVCBpvfgsQ7clr1yVR7MK6f4i2AzQVr2g6sXLGCisER79yFIxZ2tCD9rnG
         apiLhq7iHStbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqsp2khrz4wb5;
        Tue, 15 Aug 2023 09:11:58 +1000 (AEST)
Date:   Tue, 15 Aug 2023 09:11:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20230815091157.64424ff1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mt8QMv7p5MTPKfi7LNru.Wt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mt8QMv7p5MTPKfi7LNru.Wt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  b7ec3212a73a ("media: bttv: convert to vb2")
  f5f17f0cb5ab ("media: bttv: use audio defaults for winfast2000")
  7df8d5cffa87 ("media: bttv: refactor bttv_set_dma()")
  c9c0df318acd ("media: bttv: move vbi_skip/vbi_count out of buffer")
  0f5f12e40824 ("media: bttv: remove crop info from bttv_buffer")
  87df33be0548 ("media: bttv: remove tvnorm field from bttv_buffer")
  9764252d4bdb ("media: bttv: remove format field from bttv_buffer")
  04d5356512c6 ("media: bttv: move do_crop flag out of bttv_fh")
  faebe84ebc75 ("media: bttv: copy vbi_fmt from bttv_fh")
  79bbd3510ddb ("media: bttv: copy vid fmt/width/height from fh")
  45b6f5bf1a01 ("media: bttv: radio use v4l2_fh instead of bttv_fh")
  615c5450278a ("media: bttv: replace BUG with WARN_ON")
  d1846d72587e ("media: bttv: use video_drvdata to get bttv")
  33c7ae8f49e3 ("media: i2c: rdacm21: Fix uninitialized value")
  7c8192e8b489 ("media: coda: Remove duplicated include")
  54921a8f31d8 ("media: vivid: fix the racy dev->radio_tx_rds_owner")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/mt8QMv7p5MTPKfi7LNru.Wt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTatL0ACgkQAVBC80lX
0GyNLggAjkkH5OcZ7icUW9pNQnp3A5C32AjbtbWrxj0VS5FOKMzsXpJktg4d4enp
YmbgHPGosqbCilmIUPbmmOeuaMtZGdRDQ4BD9FSF90T61fkP6vQ4jPGSaWXz9Nkr
wNH2qoYQiGVs9SKeW+jBY81TMhMFT9yRPlHtnt7Ionelzk1/PV3wM2KBcochceZx
3qec7X7+PaBwGaQcbabuwngbvHc5ttPzTmlZ6f7Ij1zhRJridGPCCs3YAzkItB0V
XHFvP3Fz5+n8BqRxWfeEMByXSsr/BR6lgFzuCSFWfc8XAlBXddxUSQoI1E71fEih
4ysQojE5PfenKhSeC61/P5JvQQa2aQ==
=ddDe
-----END PGP SIGNATURE-----

--Sig_/mt8QMv7p5MTPKfi7LNru.Wt--
