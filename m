Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4A7FA13B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjK0Nlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjK0Nlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:41:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A199
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:41:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B674C433C8;
        Mon, 27 Nov 2023 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701092501;
        bh=f3BQHuMYi7jlc3CvTz+C/tQdYT/Mcv85re4DWN0keTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpqEIMdln6ZmmiZtmAWKq/siGwB3UxlsVq7rZTD+fWjb7rC97XFbYgpQrjb2krMIq
         8Sy00hO4zsqDYcRRTVkw01jSdozpS2oSA2o/FPwRrEC4sBJH7FE1rqZnEqziJgFgVm
         T99Gl31xIRII/AwJFUIWTZbRHnVWkuqgKyVF5mpeBGB/iQ2jgnHfIqsmbezzQz6E5c
         lUrAMVx8nwxXypNLP0/hrW5VAvXKMXknPgH2eGsA7aj6pIuN7sEM3Rw4tVvOw2VoL1
         Ib6v8nnM6Iuy2mguXAcMElJgwomBPccDetFEVnxxT490vHUfSaaCvPsXnuLseio6S3
         W//aHq0/6gJYQ==
Date:   Mon, 27 Nov 2023 13:41:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Message-ID: <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk>
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g8U18o2ouH88KqKG"
Content-Disposition: inline
In-Reply-To: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g8U18o2ouH88KqKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:24:59PM +0000, Malcolm Hart wrote:
> Like other ASUS models the Asus Vivobook E1504FA requires an entry in
> the quirk list to enable the internal microphone.
>=20
> Showing
> with 7 additions and 0 deletions.
> 7 changes: 7 additions & 0 deletions 7
> sound/soc/amd/yc/acp6x-mach.c
> @@ -283,6 +283,13 @@ static const struct dmi_system_id
> yc_acp_quirk_table[] =3D {

The patch appears to have been unusably corrupted by your e-mail
software and is also missing a Signed-off-by.  See email-cleints.rst for
some suggestions on configuring things, or it might be worth looking
into b4 and it's web submission endpoint:

   https://b4.docs.kernel.org/en/latest/

--g8U18o2ouH88KqKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVknI8ACgkQJNaLcl1U
h9DEbQf/VOKtiPwxU5ySd49oW4bpnDNSU118nM6uQupgCYR/yaVImX1SSm0oLZjg
BKYm5jaj1zChar2emI33Jev2ffjqGLOn2XHM9eyn2APjiQtB8stIHZIi1qj5Pkeu
iApaUpc1g4Esia9606uptwLk/YDydl1P5qWs/0guseaJISnU76hIxQ4E96R4uB7z
HCMDac9KRvihvI9eD7GoJ4fNiOhAJZe+9BJfx3JBsR8ctnjHdeq8sjwOWeeg3lNZ
VxSzoyf8IjQLlJZ1wC0lB3MAUsmPEqvSD4t2yFGEuMULbaGeOtn2gcemHxLm9uKd
K9XEZ4NPqhBzUi8+qn9V1I0UxTDsqw==
=DBJx
-----END PGP SIGNATURE-----

--g8U18o2ouH88KqKG--
