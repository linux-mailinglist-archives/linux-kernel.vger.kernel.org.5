Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156557BBC12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjJFPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:46:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD36C5;
        Fri,  6 Oct 2023 08:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885EC433C8;
        Fri,  6 Oct 2023 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696607170;
        bh=RqPT1sAX+CTz+LW7FuFBdj/iCoI5RcSD8+uIrgrjRII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJcW5fQIHClkSNCykvIXtff2T4paynN6ON2HHsJur23X/V+AytMrdMa8Z+YSrMKg7
         wLoYz3k3KY1Aihi0JnyZ0KWWwEyN5hrypUPCfKfqeWiKNrAB/E8y19+9Nu3LqTGaxk
         +HPtFku6IVKUm7vlWyAJYeSDkQTXn3/DMiBsY478ifOr440NNBFjs+X/2ufi9wA+dA
         MTOIP4mB1+OvXOmOhEdBP7zpQfcmuQz55tkVx7xQjc4yUwILkfjoog+sTRlc9dtH/w
         t81RK79s4fmnJhoySGDTNJKsT/illXeqAOUK490U0lrbZa2wa4n4eXXCfapsk9xF7X
         zzzJBk3wtxSiA==
Date:   Fri, 6 Oct 2023 16:46:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v2] thermal: Remove Amit Kucheria from MAINTAINERS
Message-ID: <20231006-earthly-equal-dd5d82312add@spud>
References: <2702191.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aL7ZvF+92viwC5jJ"
Content-Disposition: inline
In-Reply-To: <2702191.mvXUDI8C0e@kreacher>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aL7ZvF+92viwC5jJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 05:04:42PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Amit Kucheria has not been participating in kernel development in any
> way or form for quite some time, so it is not useful to list him as a
> designated reviewer for the thermal subsystem.
>=20
> Remove him from the THERMAL entry in MAINTAINERS.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> v1 -> v2: Drop the DT binding change
>=20
> I'm really not inclined to fight over stuff that doesn't make any sense t=
o me.

I don't understand what you mean by this. All that was required was
putting __someone__ down as a maintainer in the dt-binding, as Rob's bot
told you:
https://lore.kernel.org/linux-devicetree/CAJZ5v0gwvo_CriNwz_g-oQ8EZUqdp4ymi=
uamU-KkrmQ87RhZyA@mail.gmail.com/T/#m56a9b1616477566e2976044c11b58dccbd3be0=
fb

>=20
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml |    3 ---
>  MAINTAINERS                                                  |    1 -
>  2 files changed, 4 deletions(-)
>=20
> Index: linux-pm/MAINTAINERS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/MAINTAINERS
> +++ linux-pm/MAINTAINERS
> @@ -21363,7 +21363,6 @@ F:	drivers/media/radio/radio-raremono.c
>  THERMAL
>  M:	Rafael J. Wysocki <rafael@kernel.org>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> -R:	Amit Kucheria <amitk@kernel.org>
>  R:	Zhang Rui <rui.zhang@intel.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
>=20
>=20
>=20

--aL7ZvF+92viwC5jJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSArvQAKCRB4tDGHoIJi
0tJOAP0RchSWseK6p2cPyt+7A6+5M4M5Z7+A4KOKtDbdtWVzGQD7B25vFO7lmNDy
xfpFomW8uCMUMr0q7VBHLhYrNVBW3g4=
=dNGo
-----END PGP SIGNATURE-----

--aL7ZvF+92viwC5jJ--
