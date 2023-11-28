Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC287FC282
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjK1OF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbjK1OFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:05:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2541DC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:05:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE82EC433C8;
        Tue, 28 Nov 2023 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701180330;
        bh=PWGD0Q+7jbU/hEhE2QDdSvpUB2FcPsMgtik10UeqFfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GB2Ss/syOaatgt0ijiEYYAdOHi6DQMOmGfbn5GB2udg59QWQ7oETGvh+H+woSOZP+
         ftS3Yjk8X2DwVDg2xUpkjniIgWHOEJtIyZWn4rT3WXoL7rrSf4Ry1e3TsJekkuxOAr
         nypBNSGUW4k4cCITq2KpHiuEUU5MxfMxPNGjGyw8IIW/c1UCuP876ta7a98sX5ODVh
         OsEsqywYmXOiRjXc/k7GiLEYch20MOt/DM/takQdyVg1Dkg753FUvTnzxJhB7Vh3ao
         ZoCgj4HtC1AFJE6ZxXfGNKwAGdfnjKnpMF8y+3ToIeoT24ErcgslNbz718R8UdThRD
         /xiPUnrBk11Ng==
Date:   Tue, 28 Nov 2023 14:05:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-ID: <a161321c-a2b9-44a6-bc7b-ab2096916108@sirena.org.uk>
References: <875y1nt1bx.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FFflOKuc5OBmUHnu"
Content-Disposition: inline
In-Reply-To: <875y1nt1bx.fsf@5harts.com>
X-Cookie: Must be over 21.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FFflOKuc5OBmUHnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 07:42:30PM +0000, Malcolm Hart wrote:
>=20
> This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-=
mach.c
> to enable microphone array on ASUS Vivobook GO 15.
> I have this laptop and can confirm that the patch succeeds in enabling the
> microphone array.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--FFflOKuc5OBmUHnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl86UACgkQJNaLcl1U
h9Cp0Af+N36G4l8WUklwNAG97NB3FEtabA1JGwkPGEiTJAhe+c4fEGwJ5KXznAMf
1Y1ViSm1vS03Vet3yTJ9W0LxX9paf3sqw3lduADaulVHzztJ8KGDDydeFUqGKnr/
WEAzukqd8omhr2it6KyvNDdCozGon2qvnFSwSrsEKrjA4o1ZmLs2QKGDkgg9pI3U
UiktthHN1ZAHMBKMkSb+fkBy7zTSgUGfF6/9/VWvlbtIKk7sMlYXVUDkXUcPMC2U
XR/W4qC2nwkcXgBbYws3O4U+hXIaXULGXmM7pZIMbS8QW6c5oGduONzTqddmmx+h
Mmjs18l+JbOlOp4ko9X5jXY0w3NYpQ==
=vkEH
-----END PGP SIGNATURE-----

--FFflOKuc5OBmUHnu--
