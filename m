Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3E7B5108
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjJBLRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjJBLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:17:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFDAC;
        Mon,  2 Oct 2023 04:17:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B8C433C8;
        Mon,  2 Oct 2023 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696245424;
        bh=RE4FBlHyO/zfPZlZLM/Jo+wd0nETiNEbLPtdhiy7h3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOPkb9ZbcogOmm4h1gRsBa+K6JijVCLmXOiwo5eBMoQHrMh9lZ5B8XLSKTh7pEurw
         IvXpcaCd0ycX+k1pcMrQcBxs9oknb6F0s02BqlJkKqn7M1T9m9MZGBUxbDpYNxZWqH
         /2SmJdTA0ZsPDFnibJABildeb1sqvP3qfJhHxRYTCIBSE+zFS4UVN6fVEGFMEQYRD8
         c4tUZq7EFvuyT3p7kqfKsqVG78536BwdonuSgcHSGwxBY2sS2SkEajaILMOLgVqPnD
         NIqPiYkDUZNLUqE2/sFTQb9AA0JOvxZBWyocqp4rv2zI7/BBZ4BLv3u6P9Kjqi+/Sp
         k3M2dYJS2vFtw==
Date:   Mon, 2 Oct 2023 12:16:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: qcom,spmi-pmic: Drop unused
 labels from examples
Message-ID: <20231002-unmolded-petition-d2ee6a725c31@spud>
References: <20231002-pm7250b-gpio-fixup-v2-0-debb8b599989@fairphone.com>
 <20231002-pm7250b-gpio-fixup-v2-1-debb8b599989@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KTUTVgcFE5gHKHtM"
Content-Disposition: inline
In-Reply-To: <20231002-pm7250b-gpio-fixup-v2-1-debb8b599989@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KTUTVgcFE5gHKHtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:00:11AM +0200, Luca Weiss wrote:
> There's not much point in having unused labels in the binding example,
> so drop them.
>=20
> This patch was originally motivated by ea25d61b448a ("arm64: dts: qcom:
> Use plural _gpios node label for PMIC gpios") updating all dts files to
> use the plural _gpios label instead of the singular _gpio as label but
> this example wasn't updated. But since we should just drop the label
> alltogether, do that.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 55e931ba5b47..9fa568603930 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -239,13 +239,13 @@ examples:
>          interrupt-controller;
>          #interrupt-cells =3D <4>;
> =20
> -        pmi8998_lsid0: pmic@2 {
> +        pmic@2 {
>              compatible =3D "qcom,pmi8998", "qcom,spmi-pmic";
>              reg =3D <0x2 SPMI_USID>;
>              #address-cells =3D <1>;
>              #size-cells =3D <0>;
> =20
> -            pmi8998_gpio: gpio@c000 {
> +            gpio@c000 {
>                  compatible =3D "qcom,pmi8998-gpio", "qcom,spmi-gpio";
>                  reg =3D <0xc000>;
>                  gpio-controller;
> @@ -330,7 +330,7 @@ examples:
>              };
>          };
> =20
> -        pm6150_gpio: gpio@c000 {
> +        gpio@c000 {
>              compatible =3D "qcom,pm6150-gpio", "qcom,spmi-gpio";
>              reg =3D <0xc000>;
>              gpio-controller;
>=20
> --=20
> 2.42.0
>=20

--KTUTVgcFE5gHKHtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqmqgAKCRB4tDGHoIJi
0sxtAP95+mFfGC9hHntWipbprg+ek4xNlhEbpKWWHfDq4/DL6gEAni6Hhoqt30DV
oh45HivEaiwndosjW1G+4bCpCmle2AA=
=2/vd
-----END PGP SIGNATURE-----

--KTUTVgcFE5gHKHtM--
