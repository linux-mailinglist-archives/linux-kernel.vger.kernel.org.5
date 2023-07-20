Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753E75B580
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGTRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGTRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F41999;
        Thu, 20 Jul 2023 10:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B78061BB2;
        Thu, 20 Jul 2023 17:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA9DC433CC;
        Thu, 20 Jul 2023 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873681;
        bh=kCm7zmLTENSpmQRj4Am7BSCkxIu3p18w7VEvcmHC5V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAI2Aw253znXV9t6dp+ND3bLNvEp8wZuStNZ4W4ieOPEC50W9xagT0L1RwWcPVxCx
         VQ0dMlIxhCcEq7qI+ajNL3EI83mfJ3oTcQhTShxLCBzYNaOYolrtGecoZ3B/IC/ZDv
         IVqGfC/N82JmGXXiLfCTbeu9PJXdmkmdsSchbT5YOQDpSoZqQSuX5jej4KcdDGnxH9
         4YZfhcxX+fMIgnXtvH6OSoE6WxMnISSY+4LxrJL7c+F9BORc9px8DQLIL0c4iWJhV6
         X6gkggYS+M3zmZ+bPnD1KTUbmlYER/m/PXDsBQ0L642C0QjBaywyLUoj7l6dG+stGY
         gKcJ2gLpbpTfg==
Date:   Thu, 20 Jul 2023 18:21:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: document PMC8180 and
 PMC8180C
Message-ID: <20230720-spirited-splice-339caa3e3e1a@spud>
References: <20230720083525.73622-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nOFOLSh+UXl81EJY"
Content-Disposition: inline
In-Reply-To: <20230720083525.73622-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nOFOLSh+UXl81EJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 10:35:25AM +0200, Krzysztof Kozlowski wrote:
> Document qcom,pmc8180 and qcom,pmc8180c compatibles already used in DTS:
>=20
>   sc8180x-primus.dtb: pmic@1: compatible:0: 'qcom,pmc8180' is not one of =
=2E..
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/=
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 7a9ab2b7decd..debed393fa8c 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -72,6 +72,8 @@ properties:
>            - qcom,pm8994
>            - qcom,pm8998
>            - qcom,pma8084
> +          - qcom,pmc8180
> +          - qcom,pmc8180c
>            - qcom,pmd9635
>            - qcom,pmi632
>            - qcom,pmi8950
> --=20
> 2.34.1
>=20

--nOFOLSh+UXl81EJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLltDAAKCRB4tDGHoIJi
0pBoAQD3ILOBuVGquTdXOjeTBSoG16s1AMg9SIG0CaQImLFNrwEAjUNRiypBc9ck
w3hNW1IKCUTd468bYTz3wqihE81IEA8=
=gWck
-----END PGP SIGNATURE-----

--nOFOLSh+UXl81EJY--
