Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311BA76D23D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjHBPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjHBPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5439211E;
        Wed,  2 Aug 2023 08:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D95A619B3;
        Wed,  2 Aug 2023 15:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DA8C433C7;
        Wed,  2 Aug 2023 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690990668;
        bh=QBVB0WlvCnUvm8x3azvoMYN/g12CYZtPOxFHIcPNmzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZAA0quE/5Vo5GoBs9ixSIkXWgyHfW54jg7QdbDsKCWoJjuNr44uSe8HVuSfo986w
         WIt+HRNxWE7AQ81kt3HDHHE+0ZUZcCbcF/7dzCW8x155Pxdzhni+/4rhJTbR1M6yNk
         TKkz84U8prtaKLix4qNYknMMnR/bbyDszkSNrep/ayHtWirvLkvE/plrmCLi84kSW0
         ut/4FaJad5a6NiY1vhCkBkFulQPQ0ccXReivZeNaaTE4kkMtG800DnUMU+jaqgGGDl
         wk4hBqLEn4skEOAx21j2m16+y7ZWUidhroHEc2DSV+M/rJtLXKLLXPQ0G6HI+iQ0Lx
         Gb/4yVFiZyxTg==
Date:   Wed, 2 Aug 2023 16:37:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Thomas McKahan <tmckahan@singleboardsolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add NanoPC T6
Message-ID: <20230802-daydream-rectangle-48b02d4ce245@spud>
References: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
 <20230802051441.3106-2-tmckahan@singleboardsolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QneCUxURrTjnydP3"
Content-Disposition: inline
In-Reply-To: <20230802051441.3106-2-tmckahan@singleboardsolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QneCUxURrTjnydP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 01:14:06AM -0400, Thomas McKahan wrote:
> Add the NanoPC T6, a single board computer from FriendlyElec
>=20
> Signed-off-by: Thomas McKahan <tmckahan@singleboardsolutions.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 115ca986e20f..ca5389862887 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -227,6 +227,11 @@ properties:
>                - friendlyarm,nanopi-r5s
>            - const: rockchip,rk3568
> =20
> +      - description: FriendlyElec NanoPC T6
> +        items:
> +          - const: friendlyarm,nanopc-t6
> +          - const: rockchip,rk3588
> +
>        - description: GeekBuying GeekBox
>          items:
>            - const: geekbuying,geekbox
> --=20
> 2.34.1
>=20

--QneCUxURrTjnydP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMp4SAAKCRB4tDGHoIJi
0rJNAP4/xi+1tHGyTyTfZGH1OXkpTWCLEI0BTF8F8KOSY2fo0AEA7wGZ+Dwicclu
04Pz9i+2zrL4KzJUkH4ZQKK+7OhkigI=
=L/N6
-----END PGP SIGNATURE-----

--QneCUxURrTjnydP3--
