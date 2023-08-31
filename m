Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA778F0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbjHaP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHaP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:58:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA41B0;
        Thu, 31 Aug 2023 08:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B6FCB8226C;
        Thu, 31 Aug 2023 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE2FC433C7;
        Thu, 31 Aug 2023 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693497512;
        bh=NlQHAlRSWJmw3BpQmppIzYbTKnU63kdcr30JgkmYLIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOd+R2yDkLOJQ3pT9aougIZLtGJ5cWB99CqeZoxE+FnXTRz+YpzH3atrfMaU+6jpO
         7Il4vRln0t0VxRV5cgysytUuaAM33O6UhY7TwmzXm+Lgs3ZUFR5ZJ618CtWbrpTnE+
         3UJU+mgbkEShQ2XqXyAZFnOJMKmieFFjNCiRAaU+z5qJ4sPuZTbM46GjrHgZpsgEg3
         WYYpVPUSYJUaVm4ls/0tHyk1SVZBb6MjEAPTvTttyQ0+4Ll9fGW+Qlu2/plPUsobls
         Zky75L6m0972WAqFUDYiYFbzoUdAa0pmgHUVyiszj1/i8KRMGs3N8LKZpRXaRontgS
         NnE4yTVlPp1Ng==
Date:   Thu, 31 Aug 2023 16:58:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
        quic_gurus@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LPG PPG
Message-ID: <20230831-dose-eligibly-dee96e1f4dc2@spud>
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-5-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="siNBzA7SpfMo2ngy"
Content-Disposition: inline
In-Reply-To: <20230830180600.1865-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--siNBzA7SpfMo2ngy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 11:05:57AM -0700, Anjelique Melendez wrote:
> Update leds-qcom-lpg binding to support LPG PPG.
>=20
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/=
Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> index e6f1999cb22f..067ebe35ca5e 100644
> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =20
>  description: >
>    The Qualcomm Light Pulse Generator consists of three different hardwar=
e blocks;
> -  a ramp generator with lookup table, the light pulse generator and a th=
ree
> +  a ramp generator with lookup table (LUT), the light pulse generator an=
d a three
>    channel current sink. These blocks are found in a wide range of Qualco=
mm PMICs.
> =20
>  properties:
> @@ -63,6 +63,29 @@ properties:
>          - description: dtest line to attach
>          - description: flags for the attachment
> =20
> +  nvmem:

> +    description: >

Why do you have these chomping operators? I can't see any formatting
that'd require them. Unless you're respinning for other reasons, you can
ignore this comment.

Thanks,
Conor.


> +      This property is required for PMICs that supports PPG, which is wh=
en a
> +      PMIC stores LPG per-channel data and pattern LUT in SDAM modules i=
nstead
> +      of in a LUT peripheral. For PMICs, such as PM8350C, per-channel da=
ta
> +      and pattern LUT is separated into 2 SDAM modules. In that case, ph=
andles
> +      to both SDAM modules need to be specified.
> +    minItems: 1
> +    maxItems: 2
> +
> +  nvmem-names:
> +    minItems: 1
> +    items:
> +      - const: lpg_chan_sdam
> +      - const: lut_sdam
> +
> +  qcom,pbs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      Phandle of the Qualcomm Programmable Boot Sequencer node (PBS).
> +      PBS node is used to trigger LPG pattern sequences for PMICs that s=
upport
> +      single SDAM PPG.
> +
>    multi-led:
>      type: object
>      $ref: leds-class-multicolor.yaml#
> @@ -106,6 +129,39 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,pmi632-lpg
> +    then:
> +      properties:
> +        nvmem:
> +          maxItems: 1
> +        nvmem-names:
> +          maxItems: 1
> +      required:
> +        - nvmem
> +        - nvmem-names
> +        - qcom,pbs
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pm8350c-pwm
> +              - qcom,pm8550-pwm
> +    then:
> +      properties:
> +        nvmem:
> +          minItems: 2
> +        nvmem-names:
> +          minItems: 2
> +      required:
> +        - nvmem
> +        - nvmem-names
> +
>  examples:
>    - |
>      #include <dt-bindings/leds/common.h>
> @@ -191,4 +247,35 @@ examples:
>        compatible =3D "qcom,pm8916-pwm";
>        #pwm-cells =3D <2>;
>      };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible =3D "qcom,pmi632-lpg";
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      #pwm-cells =3D <2>;
> +      nvmem-names =3D "lpg_chan_sdam";
> +      nvmem =3D <&pmi632_sdam_7>;
> +      qcom,pbs =3D <&pmi632_pbs_client3>;
> +
> +      led@1 {
> +        reg =3D <1>;
> +        color =3D <LED_COLOR_ID_RED>;
> +        label =3D "red";
> +      };
> +
> +      led@2 {
> +        reg =3D <2>;
> +        color =3D <LED_COLOR_ID_GREEN>;
> +        label =3D "green";
> +      };
> +
> +      led@3 {
> +        reg =3D <3>;
> +        color =3D <LED_COLOR_ID_BLUE>;
> +        label =3D "blue";
> +      };
> +    };
> +
>  ...
> --=20
> 2.41.0
>=20

--siNBzA7SpfMo2ngy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC4ogAKCRB4tDGHoIJi
0rvnAQCC/NP8ZnTt8cM3IdN+5mZMI0oAy5tg3F8KoasVqxYwXwEAggM0YFw0w7Vk
RTdsGwIHbsfaMnnBOL+FBI0RD5ZK1wA=
=EpUf
-----END PGP SIGNATURE-----

--siNBzA7SpfMo2ngy--
