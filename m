Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793A811894
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjLMQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378940AbjLMQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:03:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A3891
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:04:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7ECC433CB;
        Wed, 13 Dec 2023 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702483443;
        bh=WUc6Tc0Eck29Qpy0WWsB6+xNiylZ12uza913fxl71B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHWfWndKGF0Q2wx/+ztdvna7ldW+17VrJ+6S8VVlgCQBtTVCahbPUcJbA+yadasnH
         Rhm7vOBTXmJLlsyZAuOPkGmIaptY4x9lrSjDBD3SfTE67NRKp09s4JdapTUzSOYirB
         JYH31h4rN34AjdoRfeCGMZw0gRWpPHixjSe54Rwo7YqnBw3HlSq/qQsqUS/PUvs/Jh
         KyWpphkg6zHn0cQhz5e62TaZ6L2Y2iCzo+mY92z3DN1gYCqeKAr3azclMvcAm7AXk6
         mPfHua8TSwW6aGP/+ZiZvLl8x3hsBYqolZVzF9Gpd8eeVAhDR5WQXkkUD61IO2euiS
         dufLVcWY+sdVg==
Date:   Wed, 13 Dec 2023 16:03:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, j-choudhary@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for J722S SoCs
Message-ID: <20231213-facsimile-circular-857af819f76f@spud>
References: <20231213124930.3012-1-vaishnav.a@ti.com>
 <20231213124930.3012-2-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C6+Hnq7eKAIEBuZ0"
Content-Disposition: inline
In-Reply-To: <20231213124930.3012-2-vaishnav.a@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C6+Hnq7eKAIEBuZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 06:19:28PM +0530, Vaishnav Achath wrote:
> Add bindings for TI J722S family of devices.

Just repeating $subject in the body isn't really all that valuable, but
these new soc additions are super straightforward (usually) so w/e.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index c6506bccfe88..d52672348424 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -123,6 +123,12 @@ properties:
>                - ti,j721s2-evm
>            - const: ti,j721s2
> =20
> +      - description: K3 J722S SoC and Boards
> +        items:
> +          - enum:
> +              - ti,j722s-evm
> +          - const: ti,j722s
> +
>        - description: K3 J784s4 SoC
>          items:
>            - enum:
> --=20
> 2.17.1
>=20

--C6+Hnq7eKAIEBuZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnV7wAKCRB4tDGHoIJi
0qw/AQCDD8DkT+Q8UytnADxMzGwvqS4OC3R/pd3qSmbQ6+e0XgEA9sJXishH7UZ1
Bzu7KgsCdLnHiLsFKtlA5X7tndmfxQA=
=4PXy
-----END PGP SIGNATURE-----

--C6+Hnq7eKAIEBuZ0--
