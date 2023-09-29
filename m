Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559767B34C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjI2OUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjI2OUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:20:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E108DB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:20:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A94C433C7;
        Fri, 29 Sep 2023 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997210;
        bh=fYsLlU7RD4jiDjklsttfzxxrsLkIsQmtmKdVlmdVsSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKpBmitXt7pFj1vVuYDCsCX33TJuhtJcNAUvDkRp4c0zUTd/d8iPQBKdVtc9OTJIb
         JYrFwSTesSd7G5wRQm0NZSPPybJD3YwMuZ7Et3bURTUndTjFGKfpaKmsLomz0NDBoN
         YNTs4XMBFHMHmV4msOrcVuZVoLAKFbhmkl53L72QvKSht+qSEhj4mljJmjj66hfTZ5
         MQwZWazxKI+CaXRIeymKA8DIBUNUcJ+Q9foJwmSzK7o/Lzd1ndCvmNbZaMWgpHMb8g
         GK4HHUgLH9YlrEGlweNX35O/zuAcHK372imtIXx9q2Xn4UXyh+3hJeuNx4WIRMBupa
         6lAe2d99WW8fg==
Date:   Fri, 29 Sep 2023 15:20:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Julian Ribbeck <julian.ribbeck@gmx.de>
Cc:     samuel@sholland.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: sunxi: Add
 itead,iteaduino-plus-a20
Message-ID: <20230929-given-making-f3fac6afb176@spud>
References: <9730f21c-fd8e-9583-98c7-e5d923269f79@sholland.org>
 <20230928165803.30127-1-julian.ribbeck@gmx.de>
 <20230928165803.30127-2-julian.ribbeck@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sE2y3Q5fleKV+ZoS"
Content-Disposition: inline
In-Reply-To: <20230928165803.30127-2-julian.ribbeck@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sE2y3Q5fleKV+ZoS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 06:57:02PM +0200, Julian Ribbeck wrote:
> Add itead,iteaduino-plus-a20 bindings
>=20
> Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>

FYI, you missed a tag from Krzysztof
| Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=66rom https://lore.kernel.org/all/20230617205624.1178427-2-julian.ribbeck@=
gmx.de/

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index e4dd678f4212..25251ce4b60d 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -362,6 +362,11 @@ properties:
>            - const: itead,iteaduino-plus-a10
>            - const: allwinner,sun4i-a10
>=20
> +      - description: Itead Iteaduino Plus A20
> +        items:
> +          - const: itead,iteaduino-plus-a20
> +          - const: allwinner,sun7i-a20
> +
>        - description: Jesurun Q5
>          items:
>            - const: jesurun,q5
> --
> 2.42.0
>=20

--sE2y3Q5fleKV+ZoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbdFQAKCRB4tDGHoIJi
0hENAP9IpwnrWsHg8nI0q+kRK1+NgbOTpefX7aM1d/Y+1NyE9AEAl7RWhp9CXkor
MvC6XMX4WtuB5mP5JHEVIGmJCKepgAU=
=TyBK
-----END PGP SIGNATURE-----

--sE2y3Q5fleKV+ZoS--
