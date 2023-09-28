Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F77B2378
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjI1ROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1ROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:14:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E104C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:14:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF6C433CA;
        Thu, 28 Sep 2023 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921258;
        bh=tXrtMWlwOkfqKNhjWq3vR9L4n6dBzGkeLZc+XQRiVK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWpDdv3+ksAvGEbNOJjqpj7q/5jMHatTKJ6it5aZ7nm2U87e6YhGkdg2q43rVdojX
         syggjiJg5ofTPT4ATJLWCuz47QSHmXFDJDhLEGRk1OuahUyYkwlVZi6lmjC5+Dh1mQ
         67LUx4MmVrgVgHKK8ylOt8LjMq3shKSUja7kpoc6Df4kVVvr21dYUAtqmYmkdVuWva
         PS5yDmUx+0w9nPgivh0w+5vaSp9XfsdcRFb9kkRDhAaXoRi5lrJGPcHoHr9wvVGf+U
         Cu04xLMuPz3yw7g2+EXxkqrrZPbxHdkL2HkUsDfA/NW+0lEIMECd0ohKE5Jo1WD+pR
         KmRdxOVEncZsA==
Date:   Thu, 28 Sep 2023 18:14:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/12] dt-bindings: net: add phy-supply property for
 stm32
Message-ID: <20230928-pelvis-outhouse-28bb691bd790@spud>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-4-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z+Q9ArmXRwc2oCyE"
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-4-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z+Q9ArmXRwc2oCyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:15:03PM +0200, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Tjanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 67840cab02d2d..8114c325a4eed 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -78,6 +78,9 @@ properties:
>        encompases the glue register, the offset of the control register a=
nd
>        the mask to set bitfield in control register
> =20
> +  phy-supply:
> +    description: PHY regulator
> +
>    st,ext-phyclk:
>      description:
>        set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
> --=20
> 2.25.1
>=20

--z+Q9ArmXRwc2oCyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRW0YwAKCRB4tDGHoIJi
0p4/AP9+zFrcdUG4lft9L0yl+zWXuhbkd/AOM7N86NFMT57JlgEAh0jws3IZ/Vty
dGXkDN6EFYwVjejcIawKvNSaWv29VQI=
=2LGR
-----END PGP SIGNATURE-----

--z+Q9ArmXRwc2oCyE--
