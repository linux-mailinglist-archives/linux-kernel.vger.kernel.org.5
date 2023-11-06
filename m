Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168C7E2AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjKFRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:11:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87945125;
        Mon,  6 Nov 2023 09:11:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D5BC433C9;
        Mon,  6 Nov 2023 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699290689;
        bh=xusVlf2bPpkS2PxlobjXC4orjcybspLeRLkKRoSVFco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkcaW3mII+LuoahYljzVUZljrlfW8ZwFt1ANIK8NuKpTpwDUtoX4iRDX+zmGVIezt
         XRs7E9nZ+CotROXaDkDdhcu7nUMlz2IM7bM4mN0msXffkcfww2ucyJa3BKoHmO+Frh
         2son5iW99BOQlRDFeutmx17PlhIaHBmWvP5laTUwdFA1fMvQyeQ0MdENn8/tjAYq3v
         CMlMJb7WR9D5suuhbTTGt8OA9528NvRhw4vxaweo7Z/kOtFrotXzTYNp3qp9H6mtZt
         YE8Jt9odyDVsoGGr2/tOSA28ECCP/0FILClEyCSSXBTs66KGE0Cro849SD4gBehocH
         liQRx1l0hf+qg==
Date:   Mon, 6 Nov 2023 17:11:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/9] media: dt-bindings: rockchip,vdec: Add RK3288
 compatible
Message-ID: <20231106-mongrel-aground-bd559a461ed0@spud>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
 <20231105233630.3927502-7-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fGrMI8XIaRiy8S6e"
Content-Disposition: inline
In-Reply-To: <20231105233630.3927502-7-jonas@kwiboo.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fGrMI8XIaRiy8S6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 11:36:13PM +0000, Jonas Karlman wrote:
> Add a RK3288 compatible for a version of the Rockchip VDEC IP that only
> support HEVC decoding.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b=
/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> index 08b02ec16755..0f00e9c86737 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> @@ -16,7 +16,9 @@ description: |-
>  properties:
>    compatible:
>      oneOf:
> -      - const: rockchip,rk3399-vdec
> +      - enum:
> +          - rockchip,rk3288-vdec
> +          - rockchip,rk3399-vdec
>        - items:
>            - enum:
>                - rockchip,rk3228-vdec
> --=20
> 2.42.0
>=20

--fGrMI8XIaRiy8S6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUkeOwAKCRB4tDGHoIJi
0lr4AP9aW5NhxtpSLd4D73zYMC0XsxpeB3bwz7XcktPhtsuHKwEAjOIaEXKcLSUJ
5fdyRess2G11op/gkXF5bLmu2Kde8AQ=
=9q4o
-----END PGP SIGNATURE-----

--fGrMI8XIaRiy8S6e--
