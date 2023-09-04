Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9D791A18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbjIDOy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353155AbjIDOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B91A5;
        Mon,  4 Sep 2023 07:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE02F61807;
        Mon,  4 Sep 2023 14:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E72C433C9;
        Mon,  4 Sep 2023 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693839291;
        bh=kHX+GKJ0chj021Ft9S2U3HGs7VV1HiFyRZsq0upjaBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7/JM1sw3c98d2Cl7C8gF3IuKdInMaXcKdOIJMDNJ0hJ0KNQZ26VFDPfFieI5sU3m
         aoHsUDZEOv/8Smm+30xrzsN/hfkyLgx2FuiEPukvQ9NNrEkU+JEPJ4VZ4jWvZ3Y+SI
         Db47yf8vPwhwpoEbH383W15rf8SN4nSjJOxHErTT/1rEdWGzMkUqo/9BNSVZEOabB9
         0YjOmHHU8tFisYOh+twdBu0jPtnB7bw1qoECvbsV48TbzaUb1+s1dCrPbStGTjbD60
         kzvhngj0goghdB7JVxQT5D3WlxgR0Gf4Xga0ZXfn5oX8DtD0aiC+MChZ1tcF09yEb1
         aYKtSeaZ3TEXQ==
Date:   Mon, 4 Sep 2023 15:54:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wangweidong.a@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rdunlap@infradead.org, 13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        yijiangtao@awinic.com, liweilei@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
Message-ID: <1f2c1824-8f25-4cca-bce9-412efdc7e4ba@sirena.org.uk>
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-4-wangweidong.a@awinic.com>
 <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
 <598febde-429e-4319-98d4-4306a7f8bfe8@sirena.org.uk>
 <0360d279-b535-f3f2-9651-07dff2df2e37@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMB7pEBWQ6glURkN"
Content-Disposition: inline
In-Reply-To: <0360d279-b535-f3f2-9651-07dff2df2e37@linaro.org>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gMB7pEBWQ6glURkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 03:02:31PM +0200, Krzysztof Kozlowski wrote:
> On 04/09/2023 14:30, Mark Brown wrote:

> > This is very common good practice, as well as validating communication

> No, it is neither common nor good. The kernel's job is not to verify the
> supplied DTS. Rob also made here a point:

It's certainly a common practice, even if you disagree that it's good. =20

> https://lore.kernel.org/all/CAL_Jsq+wcrOjh7+0c=3Dmrg+Qz6dbhOUE-VEeQ4FoWC3=
Y7ENoyfQ@mail.gmail.com/

That's a very different kind of error, I'm not clear how we expect
schema checks to identify a mismatch with schematics...

--gMB7pEBWQ6glURkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT177IACgkQJNaLcl1U
h9Aepwf9HfnVU+/68EF3o8tS7Kx2TTa0iMeCySpOvl8DvuC4yLC1+fPBUxmXNiOi
PH8aoyOoHHVsn7tNKbTv5y4IpCdHjuXIjIMrwlW7uVQl98nrsF41vEaprzv04HoD
kb+D99FNTWw67CRfFC1jWYCF0Mysv8RblG9cNmPRXbDH9bvN62nsreq+cpyPdYBV
Ze8eYmDKjJ6/UlebNAnzQ54DRDzFXaySqLixI5dApIb5w8QIJbGw4juO5GEDpZzR
IlTLTzQpcpxUZT6qk+ocxqdHCn993JBy+XjSXXRjMFFSkvP1U4GtEA3GHnWBuwRO
QwyeK3YSY2PbI5oAAa/aiizr3nF5dw==
=4I8V
-----END PGP SIGNATURE-----

--gMB7pEBWQ6glURkN--
