Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3407F146A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjKTNaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:30:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EEFD2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:30:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD7EC433C8;
        Mon, 20 Nov 2023 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700487020;
        bh=PHdu57Wzp+xZqOVNY9Pteh5+H3/OUfTVYEQwZtnjgaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Adn5+nCRh7+2esCt06PpWOJ6Q7Sf9wGWzyL8OZ3xQ4KTuGsVYCl41uUSDvoZM1Qgh
         xYH9OzH46SDNykHqua+lZM2VDAFNJNwAhIazL4+HhuPw4y+ePFT4d4rp8a2u9mWmRp
         PnCbz5w1ll14XS8VhdWdJuOuFS0/ORhBUxPN9LZrU5nM5XwUgSrSc4kXfWDjHIHbGB
         JT3utmOA0eqk2DInnearZCiHRLiXuzkgmY4JBzfMGPTQF/bM9Mo53CgDyCMs/E4vK7
         vEYpztDFwP8Cf9bC1VZuImptYoTJCr3dqt3i1A+skz+dJKGH7DjDkXQ+BECL8kWBh6
         +vMaV+mcY9SLg==
Date:   Mon, 20 Nov 2023 13:30:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 00/27] Add support for QMC HDLC, framer infrastructure
 and PEF2256 framer
Message-ID: <573c9ca1-a560-4f7a-ba21-80673a2e162e@sirena.org.uk>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
 <20231117164746.0589e955@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HuVabfiR1A06kEJd"
Content-Disposition: inline
In-Reply-To: <20231117164746.0589e955@kernel.org>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HuVabfiR1A06kEJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:47:46PM -0800, Jakub Kicinski wrote:
> On Wed, 15 Nov 2023 15:39:36 +0100 Herve Codina wrote:
> >    - Removed Patches 6, 7 and 8 (patches applied)
> >=20
> >    - Patches 7, 20, 21, 23 (patches 10, 23, 24, 26 in v8)
> >      Add 'Acked-by: Jakub Kicinski <kuba@kernel.org>'

> I thought someone (Mark?) asked for the networking stuff to be put=20
> on a branch. If that's still the preference - is it possible to factor
> these out as a standalone series, too?  Will they build on their own?

Yes, can we *please* at least get the generic non-driver bits of this
series moving - they seem uncontroversial as far as I can see and are a
tiny portion of the overall 20 patches.  Patches 21-23 look like they
can go on a branch in the net tree?

--HuVabfiR1A06kEJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbX18ACgkQJNaLcl1U
h9BhUQf/Y8e+dECLekhRMQLy8O0p4YRvMtVtYbyazFL0PEJyvuI93CnL/nqRzW/7
x6zzsmJn2uab1/SmDbu8m5yE2PQDQs448v2ZAIcvu9SOQoH9ph+y/Li1dsCx0MQS
b+VU0vl6YJcBmn8ycRkgBldpLgOoc6HU2tss4FQBAlR2R0Aw6KG97Smd+Py70Yyg
ewedo+nXh+OkOHdJiG3Fbcbw6GwLEoQB+jj2MFy4QA3VilnEu+NBvRxIoegctggc
mPB4GWRQNg9fb57iy6IqsME7oUq1hUb4SJ55O7s88qko3hFJ4ediuncLVP25kbl/
HNP87K6I1Mebqh5LHTcVOvfo8zM/BQ==
=n/vU
-----END PGP SIGNATURE-----

--HuVabfiR1A06kEJd--
