Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D47D226B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJVJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 05:51:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B98DC;
        Sun, 22 Oct 2023 02:51:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42D9C433C7;
        Sun, 22 Oct 2023 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697968270;
        bh=SnPBKRlsfd5P/wfHagINAEGKFI4VwNidkAz/OUfiJjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Heywy3pxCdwGuB4G6fZc2xsKk63oiSgejJcss4Pify0k2gsl0XjIuBlE3KDn7ZYB7
         qRbrotadqYbWlwi72jJx9+SS6DPUNdSIrkkwdQn3H/kfMF60rZ3mgeegVnIoo16gzt
         tlIoba+2DL4aVB796Ri+CGZsLyjczpX8c0i/9aD8m1QbQMsw89Qk5+FU92WlwiSrRH
         sQVa2QJWVAAxgaS0aU6eQtejVaUuTl0QeakLUmYbQWM2Fie70rZDwdXH6wTSig64Gj
         5ajk79k9+K9PI+VHMU6i7HdGYBjSRyK6hCKnNFqaN1deiLUlz6ddWspujg5gm9jQXy
         wGBGghA08+9mQ==
Date:   Sun, 22 Oct 2023 10:51:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lukas Walter <lukas.walter@aceart.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5
 (2016)
Message-ID: <20231022-arousal-glowing-f72c8f2e44fa@spud>
References: <20231021143025.77088-1-lukas.walter@aceart.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PKpSqrrmkmWmTJ8Z"
Content-Disposition: inline
In-Reply-To: <20231021143025.77088-1-lukas.walter@aceart.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PKpSqrrmkmWmTJ8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 04:30:24PM +0200, Lukas Walter wrote:
> Add a compatible for Huawei Honor 5X / GR5 (2016).
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

How come this v1 has an ack?

> Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 7f80f48a0954..20d914b21847 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -191,6 +191,7 @@ properties:
> =20
>        - items:
>            - enum:
> +              - huawei,kiwi
>                - longcheer,l9100
>                - samsung,a7
>                - sony,kanuti-tulip
> --=20
> 2.42.0
>=20

--PKpSqrrmkmWmTJ8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTTwiQAKCRB4tDGHoIJi
0uDbAQDPkpkGHrfnaWBKGDPIjx9YeDekGkDq8gIfVjGhqlKb/wEAlHJiAJ47rl/P
ZiCq7bPFZkjtY2BLCX0kIlH068uGpgo=
=iAHj
-----END PGP SIGNATURE-----

--PKpSqrrmkmWmTJ8Z--
