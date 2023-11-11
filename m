Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5647E8ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjKKLjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKKLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825173A9C;
        Sat, 11 Nov 2023 03:39:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59854C433C7;
        Sat, 11 Nov 2023 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699702761;
        bh=rTPhRXHcBu3FdnF5esG7WBKJ0Idng7F9RzrodK0bdSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWixJ4xzkM5iuRIeqOxmh8hZZoNu2GuNqAdD7KRNB1cCvDvGjyUZe/TMewqJGtPuB
         eBgUD7cHlRFhd5JqBwwSOLW6sBipH5fr6+5nHGyKdoNKMzmVOvbBRmL/W8TkO9ygpp
         +sfHhxlFVwRqzIPFthrU9HLS93/y/1Z5YTsJ+COUfLVLqQtVpq7Mu7Pk9pE1Fir5Ho
         2DRS8hEEwlcdF88YHtZ3U/XrpvkgmlBWqPzeOpUpLFxr36Z3wRoVvTQ8JByWEl/Ow6
         AsDqNaqDviV3LswdZooMJdd1W3rDftp/act6vMBVu/+eXuTxKu5rl9qCjU7/wfNtJl
         aH88akbQpAz2A==
Date:   Sat, 11 Nov 2023 11:39:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Message-ID: <ZU9n5Y8DxZt4QYRO@finisterre.sirena.org.uk>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <4855402.GXAFRqVoOG@radijator>
 <ZUjG5tUrBvm6PDvB@finisterre.sirena.org.uk>
 <1880732.tdWV9SEqCh@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NMCFkAyahKpkrrIE"
Content-Disposition: inline
In-Reply-To: <1880732.tdWV9SEqCh@radijator>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMCFkAyahKpkrrIE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 08:28:56PM +0100, Duje Mihanovi=C4=87 wrote:
> On Monday, November 6, 2023 11:58:46 AM CET Mark Brown wrote:
> > On Fri, Nov 03, 2023 at 05:58:05PM +0100, Duje Mihanovi=C4=87 wrote:

> > > this correctly, I would have to remove "select SND_ARM" from sound/so=
c/
> pxa/
> > > Kconfig and optionally move the PXA2xx code out of sound/arm/ and into
> > > sound/
> > > soc/pxa/. Is this correct? If so, I'd also split that fix into a sepa=
rate
> > > series.

> > There's the pxa-ac97 driver to consider...

> Can you elaborate? As far as I can tell there are 2 drivers named pxa2xx-=
ac97=20
> in sound/{arm,soc/pxa} and neither one has any dependency on AACI.=20

They do both share a lot of library code and the one in sound/arm has no
dependency on ASoC so I don't understand why you're suggesting moving it
to sound/soc.

--NMCFkAyahKpkrrIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVPZ+AACgkQJNaLcl1U
h9BwEAf+OEf6qc1xLpzXXgYfgJtHBjpbdnuByW2eet0HjenII7+fsKy2Hh/cvZD+
EQ4z1dzENCL67nkzK2YyQTegLduY02qVEIe4CYN18yU/g1SbwcDATwcVbWRoNS5S
yXwGUsBY0Lahsyeuop+P+K4e7z2EDqo9UZyUJi/sUHC4VHzj/ZA+o66k62U/FPxO
0WAdhTto7vXB4fmHB2zZEVNfihwp3YjFEId17tnp6DfHlldgQTd8Vs7LuANofRuK
dx3t66n6gWek0MvGYPeCzBCHdTzN2P4iqTHxFRmLUARkA2txeM+uwahng+/XI4SZ
rpaHK38Iu4+CzjK0b41iz68AEoAzLQ==
=9Bkd
-----END PGP SIGNATURE-----

--NMCFkAyahKpkrrIE--
