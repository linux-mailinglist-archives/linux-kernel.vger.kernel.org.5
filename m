Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5E76EE21
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjHCP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjHCP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC3180;
        Thu,  3 Aug 2023 08:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9668161DFB;
        Thu,  3 Aug 2023 15:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6828AC433C7;
        Thu,  3 Aug 2023 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691076579;
        bh=WIrZTwTXZRHKURzn8DzxuIN1bcMf1+e2SozOf9PgZ+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwqWjgtm8d3uYUUTox3cakgvCMDEeM0Fc4NO4SGnHTf1sfh42CylZ0LeySAYif4XM
         cHvrnO7Y8QctMxlz1vjcztqV/bvqIjrwSNbryw5+4dMckkh8YA0ozWAl/dRd1C+Fx1
         trHjOCa+MqmNmcdwLg93uYCBJ8h6t2t79eaeKBDNjVtKzFNOaWAyGnCP8Nj8azG9+r
         /kKoVOhF/AhGdibW/M4MIegpJ4g5ewG1nvs2VF4V7akpXuUL294nfJBHCE7jsR1lWd
         sTTkRdXR2esKs0fGG/DcV3fKGYz5KjxL/v8JoTH2Z/kOeJppFdANLNZCKoKxZ6Mw0m
         /jE1mUxWaZjiQ==
Date:   Thu, 3 Aug 2023 16:29:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH V2] dt-bindings: pinctrl: pinctrl-single: add am625
 compatible
Message-ID: <20230803-antennae-donut-6cae9d43d791@spud>
References: <20230803150955.611717-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KaUmM+kU/IMfjpmo"
Content-Disposition: inline
In-Reply-To: <20230803150955.611717-1-d-gole@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KaUmM+kU/IMfjpmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 08:39:55PM +0530, Dhruva Gole wrote:
> Add the am625 compatible property to add support for the new
> wakeup enable and status bits positions
>=20
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Base: tag: next-20230731 + below "depends on" patch
> Depends on: https://lore.kernel.org/linux-omap/20230731061908.GG5194@atom=
ide.com/T/
>=20
> v1 -> v2 changes:
> rename to use am625 instead of am6
>=20
> link to previous version:
> https://lore.kernel.org/all/20230803092311.604610-1-d-gole@ti.com/
>=20
>  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yam=
l b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> index b6b6bcd7074b..902469986fff 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> @@ -23,6 +23,7 @@ properties:
>            - pinconf-single
>        - items:
>            - enum:
> +              - ti,am625-padconf
>                - ti,am437-padconf
>                - ti,dra7-padconf
>                - ti,omap2420-padconf
> --=20
> 2.34.1
>=20

--KaUmM+kU/IMfjpmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvH3QAKCRB4tDGHoIJi
0rU0AQDmDmrrKUtX5SYv/Uth0nB12CpgQQR7pF3Z+QTBPsIWxQEAsRbZAwvazgsh
P+lF8aNXe5b80uSZ4NZlz1XNlqDs4QI=
=Q6sB
-----END PGP SIGNATURE-----

--KaUmM+kU/IMfjpmo--
