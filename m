Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD77D3D05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjJWREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:04:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2FBD;
        Mon, 23 Oct 2023 10:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92865C433C7;
        Mon, 23 Oct 2023 17:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698080643;
        bh=Z9iY3lsaZZ0k2Yw6281j4HRYsuuLhnj+PAotK0K3VDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDyPGJr3cK+jKb5Cq6EVOd3FAvj4jLd1F5V5I2zaSliCU4SDbKApT9Rn3rgvbcB/e
         h96zO1DsiEGno/PSW6UhjDGACMyFRcts7xpOnFhKLV24YqpawYWsdPdFRBT571oEMZ
         IrPmsb6HRdJTq6n+Uo836v53fH/5gKP0iIFMPA07msGpOWiK8AWIQCoUZlyWW3uKZU
         a4I1A3mdePhDk5Lb5DHLzXBL4tTlGwxyfeeKf4eIfCyNzdv/xppPOA4Ij+9U3pc+Dt
         +ISwR95IHhxVQJQntGzb62eA2io51O2nTyxGhxyj6gJbmUC38uTS0jCnBdxWs2kRa0
         TizIz5NDcMF+w==
Date:   Mon, 23 Oct 2023 18:03:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/18] dt-bindings: display: mediatek: aal: add binding
 for MT8365 SoC
Message-ID: <20231023-sharpness-uplifting-634566c6b4ff@spud>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-1-5c860ed5c33b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PbLYAkV5QGg0voCF"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v1-1-5c860ed5c33b@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PbLYAkV5QGg0voCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 04:40:01PM +0200, Alexandre Mergnat wrote:
> Display Adaptive Ambient Light for MT8365 is compatible with another SoC.

> Then, add MT8365 binding along with MT8183 SoC.

s/binding/compatible/, here and in the subject.

Cheers,
Conor.

>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> index 7fd42c8fdc32..840b48a878ca 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -35,6 +35,7 @@ properties:
>                - mediatek,mt8188-disp-aal
>                - mediatek,mt8192-disp-aal
>                - mediatek,mt8195-disp-aal
> +              - mediatek,mt8365-disp-aal
>            - const: mediatek,mt8183-disp-aal
> =20
>    reg:
>=20
> --=20
> 2.25.1
>=20

--PbLYAkV5QGg0voCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTanfQAKCRB4tDGHoIJi
0tPUAP9cTTvfIBq9I7y7WjmhtsRZbhjBWhdUzs8mmYekmW17xAEAnCJCpDVwVruG
ZkQOxyU76MLSecahlFO14YNh1wBwEAk=
=wX+W
-----END PGP SIGNATURE-----

--PbLYAkV5QGg0voCF--
