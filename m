Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736778FDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjIAMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbjIAMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2740E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BBAD62C5E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7066CC433C7;
        Fri,  1 Sep 2023 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693572903;
        bh=v+RCs19kOWar+rgrrH/bMdmvLgmSNZkRub0yArkOhOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRWn+AzlC+HmC2LzMsKkCwnThcoUn7iltXvxrz8+fwbcAAXD73Zib2dHP2cjtuJOt
         Q21zPZt2FSbHgfJ06gx0z2Jpe92umZwjcB60tHAbT3FE1a4LAM7iPKwiHqk79CKsEy
         mf09hddfOSMeSM0jL9l5dLel+l2z/t6eozXkrHbQTHfsq9KfHu/MYGoplUYMWFL0TR
         TYncpOCvdgUdqWVavgK6QgAzvXo49+l9J2TiWvr52NfK2scelscRpN1gxnvh09V/vL
         A2Mhy9CPYjN2LN5sd+MxY1Ubv8KRfNniU1n0hvPgeI7qengj54mZObQHfaHAX7Ri4Z
         X2vY7mEv7P9yA==
Date:   Fri, 1 Sep 2023 13:54:58 +0100
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
Message-ID: <baefefc8-55d7-430a-9ec5-2c17c4577d11@sirena.org.uk>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
 <20230901065952.18760-3-biju.das.jz@bp.renesas.com>
 <ZPGmiWDErxnjGlMR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NhC2TJUJTC94pOK8"
Content-Disposition: inline
In-Reply-To: <ZPGmiWDErxnjGlMR@smile.fi.intel.com>
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


--NhC2TJUJTC94pOK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 11:53:29AM +0300, Andy Shevchenko wrote:
> On Fri, Sep 01, 2023 at 07:59:51AM +0100, Biju Das wrote:

> > Remove trailing comma in the terminator entry for OF table.

> You are so fast :-)
> This will produce an unneeded churn as you touch the same line twice in a row.

So do reviews which focus on very pedantic issues like this one...

--NhC2TJUJTC94pOK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx3yEACgkQJNaLcl1U
h9DZ1Af/XKzTgRf9dZvjRu0YrfdFEXCailhkaR0xnA2hJbJyVjTetgyEudatrdja
+sGgS1I9EpzJ3cMyLZMDXJcXY00bQsQ1iXFei4UEscCZIWxYLtOt4dQkwp7S9M+p
RbMQM3c19w+d5/3Hnv2wzCH6Lio8NRgfwBzckAQh4SEzx2Fid/WVb7mXJZnoZvRC
u17iGZD1Akha1zMppU5xvXmhUOL9qsC+e7Eoi11nGUDZsgeg6TvjMViEdAPN6vEw
YZO5EQHehyE2THEY+BpKeQf0nMjU8t7wcolkfRfBjNX+AA1VAUaBCWHbH7v/t0yC
5H6ugtuqPsuRTBPD5bcOcodfC3i3dw==
=mEvZ
-----END PGP SIGNATURE-----

--NhC2TJUJTC94pOK8--
