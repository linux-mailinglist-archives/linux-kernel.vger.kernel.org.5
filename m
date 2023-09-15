Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113AA7A1EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjIOM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjIOM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:26:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD62701
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:26:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768C7C433C8;
        Fri, 15 Sep 2023 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694780772;
        bh=JOeaiOvA9aSzfqtb72DtC8F5kZInpmUOpbcL9asatYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqsAO6gfiPtIyCZa6PvfTrsBBx8PbvTyahGSVVl5JCl68zD/er9oQ5a1hf9IfFfnu
         sQtcx+14SO2pE1jJhLZmlqDM8fcWLaSaPFqbqlqBk1nkCLKU6kJePXDSRk5De4cW//
         zEJGITFYLVuM9LLOhNUb2phka7l8RsUko8Dh2vNwb6yO0h0q96/3qMpAAamAqC7Ya6
         V4JJhMHFT0YHF/F6g10zOyvXFZJ888T/ixbJ6r7LPwLW9aanT1CTrxSbRUC658437F
         MNM7ND6wf/IVaidLRNfEtCs5D0mw3kFCCH198OD2YRGmRq7L3P2cGMiEnwbM03BLp+
         8MNl5kLPYclDA==
Date:   Fri, 15 Sep 2023 13:26:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 42/42] ASoC: cirrus: edb93xx: Delete driver
Message-ID: <63fd4212-6544-4fa3-b10b-f7f38137b06c@sirena.org.uk>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-42-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WBj+u/ilrjOP7tNM"
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-42-a1d779dcec10@maquefel.me>
X-Cookie: Gravity brings me down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WBj+u/ilrjOP7tNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:11:24AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> Can be replaced with "simple-audio-card" for the rates up to 50kHz, refer
> to commit "ARM: dts: ep93xx: Add EDB9302 DT".

Please use audio-graph-card2 for new systems, it's a more flexible
replacement.

--WBj+u/ilrjOP7tNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUETV0ACgkQJNaLcl1U
h9DUgwf9GWnPbx+GEF+jTZxt9NpWNVd7+WyyyAyfFMpRrGXjysCtrKkWTDFQ/uJ9
e2UK5xCHpf0WVNmGDG0WRvlgzlI5POCCE9H+YkIPBBsGQZtnxmj57PLRQpv1DYlL
YUuCITGE67RgEMwQHRu6XJh9gW5PY9deRRaKWW6+kWFNiED72G12gOB1/obftnUh
A7EowQO3vQrAGDG4dic9OvUbZ66ihwd+t9BDtWa17rmo/0lZ3eahi6hu2pCegArr
Avi5x/S2zdW2Bns7BbwxFcaYfuhX3psY9cszsw43tGWs9ZZNQIRltCi/KGONgl4H
6lDc29Bhf+aYxXDaKsch4Bq6oAxDcA==
=hBHf
-----END PGP SIGNATURE-----

--WBj+u/ilrjOP7tNM--
