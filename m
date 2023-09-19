Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A97A5CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjISItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:49:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB74F122;
        Tue, 19 Sep 2023 01:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6066C433C8;
        Tue, 19 Sep 2023 08:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113343;
        bh=ZDqFz515SDyLoYhDtvajPu9nG5pjPzTdqzRnLr3foyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KURv/cnQGrc7BzW1zes213O+fmTB3ZqS79BAydZ9FKa8aDa5iyGnVFa3eASOC4wvj
         KTeWIdlqzpxyxmwBI5heVP1qqyrnczsklvOdsjKXc+6zMjOoudzoBUe3wwQaMmB89p
         nkM3eZScNbsp7yGkTZcR60TNkmVmLjjikO2RF675dAUbM6sjAXy+DF+fS6bHvGn6LE
         T2TRcKIkxbDOrF756DMP0azWQT9StF80mVlEqpzY2Yqga3C2GWIqUAqAVND4/KXKBj
         RdTa0NkoDvqNEuAO8QzCLHzIkwUSPzCaiq9cCGuDJPb9bdFPCQL9hExaoHGUrV0ORq
         rZZsrz3V72lBw==
Date:   Tue, 19 Sep 2023 09:48:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SC7280
Message-ID: <20230919-c2a5521d840f4c238b02b26f@fedora>
References: <20230918205037.25658-1-quic_nitirawa@quicinc.com>
 <20230918205037.25658-2-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XTPnFVF3xntyWeLv"
Content-Disposition: inline
In-Reply-To: <20230918205037.25658-2-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XTPnFVF3xntyWeLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 02:20:36AM +0530, Nitin Rawat wrote:
> Document the QMP UFS PHY compatible for SC7280.
>=20
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-=
phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.=
yaml
> index d981d77e82e4..f3a3296c811c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -19,6 +19,7 @@ properties:
>        - qcom,msm8996-qmp-ufs-phy
>        - qcom,msm8998-qmp-ufs-phy
>        - qcom,sa8775p-qmp-ufs-phy
> +      - qcom,sc7280-qmp-ufs-phy
>        - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8280xp-qmp-ufs-phy
>        - qcom,sdm845-qmp-ufs-phy
> @@ -85,6 +86,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sa8775p-qmp-ufs-phy
> +              - qcom,sc7280-qmp-ufs-phy
>                - qcom,sm8450-qmp-ufs-phy
>      then:
>        properties:
> --
> 2.17.1
>=20

--XTPnFVF3xntyWeLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlgcwAKCRB4tDGHoIJi
0rumAQDTYAtxyXoMwqyYmON3XROCQC7lq3XVIsz6mQJ5BMEPNwEAyO14FVWmEN9w
zhQlGOkCpm+F2GIng9CSsKfVNMrzJwo=
=rTnQ
-----END PGP SIGNATURE-----

--XTPnFVF3xntyWeLv--
