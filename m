Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4C7F4E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjKVRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjKVRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:36:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDF19D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:36:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4854DC433C8;
        Wed, 22 Nov 2023 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700674598;
        bh=Vza99+xtq+1wLQeh3rk7M9wfNhph6mzwpTZ+i29+N5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu8lf+UQ8lxS78Mxw93tY9qK+MnxSy1BtNRiLd8+eS9R31GqQxBBks3Gzx0pFkbcy
         doqzjlz/x1XXXLbJmai3iZKJbx29szV2aJidObn4mHv49HHst47H0JReAaH6mCB3/r
         JpLXyIbeatYpCd1+ek6uZhbMXrvRsthb8ZkzRs/M1yte6Hutyh31Y6P7yoRPFYOzcL
         cM+/FVpaTqjjN3KLj3qqKS9JVO6MYw8fYDkXu3wJ2OBnXh2bg6nkmF8N4inruHZZvP
         BQQBaC+DUmDBc1t8nQ+inJZWemDM64XSFPhpM/klRR5Sq1o/wvzVEHJsepeXc6UJia
         aVkW3mkMMwNew==
Date:   Wed, 22 Nov 2023 17:36:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add OpenCores PWM module
Message-ID: <20231122-jokester-reapply-eb000d976d56@spud>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-2-william.qiu@starfivetech.com>
 <afce202d-6234-4c5f-9018-facd9a56b5eb@linaro.org>
 <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
 <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
 <20231113-sprung-tantrum-94659009b9d4@squawk>
 <1ba3e8d1-ed89-4aab-ae27-d8d31ee2f150@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9e0gDyQKikb1dEdb"
Content-Disposition: inline
In-Reply-To: <1ba3e8d1-ed89-4aab-ae27-d8d31ee2f150@starfivetech.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9e0gDyQKikb1dEdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:03:36PM +0800, William Qiu wrote:
>=20
>=20
> On 2023/11/14 4:17, Conor Dooley wrote:
> > On Mon, Nov 13, 2023 at 09:07:15PM +0100, Krzysztof Kozlowski wrote:
> >> On 13/11/2023 10:42, William Qiu wrote:
> >> > Will update.
> >> >>> +
> >> >>> +allOf:
> >> >>> +  - $ref: pwm.yaml#
> >> >>> +
> >> >>> +properties:
> >> >>> +  compatible:
> >> >>> +    oneOf:
> >> >>> +      - items:
> >> >>> +          - enum:
> >> >>> +              - starfive,jh7100-pwm
> >> >>> +              - starfive,jh7110-pwm
> >> >>> +          - const: opencores,pwm
> >> >>
> >> >> That's a very, very generic compatible. Are you sure, 100% sure, th=
at
> >> >> all designs from OpenCores from now till next 100 years will be 100%
> >> >> compatible?
> >> >>
> >> > My description is not accurate enough, this is OpenCores PTC IP, and=
 PWM
> >> > is one of those modes, so it might be better to replace compatible w=
ith
> >> > "opencores, ptc-pwm"
> >> >=20
> >> > What do you think?
> >>=20
> >> Sorry, maybe this answers maybe doesn't. What is "PTC"?
> >=20
> > "pwm timer counter". AFAIU, the IP can be configured to provide all 3.
> > I think that William pointed out on an earlier revision that they have
> > only implemented the pwm on their hardware.
> > I don't think putting in "ptc" is a sufficient differentiator though, as
> > clearly there could be several different versions of "ptc-pwm" that have
> > the same concern about "all designs from OpenCores for now till the next
> > 100 years" being compatible.

Perhaps noting what "ptc" stands for in the description field would be a
good idea.

> After discussion and review of materials, we plan to use "opencores,ptc-p=
wm-v1"
> as this version of compatible, so that it can also be compatible in the f=
uture.
>=20
> What do you think?

Do we know that it is actually "v1" of the IP? I would suggest using the
version that actually matches the version of the IP that you are using
in your SoC.

Thanks,
Conor.

--9e0gDyQKikb1dEdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV48IAAKCRB4tDGHoIJi
0nnhAP0dO+HuU6VJxyhYQTYCOgtFy1M7siCtU/9xX8hHaon4MgEA3d9vorRE+CH8
uSLzgEykIwm2UD5v+hkW0uBeHJrQ8wk=
=AWCX
-----END PGP SIGNATURE-----

--9e0gDyQKikb1dEdb--
