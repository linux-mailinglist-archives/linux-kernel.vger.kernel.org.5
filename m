Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF37D84CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjJZOcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbjJZOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:32:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E40B128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:32:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639AAC433C8;
        Thu, 26 Oct 2023 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330762;
        bh=la2sdiSTispFY+4HPux+4oDSduULbv+AF7/FuOI7xbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EY04TEBYA8PRSw4Eamm0phM3Jxw8mDC1ZlanMbqJlsEkV0Q6w2aVv0cXbs9/km+4Z
         +HGo9KaK9Mbv0sIERcukmDadDda8I1lMxycQgRXDzpkRGJJjOCC/8XJc0MJQpycpHD
         xLL80r0pLeqmQu89w/ScIsaVF6jVZifmEAyHxnqCVY9HvVpJBle4P8MotkRZkh7YnN
         Fv9JNdA6MLWveMS6xOpCO/KCaj8FGIsNLDgDev13j4hHaL7ThPkYuuJ3lgJ4LtWbD5
         rV2p/+fnmlxdniJ1dEgKjSubCqcHUMPZpGGBicODDn6f5A8epRV3W2rCnxVR0HBWLx
         oitHzxRd0JX/g==
Date:   Thu, 26 Oct 2023 15:32:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/7] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-katsu
Message-ID: <20231026-afford-suitor-18b4f0eea371@spud>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
 <20231025215517.1388735-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xhWZzE7Zdu2mfZah"
Content-Disposition: inline
In-Reply-To: <20231025215517.1388735-3-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xhWZzE7Zdu2mfZah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

For your subject, drop the "dts: ", that as this is a patch for a
dt-binding, not a devicetree source file.

On Wed, Oct 25, 2023 at 02:48:44PM -0700, Hsin-Yi Wang wrote:
> Add katsu sku32 and sku38 which uses different audio codec.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index a5999b3afc35..4fe58cfe6f1b 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -235,6 +235,13 @@ properties:
>          items:
>            - const: google,kappa
>            - const: mediatek,mt8183
> +      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
> +        items:
> +          - enum:
> +              - google,katsu-sku32
> +              - google,katsu-sku38
> +          - const: google,katsu
> +          - const: mediatek,mt8183

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>        - description: Google Kodama (Lenovo 10e Chromebook Tablet)
>          items:
>            - enum:
> --=20
> 2.42.0.758.gaed0368e0e-goog
>=20

--xhWZzE7Zdu2mfZah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTp4hAAKCRB4tDGHoIJi
0gCAAQDE1tc7reAgagQx6S0aLYjNsM/zxnvnjgoqFHY1D/3mVwD+NU8+R7xn8F0V
7bAmx7CUZpdLqiUJ8RpMAUiU5+uPswE=
=tke3
-----END PGP SIGNATURE-----

--xhWZzE7Zdu2mfZah--
