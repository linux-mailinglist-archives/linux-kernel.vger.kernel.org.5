Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97080D3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbjLKR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbjLKR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:29:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460AC8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:29:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A324EC433C7;
        Mon, 11 Dec 2023 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702315795;
        bh=LG9yC9T7WxDhr+BiUl3Dho2W3NGuanNuq2BwSSb2m7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ksf5gdIjvH4DynRW4uEWQpgrSlQ3E928IhMDsDZtLZ3Dt3HV/7GDqj93NZ+x0Wyeo
         IurfMVxHjn6t507JQ1NrLC77E6y7MBZECoCktB7XuWMuN7k8VzJ5QVctnj+FsvsDMC
         rRtse8JR7Z/d7PqqSEzK4b2mmCA99YAWi5dBFkMg+xcGYGWt2RNxa6LzOOwWjVe0U3
         kZtKleeB2h68a6KhREyltBOM22qHz5e0D0b6+G/FsRDS3sYSw5cDWXl2o6Yr8YnWCp
         Rusvi/R2boGbUY+iVdFPHeUEaBA1mIPWv5Sd5PsauUcGtoSOWNTpAf9xXfmH1bR/GE
         mnfShQzYVVHIw==
Date:   Mon, 11 Dec 2023 17:29:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100
 LPASS RX
Message-ID: <20231211-cardstock-elevator-3e19f9d41ac2@spud>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2LNFTi2k/ijpYbVF"
Content-Disposition: inline
In-Reply-To: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2LNFTi2k/ijpYbVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 01:31:01PM +0100, Krzysztof Kozlowski wrote:
> Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
> RX macro codec, which looks like compatible with earlier SM8550.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I wish you'd send cover letters when you send series of trivial patches
like this that could be acked in one go.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.=
yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> index cbc36646100f..b8540b30741e 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> @@ -19,7 +19,9 @@ properties:
>            - qcom,sm8550-lpass-rx-macro
>            - qcom,sc8280xp-lpass-rx-macro
>        - items:
> -          - const: qcom,sm8650-lpass-rx-macro
> +          - enum:
> +              - qcom,sm8650-lpass-rx-macro
> +              - qcom,x1e80100-lpass-rx-macro
>            - const: qcom,sm8550-lpass-rx-macro
> =20
>    reg:
> --=20
> 2.34.1
>=20

--2LNFTi2k/ijpYbVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdHDgAKCRB4tDGHoIJi
0nU+AQDVDBF2Ue5mLjfFa/+I6TWQM2yfHXHlsApXW8yIzl//igEAgY0GeYGSN98Z
iBGGvTxVPokVS73NbLliSfIW9xpVwwg=
=MyYY
-----END PGP SIGNATURE-----

--2LNFTi2k/ijpYbVF--
