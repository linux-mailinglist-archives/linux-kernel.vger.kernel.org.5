Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFBA77E07A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbjHPLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbjHPLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB593A92;
        Wed, 16 Aug 2023 04:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDEFC626FE;
        Wed, 16 Aug 2023 11:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295EFC433C7;
        Wed, 16 Aug 2023 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692185564;
        bh=2xOS9Ld+w0qO2eM2HA9uJpDMMPYYfr/7NgPud8oJcjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4TPxBFZ0VxAVNBUL9DmPZ/WzSLqdErfVGVGG6Cf1xYYX5Tr78luoHilIefnK3y9u
         tp6bYePWB2W1aHdVpr1W9nBoN8uuFX9U4blYrwdpbktNZ6ajK104hAi1kzKOD2Unh2
         IymCdpE6aDG+LDC6xz6OtfqVDcAR7vXoNKQVWDMRPJWO3UUwVGixNvqb0SyeBCUjnN
         pQpp0ivTtEmHHrVIzFXqQywXWm+39xnI5wHQzOxWcXCVSFf/VqNpCjMm+rb454YLCw
         tfLjfdDuImCDxWtcnwHPDSVdpBdXsjkcA2Iet89eV6XaHZeRLEuK7SypIrx3X0P2Py
         45sWKqoqeB9FQ==
Date:   Wed, 16 Aug 2023 12:32:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajeshwar Shinde <coolrrsh@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that
 can never be negative
Message-ID: <df10d700-3f3f-4665-9197-534abc24523a@sirena.org.uk>
References: <20230813141207.150336-1-coolrrsh@gmail.com>
 <CA+VNjV1=xVyRkvB6RAnLySAOzS=X1XiJihrtiMx3Jmifpdq9ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KL7GBASS+uLiJbx6"
Content-Disposition: inline
In-Reply-To: <CA+VNjV1=xVyRkvB6RAnLySAOzS=X1XiJihrtiMx3Jmifpdq9ng@mail.gmail.com>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KL7GBASS+uLiJbx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 11:38:48AM +0530, Rajeshwar Shinde wrote:
> Please verify this patch.
> Thanks & Regards

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--KL7GBASS+uLiJbx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTcs9cACgkQJNaLcl1U
h9BQ3Qf/USrvotjLsrG2uhdFdBNTSLgoPfyPn7aZfW078uQjRfu2pxAsW/UNZ+06
M9uWCnrvp0j81+XW2T4asJCWFeXGogNs2JIlw76v5YA3PmsZZuu7vZf5pGHyANSK
2X3LnOoV900V2N9nddUfe5eqCUN9KGtiS/Kba++q3fdUxzQdQlDJFqLQrG+m760x
h63/Ey0Vyu1OG9ASs7qiNvuVQvLKQ2Kkp6WehO7ZwnM1vt16gSsgeyx5qcc/FBO2
2rhH8STfTTco6/G6TJw9hnvQMFXHP0x8lQaNlWcchmzivGlrdMb8Bc18Vbl48r3L
iXGaZkd1rr9skkg731EnacoON8SDhQ==
=LppQ
-----END PGP SIGNATURE-----

--KL7GBASS+uLiJbx6--
