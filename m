Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6889A7FF3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbjK3Pit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbjK3Pis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC883
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:38:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76032C433C8;
        Thu, 30 Nov 2023 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701358735;
        bh=JyZrCEWuJr3UJ8ptLiE9BjwRcPlFLohLX1z4SZtoCc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6VxUD1LQowjoVs9LvLC0iPEFMTeayaZsbGh9fEpkTzbU/s8ZasCi6OGr4QqRJl4i
         wyEH6YDAtumwM7d0HFn1SoVHPzxEt87wP+e7cvW3Yx+tY9q8KK/cBvZ2aupfb+dfm1
         iSYFDaYgLIAMtrtlLlxH5rHR/un6vO0P0IhMDLqluNd+7xyJ353BiQPh3XrTKfL6dD
         3X/PlCyW0X18LIt2KNGNg8qMPzpnTw10On00yWiGmITgojzcj+yj00AMR7n5rYTgsU
         CWgmgyMxOVX4zG0D64mcvFbD549vWMaHOq1HDEnbHjp+i1etlwA2MPwGfHvDSYgSt+
         jOsZSND46dRug==
Date:   Thu, 30 Nov 2023 15:38:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add
 X1E80100 LPASS LPI
Message-ID: <20231130-cushy-hamlet-c8b3a1d183ed@spud>
References: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BRctadQJgsOjKQYl"
Content-Disposition: inline
In-Reply-To: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BRctadQJgsOjKQYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:57:38PM +0100, Krzysztof Kozlowski wrote:
> Document the Qualcomm X1E80100 SoC Low Power Audio SubSystem Low Power
> Island (LPASS LPI) pin controller, compatible with earlier SM8550 model.
>=20
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-=
lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lp=
ass-lpi-pinctrl.yaml
> index ef9743246849..ad5e32130fd7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pin=
ctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pin=
ctrl.yaml
> @@ -16,7 +16,11 @@ description:
> =20
>  properties:
>    compatible:
> -    const: qcom,sm8550-lpass-lpi-pinctrl
> +    oneOf:
> +      - const: qcom,sm8550-lpass-lpi-pinctrl
> +      - items:
> +          - const: qcom,x1e80100-lpass-lpi-pinctrl
> +          - const: qcom,sm8550-lpass-lpi-pinctrl
> =20
>    reg:
>      items:
> --=20
> 2.34.1
>=20

--BRctadQJgsOjKQYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWisigAKCRB4tDGHoIJi
0rOoAP4iSd2hLjqO+JZop/z26hiw97HgeEijD9cpN2iMMpFA4QD+LEM7VHDm/tnl
Jpm63MsCmEo9QRQ3HN7PIohIJlRnbwg=
=YhlU
-----END PGP SIGNATURE-----

--BRctadQJgsOjKQYl--
