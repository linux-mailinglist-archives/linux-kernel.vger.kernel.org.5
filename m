Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2877F4560
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKVMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbjKVMHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:07:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC991
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:07:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62E1C433C9;
        Wed, 22 Nov 2023 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700654831;
        bh=FgOpIzOkt0J5Z8tPaNlDWaJw0YU3y8AkRtllfRJfNGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7Si9alCKqN80zIFIOgOua+WLimk1dTCXEiKFifealPGQPddSc0E1r8Ccj/kV857X
         Ztkpqbz/FAtumHCtrYC8DzfirPDp3pLghDbdjPr33N01RcXHPH3H7UUksbCQyebl49
         xACEubE4zwvT/jblBO1dS01JhdxlHd/4r5Vm9lpI4svDQRuwCDyTRpUWIfanIPVm69
         kcY4symh75xohuHzCZTUODbF2s0D7KtPfwnDJeHmtgnedef9GE0F0U7SF2D1moNCJy
         8DepkPXC3MD46QD2FNPNXVgj36fwFdTI8WWezGmNjqJTNj8roXHeFGzs9W6tzeI9hb
         V4C51Mv2iMUQA==
Date:   Wed, 22 Nov 2023 12:07:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 29/39] ASoC: ep93xx: Drop legacy DMA support
Message-ID: <ZV3u6/awTLMF56RB@finisterre.sirena.org.uk>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-29-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4/hYSGfAD8LteuZ"
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-29-d59a76d5df29@maquefel.me>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4/hYSGfAD8LteuZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 12:00:07PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> And rely on OF DMA.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--y4/hYSGfAD8LteuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd7uoACgkQJNaLcl1U
h9Bnjgf+Ks8h4hRMIeznb3b40XFU5GjSwLBqJXdTYsRpmrWFf8XPpCn5ZB1Tj2h7
vnfuPeefiecLtGK+9TqlhsgmGxZdwkARIEhfAobCINiHsgVPEXg6PiEW5RovS1L7
SiwJ15K+VE8PwRIrsMAx/lf0Y//YehIXQbbi1kvCcmZ54uY5FxRiUADs5ZDFY1Zg
za6Ru6qtMfpvxpNSJpi6J5v1bUEgeM62CelT7MejyRfw8/JanKmMjS5ZRfi7zQMD
jZI403ejsx4Gke3q5c6cJM34I97pwmWQCC/hgUU2kQ5NiFmF8To1Qp6KEL4Pi6kZ
m+aXz10SZA31YciX5e+dhkUWbfebTQ==
=BU4x
-----END PGP SIGNATURE-----

--y4/hYSGfAD8LteuZ--
