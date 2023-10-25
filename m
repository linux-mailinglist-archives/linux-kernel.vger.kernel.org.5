Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E07D71E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjJYQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:50:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751C185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:50:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7D4C433C7;
        Wed, 25 Oct 2023 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698252650;
        bh=tKfGS3mdC3h55btqOQSoMjiLwFTWyJK9WDQombLWJnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1S2IEoFbdLqmXm/viWjpM6NKGNASRcjfX2fZJI4RHr2fDVRoiLCIqO3Boht2/nDi
         RPR1y1Jw4HsMlpdfYqLMyy+KGQmcz14OZKmEthDgv3S5r1aye22NHTJnp0lh1fyrX/
         ojJmHHOmdCLRdJWoz1TgalzSl6LeCPDbZdCgdm1yUxcO6J5IIQ8Oi5/K/kIUBGFVCa
         vpb1yl3ikirmAwdu7etEsLVzlYtWvB8ruE5T6kr4Ug7m5+5HXXTRqwmkIPSU7K998P
         5NYaIPm/NHdqaofNtP++lxb0Z6vOzg8OuimecgsX8Wn8WpVNfZq+YI8L4IL54XB6Vb
         ohfhTfHfKJRuQ==
Date:   Wed, 25 Oct 2023 17:50:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, venkataprasad.potturu@amd.com,
        arungopal.kondaveeti@amd.com, mastan.katragadda@amd.com,
        juan.martinez@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver
 support
Message-ID: <6737a19b-e7fe-4f71-8a78-bb6641ef067a@sirena.org.uk>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="38zF0B7y5SHLAe5+"
Content-Disposition: inline
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--38zF0B7y5SHLAe5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 21, 2023 at 08:20:42PM +0530, Syed Saba Kareem wrote:
> Add pci legacy driver support and create platform driver for
> acp6.3 based platforms.

I've queued this series for CI - there were some valid concerns that
Amadeusz and Krzysztof raised but they're relatively minor, please send
incremental patches fixing these issues (assuming CI is fine).

--38zF0B7y5SHLAe5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5R2EACgkQJNaLcl1U
h9D2uwf/Va2K24zGuvAUR9qxV9KY8tpVbPjMNGc5Ir2a62mmQM/ZHNUpAZ4oNjdA
cxA+hZYK4zDT6xv92tIumgsRVA8IPHSC0mWrcHzHQhd7UllWSE4Od7l+OIY83jck
c8tplZIdX4u02e5JouzCtawktxXF6OhITSBhbGEo0gK09/LY4E0lWZdXW3h+/hxl
F8oytBa/vsdx0L9b+waZVBc7PpKxETvZV2Yb98UAzO6gWXbGC5Vx6WFOQubufMNe
V8GZLjwdCXXH4i0rvpt17JtMN7X2YMub8CacewUcZ9yU6a8TDaHoHiOBLOJ+sOCv
CgCuu59wH8Xg0sInTGhI6vyhEmaxgg==
=cbvt
-----END PGP SIGNATURE-----

--38zF0B7y5SHLAe5+--
