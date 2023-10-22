Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363AB7D2273
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJVKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:00:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ECDE5;
        Sun, 22 Oct 2023 03:00:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48913C433C7;
        Sun, 22 Oct 2023 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697968813;
        bh=7PsMWbaVMedcFn6pPH+/OzV5PSechVS/ScQduga9eQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLa/vHW7t8aqno59J8dt7ReYX8iDpAuNnwvWrlchV/dNSytiLmDRXjqasn6wdZfhk
         hV+jNBGwOT+sXnjm7yMLdAhMCFi2vfSikzVUwjp+xu5F+lDFKAo/1xhHbJG19yBCCT
         u5dBv5n7TsQlKrPbV3q/oNx4XbKb7cpayC7x9noJCcJGUV8bE4EUX+lZh+Z1kmiL+J
         DyxNt3kT5d0Qh6rkMpm4BkWKjPFwdfsRUV2a6vtfbXTkfgrDjGAEXbMeirAqIStS9z
         dUYV6L9LMJdnG0eujR0GuqeINj+D3/pHBDG+fz+zbbL3ozNoHFnYSqVzK8rYU+3eqv
         T7FKjtPcjtZIA==
Date:   Sun, 22 Oct 2023 11:00:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
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
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, jenneron@postmarketos.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,sm8250: Add
 sc7180-qdsp6-sndcard
Message-ID: <20231022-snowy-flashily-0c814247e557@spud>
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
 <20231020-sc7180-qdsp-sndcard-v1-1-157706b7d06f@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nNQF1DonWtR70u/D"
Content-Disposition: inline
In-Reply-To: <20231020-sc7180-qdsp-sndcard-v1-1-157706b7d06f@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNQF1DonWtR70u/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 08:33:46PM +0500, Nikita Travkin wrote:
> sc7180 can make use of the adsp-baked soundcard, add relevant compatible
> to the documentation.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
COnor.

> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/D=
ocumentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 262de7a60a73..e082a4fe095d 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -25,6 +25,7 @@ properties:
>            - qcom,apq8016-sbc-sndcard
>            - qcom,msm8916-qdsp6-sndcard
>            - qcom,qrb5165-rb5-sndcard
> +          - qcom,sc7180-qdsp6-sndcard
>            - qcom,sc8280xp-sndcard
>            - qcom,sdm845-sndcard
>            - qcom,sm8250-sndcard
>=20
> --=20
> 2.41.0
>=20

--nNQF1DonWtR70u/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTTypwAKCRB4tDGHoIJi
0gl5AP0X+bwFzAyHiu5r1O6UFDt6fXJWOpKG7KiyYT2H/ADLfQEAv0d2OZNJEAOh
3R4ScbuFOliRrkzghDPBebpGO59z+A0=
=XI4e
-----END PGP SIGNATURE-----

--nNQF1DonWtR70u/D--
