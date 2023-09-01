Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEDE78FE54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbjIANdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIANdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E4CC5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7549F621C7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 13:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098A9C433C8;
        Fri,  1 Sep 2023 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693575228;
        bh=53riXEAEWBAWwbcpkoj7HSeYZAeJjS2cmm5QdmWuqHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQUHjIH7xxLqDQtDrWnKbVZwBPduSgA+oBpsUMp4nKqE3sLvpg+vz1UhIV8CxGJxK
         EtSSQPucmr6BOvc7DuY/jTH7mbZEWh9ZMddh6thfQ6l9zLczXHvkjZiuixtTCD67F1
         hpey3bQYVLjFoWRs3xk3KCL769dTBbzgIFLjEGRYBBjxO+4vcZ9XS/YAyccV+//0Pw
         hXO9mBSoa01sdNrOWoa085J7gAr909UMJx4lElTUrnuvYrj0pUFGd4ocAPhnmBaTrw
         GEBh0bYqpINw67DuaI9Sr7bIT4obRLOpLsjMKynU5QYknov64d+R9uSC+bJTmdiSFW
         1FjzVc1fyvXTA==
Date:   Fri, 1 Sep 2023 14:33:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: wm8580: Remove trailing comma in the
 terminator entry
Message-ID: <c4c13a22-39c4-404a-8c53-c110e44a9b56@sirena.org.uk>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
 <20230901065952.18760-3-biju.das.jz@bp.renesas.com>
 <ZPGmiWDErxnjGlMR@smile.fi.intel.com>
 <baefefc8-55d7-430a-9ec5-2c17c4577d11@sirena.org.uk>
 <ZPHk9tSC64clliFc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R5XR92iKDBMMA7+G"
Content-Disposition: inline
In-Reply-To: <ZPHk9tSC64clliFc@smile.fi.intel.com>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R5XR92iKDBMMA7+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 04:19:50PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 01, 2023 at 01:54:58PM +0100, Mark Brown wrote:

> > So do reviews which focus on very pedantic issues like this one...

> If you fine with a series as is, take it!

We are in the merge window right now so if I queue things I won't
actually apply them until the merge window is closed, meaning I need to
keep track of what's queued already when new versions come in or
whatever.

> It's really nothing to bikeshed about.

Well, quite.  What I do for these very minor issues if I do end up
commenting on them is mention them but explicitly say that the comment
is more for future reference and there's no need to resend.

--R5XR92iKDBMMA7+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx6DUACgkQJNaLcl1U
h9B4tgf+PMzMgvBAKiUpSFPeQBFd8Wuv/pTMGwku/Pi+AExyReaSaaxXWEUdlQrp
C1iGcgBCXhqJB4y8oUxoq2BecmIbdVdSS7Hb9gAnAI3Gg4cDcADuptzBNBckTmFK
3y0ma+g2KvjtLtfoe9biMTyrR4sq2AWqYBzpacoesW6ybygk4kqDkvyKvd3yYaDW
5BFwZBjKtrrPkvXvLO2ho+6u6cc9wMqAPKJyfksBBXPQQITzFYDpgMIH7LF4viQg
JIhmzHobXVVYOKHc9Mchpwn/Z/WrAJ1AxDiuuxI7Epa5Eut1HJ2aPyhIALEZFbFN
R4+DpGuSDF/Se5fH1vEj1vf0ic1sLA==
=90P1
-----END PGP SIGNATURE-----

--R5XR92iKDBMMA7+G--
