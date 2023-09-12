Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3F79D277
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjILNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjILNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:35:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B852100
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:34:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D78C433C7;
        Tue, 12 Sep 2023 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694525644;
        bh=VbfJfM9sOOPsxv+wZn4Vfk3FxTBuEdVpBFsYpcdpDaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYclrPIUtVBYBadfqV0Ryw7szcbwQJBncSZr5HpNxiSvecLInH5gih2nhcEMU51dJ
         IVRdkQBDOYT/WNEi2dkAo7PeYgvTL2GpsJTvwFgRM4zUENfXu42WQVZPGsnFq2NtJA
         FKl1lWpQmba7P9toALrcJZp58VpgNOvmVBctcZKomyw1G4fZaeX5d6IYEtGxs3iDkZ
         1VG4S698CPOJLjtngMWVDmdZ3d6Prq2UkWc+hb3CrL1GDHks164m0dASWYCqM5MuUZ
         MpyvJUbeeNfqTphJC0rlICmG54+hdWKsU+D50PD/pv1Pc2rxB35eoxIDD6tztxs8Y0
         iDy9ZoHwdsS/g==
Date:   Tue, 12 Sep 2023 14:34:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dwc: fix typo in comment
Message-ID: <ZQBoyKulheGf8h/e@finisterre.sirena.org.uk>
References: <20230911064646.168181-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DRWzJOqD/qMbZEsz"
Content-Disposition: inline
In-Reply-To: <20230911064646.168181-1-mwkim@gaonchips.com>
X-Cookie: It was Penguin lust... at its ugliest.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DRWzJOqD/qMbZEsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:46:46PM +0900, Myunguk Kim wrote:
> This fixes typo in comment
>=20
> Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>

This doesn't apply against current code, please check and resend:

Applying: ASoC: dwc: fix typo in comment
error: sha1 information is lacking or useless (sound/soc/dwc/dwc-i2s.c).
error: could not build fake ancestor
Patch failed at 0001 ASoC: dwc: fix typo in comment

(after fixing what looked like corruption in the mail)

--DRWzJOqD/qMbZEsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAaMgACgkQJNaLcl1U
h9DoGQf/TJUS/g2YbbUbZNg3GI4ImJplDhgpqZge7XpokWGYCEX2sIYeZdrmz3Zp
MKsK0XmClFvOJrjLUUygTTqaepttrDsn8T95vIWwdUX8BqddAGKvDSZ87ymhgcRh
8XdWRJXx/X7NQROPrRmOlE7U36kYIbMh2KgmykwKwjEJuggaOTFJn/9I0Q/CnOsl
So89RmULbpI/68nPmKPZK9/SAogN4ySFSXNXJx9SgDi+p42LCrz/Z2zvZ6L70cNa
0CiDGHlIc3sQQNJI4VUktBA17BtfHUOH8cMR0iPWN+8THH2Y+yjFI/7lsGCxndNC
2YUTVv358liuW5sHKOQA3h6RKd/CLA==
=y//G
-----END PGP SIGNATURE-----

--DRWzJOqD/qMbZEsz--
