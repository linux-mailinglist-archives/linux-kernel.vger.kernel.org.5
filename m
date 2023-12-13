Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0D8119A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjLMQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjLMQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:35:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8810D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:35:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B68C433C7;
        Wed, 13 Dec 2023 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485343;
        bh=4LXlGDFMgyr68Nnysznfjyj9ckhbpcDnviA5w6YqYzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojrb3u9zQbEZq88mjdLSFt5osphF7b828MWOhnBscWwBAZ8xZF6XPU3IRBBkBuO2o
         hCgyXMw71QMwJUg4ysh0+QPM/jK2h88qhJvtroT74Tv4efhS+T2K5GzqE1z30bkapu
         5oToqrR5o0k7JcHOhMdVBWFkUgr0FT05F/s/iAFwpO7UcMLlYmjnobt4SeJ8lm/Wi/
         m5iNa+//m1cUgpflGCMlshdaJEHCF5hIv78aL8yV2HrNLp73uPJYdopBSXuFUy5EXK
         Ey068CDzxzK7V/C2PpQ8wRX9xZuKseAegY0x+yqwEDxTkcJe3LRuJmrw0Y1vLp0Jb6
         ZSaVIevfjeZhQ==
Date:   Wed, 13 Dec 2023 16:35:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, leyfoon.tan@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, samin.guo@starfivetech.com,
        wim@linux-watchdog.org, xingyu.wu@starfivetech.com
Subject: Re: [PATCH v2 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Message-ID: <20231213-rectified-unmindful-4064c852930f@spud>
References: <20231212-shout-bazooka-714aeda42ec1@spud>
 <20231213025759.812453-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4L9gi5aM8FSFnIIA"
Content-Disposition: inline
In-Reply-To: <20231213025759.812453-1-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4L9gi5aM8FSFnIIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:57:59AM +0800, Ji Sheng Teoh wrote:
> On Tue, 12 Dec 2023 16:47:59 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Dec 12, 2023 at 04:46:00PM +0000, Conor Dooley wrote:
> > > On Tue, Dec 12, 2023 at 11:17:31AM +0800, Ji Sheng Teoh wrote: =20
> > > > Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> > > > watchdog.
> > > > Since JH8100 watchdog only has 1 reset signal, update binding
> > > > document to support one reset for "starfive,jh8100-wdt"
> > > > compatible.
> > > >=20
> > > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > > > ---
> > > >  .../devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> > > > | 2 ++ 1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.ya=
ml
> > > > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.ya=
ml
> > > > index 68f3f6fd08a6..02572b16ac08 100644 ---
> > > > a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.ya=
ml
> > > > +++
> > > > b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.ya=
ml
> > > > @@ -27,6 +27,7 @@ properties: enum:
> > > >        - starfive,jh7100-wdt
> > > >        - starfive,jh7110-wdt
> > > > +      - starfive,jh8100-wdt
> > > > =20
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -45,6 +46,7 @@ properties:
> > > >        - const: core
> > > > =20
> > > >    resets:
> > > > +    minItems: 1
> > > >      items:
> > > >        - description: APB reset
> > > >        - description: Core reset =20
> > >=20
> > > This relaxes the constraints for the existing devices, please add
> > > per compatible constraints to avoid doing so. =20
> >=20
> Thanks Conor. Just to clarify, are you suggesting to add what was done
> in v1?
> v1:
> https://lore.kernel.org/all/20231209142723.2060196-3-jisheng.teoh@starfiv=
etech.com/

No, but similar. Add numerical constraints that vary per SoC without
changing the names of the resets on a per-SoC basis.:wq

--4L9gi5aM8FSFnIIA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXndWgAKCRB4tDGHoIJi
0iCLAQClOkC/ciob6Ansbhsbnv/f61iWTxGEI3jkSQ7cRWPsTgEAmuoWCDNApKzV
SQLPa7fNyKAA6scBpe1/INPPGNoU8Qs=
=ygGO
-----END PGP SIGNATURE-----

--4L9gi5aM8FSFnIIA--
