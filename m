Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB247BE659
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377188AbjJIQ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007591
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:26:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD62DC433C8;
        Mon,  9 Oct 2023 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868806;
        bh=TS7qlSQMJeaEwASV4I5bE63YJ4CtP1GPaVK0RvdE5Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8ly/Rh+3e8H/Pg56Qi6/j04x4vPz0nxbQPuq6aMKwy+xlQpBcHOpzXwIDTTdzc0m
         HzRGiKWkjV45/eclX2Z+KRlYU//K0OA93zRQk6x+xnb8nkZJcNK80Mlpi+rrhxmb+7
         Stkzdi2bnLvfAUb1QEPd62wWAYqj+7ZiFY6bt6Jmq2tK1XN4gixKWJiO454+czsQxH
         midOWd7eNHoErFnIeZp3UHADfnFa8SUZx6lyQOQaY3FPjc9Pga5hxb+SBQmYojgXhr
         a1BrKEJ2DUJkc8kMYsh0Ytt8j01dnGA9wLGLpHVLF8P/z8fDyP4j5dEfOAx3FB7Tma
         3aP/1mE9d1UWQ==
Date:   Mon, 9 Oct 2023 17:26:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>, Jonas Karlman <jonas@kwiboo.se>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Orange Pi 5 Plus
Message-ID: <20231009-poncho-refining-5206e3875669@spud>
References: <20231008130515.1155664-1-megi@xff.cz>
 <20231008130515.1155664-4-megi@xff.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jtxAoSr1vHYzIdfq"
Content-Disposition: inline
In-Reply-To: <20231008130515.1155664-4-megi@xff.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jtxAoSr1vHYzIdfq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 03:05:01PM +0200, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> Add devicetree binding documentation for Orange Pi 5 Plus SBC made by
> Xunlong.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index ca5389862887..1a636ad540ce 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -870,6 +870,11 @@ properties:
>            - const: tronsmart,orion-r68-meta
>            - const: rockchip,rk3368
> =20
> +      - description: Xunlong Orange Pi 5 Plus
> +        items:
> +          - const: xunlong,orangepi-5-plus
> +          - const: rockchip,rk3588
> +
>        - description: Xunlong Orange Pi R1 Plus / LTS
>          items:
>            - enum:
> --=20
> 2.42.0
>=20

--jtxAoSr1vHYzIdfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQpwQAKCRB4tDGHoIJi
0maaAP47E1PJIyhK8cjy+hke5lwVZTaDc5KFma7+IRK1rtnLAwD+JBc/RJpoF+Fc
rBJfx39NBvbJPDnRQ7dDfFCZznzkSgQ=
=+cps
-----END PGP SIGNATURE-----

--jtxAoSr1vHYzIdfq--
