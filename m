Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695EB777DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjHJQEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjHJQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B412D5B;
        Thu, 10 Aug 2023 09:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EE1661AF;
        Thu, 10 Aug 2023 16:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008BFC433CA;
        Thu, 10 Aug 2023 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683441;
        bh=2vYBTkJ2rUSKIIbrz9J8BwN+dVX8dzxRfmtau+v9fAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bq4CaQBjTG4ezfEKaOkPy65cEeEi2Rdi5SB8IaTOVKKBGe+1aLftJYh40jLzN1C07
         0JkWGlDXx8LsaOykdEj7a9DYiAYMYsu7ZCTCFsnYFluf8ZRdy3yR0X5dGo4Bz+MikA
         XSnRKhfktuDFGzfsG8RgfEAcQILM92v3O4ymqYpaYBWLyh68cxngp8kivEKe7F0hhT
         n2YY4J3xyHjxgzpXJ4Mj0RYVUMrau2j1czNScrkFxZ6uzzLGQVwvJ6OHtPZ83InhQZ
         EfVHIXC0p7QSrhOjugO28bikZ/DmZ+GOwTXEfgCBcSHWzdGOBouhZ53uw3G/i28zCR
         pzuMYuOGtvg6g==
Date:   Thu, 10 Aug 2023 17:03:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
Message-ID: <20230810-exile-accurate-790c6828133b@spud>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rbpnXjA3iYOOflDM"
Content-Disposition: inline
In-Reply-To: <20230810045314.2676833-2-vigneshr@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rbpnXjA3iYOOflDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 10:23:12AM +0530, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
>=20
> Add bindings for TI's AM62P5 family of devices.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index 5ca6af492507..93b2774cc0a9 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -25,6 +25,12 @@ properties:
>                - ti,am62a7-sk
>            - const: ti,am62a7
> =20
> +      - description: K3 AM62P5 SoC

SoC seems a bit off here, since the sk is actually a board using the
SoC, but it seems to be the convention for TI stuff,
Acked-by: Conor Dooley <conor.dooley@microchip.com>



> +        items:
> +          - enum:
> +              - ti,am62p5-sk
> +          - const: ti,am62p5
> +
>        - description: K3 AM625 SoC PHYTEC phyBOARD-Lyra
>          items:
>            - const: phytec,am625-phyboard-lyra-rdk
> --=20
> 2.41.0
>=20

--rbpnXjA3iYOOflDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUKbQAKCRB4tDGHoIJi
0ljbAQD8BP4oxLXYP03F932TvABUZXUi4KzIjcOQO5Tds4vMRwEA1phdmF/qSosr
OuUvoHkzGj+tTzy0wGjdTCMV27VSVwY=
=3n+A
-----END PGP SIGNATURE-----

--rbpnXjA3iYOOflDM--
