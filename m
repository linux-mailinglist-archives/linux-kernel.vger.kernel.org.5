Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736B76B8A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjHAPcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHAPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:32:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEF18B;
        Tue,  1 Aug 2023 08:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 865A4615F4;
        Tue,  1 Aug 2023 15:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53163C433C9;
        Tue,  1 Aug 2023 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690903941;
        bh=lJKVWrjk4zcCanmVu/5JW+TXf/1uu3riraFu5xuvn9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QISG0r7S3K1pZIoV+HgqFot4POLX9dhDCDEIzBqGGRm8qSb2jDdpNBufNiIoEZlAm
         IKygsLEGMJAaqMS24yPpRJUwSQsPZCZYD7msuCCuWrF6Yk+jHmpZOAvXUvLj7CTDj5
         2FOpB/6wFBv8Ehk0nCnVx7Rnr/NWrLcvBZVVNvt9Ag0aogm/JIcWTRzoz+jt/4pqOa
         tOe2u31wZCRSOSy9cg3N0vuNiRLcnuW+aNXR0caU015aN3c1s0Kd0wAxaC/VysgnFn
         kcTMQ/a9ly3eYyctv4CRIq11JOnqkkaodE10SjSXA9t6L4cOeYtbcjRSCt7V2tXpyZ
         +Ae47ind/wwkQ==
Date:   Tue, 1 Aug 2023 16:32:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>
Subject: Re: [PATCH] bindings: mfd: qcom-pm8xxx: add a property for rtc-pm8xxx
Message-ID: <20230801-crawfish-impeding-c62bd0d5a4ca@spud>
References: <20230801115143.27738-1-quic_ajainp@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vcmA4+W9VwBO+AA+"
Content-Disposition: inline
In-Reply-To: <20230801115143.27738-1-quic_ajainp@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vcmA4+W9VwBO+AA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 05:21:43PM +0530, Anvesh Jain P wrote:
> Update rtc-pm8xxx bindings with disable-alarm-wakeup property.
>=20
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>

The corresponding driver patch, afaict got NAKed.
Why were they not sent together?

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Doc=
umentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> index 9c51c1b19067..e4f1d2ff02b6 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> @@ -42,6 +42,9 @@ properties:
> =20
>    interrupt-controller: true
> =20
> +  disable-alarm-wakeup:
> +    description: optional, disable alarm wake up capability.
> +
>  patternProperties:
>    "led@[0-9a-f]+$":
>      type: object
>=20
> base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
> --=20
> 2.17.1
>=20

--vcmA4+W9VwBO+AA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMklfwAKCRB4tDGHoIJi
0olmAP9RV+xteLcQWdAAcChWyBbR7rRX80Zq6JgajPI11F7QQwEAnEJyjcD/RUIt
dFP/2UZjqilyGdsEzywMEKOMu4oyEA8=
=9fHA
-----END PGP SIGNATURE-----

--vcmA4+W9VwBO+AA+--
