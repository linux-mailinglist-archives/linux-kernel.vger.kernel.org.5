Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664667D84E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjJZOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345322AbjJZOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:36:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68108D55
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:36:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B05C433C7;
        Thu, 26 Oct 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330971;
        bh=89LzKN6Bnc17ff5e7nVLwTuE1e8rmadHQKzhHCLg/LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6dAbNaZSa2xQ89swGgAbwC0Fv8jdHt3WGjPFr6K/sIsY6Afd1wqRN7qOPWl/7zE/
         ikwc2eHG8J/wB3aAM9sR1iz7W4LqSGEAKlJKvMxBtcgZHtHGxFnn2bczpTUrkLVYwC
         y+FiWNr3jhPCGANWS2MCg0o26pwF2YblHFREKw1uy5ubSgmF4Mx92byY/3c5pig6C0
         09hw4oPMW7fouOIXJPxXlKJQ/zZzQ2YLFhLSG3bsDDBZCmAAp+GI2RZvOY6K9mnYPA
         g78jWAM1oJBONrMI8o8NvFL9FX9vCHCaL9dAYJOneIl83eDemXSfugXCm1PCCP6IXC
         zfhwGFxeM6qFg==
Date:   Thu, 26 Oct 2023 15:36:05 +0100
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
Subject: Re: [PATCH v3 4/7] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Message-ID: <20231026-probiotic-navigate-2d6701939741@spud>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
 <20231025215517.1388735-5-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IgU6HCI/57T5ZEmJ"
Content-Disposition: inline
In-Reply-To: <20231025215517.1388735-5-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IgU6HCI/57T5ZEmJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 02:48:46PM -0700, Hsin-Yi Wang wrote:
> Add makomo sku0 and sku1 which uses different audio codec.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2->v3: remove rev since match on sku is sufficient.
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 4fe58cfe6f1b..54141b9bb714 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -251,6 +251,13 @@ properties:
>                - google,kodama-sku32
>            - const: google,kodama
>            - const: mediatek,mt8183
> +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
> +        items:
> +          - enum:

> +              - const: google,makomo-sku0
> +              - const: google,makomo-sku1

s/const: // to fix the error reported by the bot.
With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +          - const: google,makomo
> +          - const: mediatek,mt8183
>        - description: Google Willow (Acer Chromebook 311 C722/C722T)
>          items:
>            - enum:
> --=20
> 2.42.0.758.gaed0368e0e-goog
>=20

--IgU6HCI/57T5ZEmJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTp5VQAKCRB4tDGHoIJi
0vy0AP9MouDUMj2v8vsHucyElvjB8nY6QMM7f8ytkg41iCUwlwEAnMriierZSMC5
TvFhNyExBXPu+Q+FfKi8WdlBZ5+D6QA=
=/KSD
-----END PGP SIGNATURE-----

--IgU6HCI/57T5ZEmJ--
