Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C0785BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjHWPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjHWPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF2B172E;
        Wed, 23 Aug 2023 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E5E66454;
        Wed, 23 Aug 2023 15:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90AC433C8;
        Wed, 23 Aug 2023 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803655;
        bh=qO8YNx8YZykbgztpFLxctd3rxUPUXqFVJ2yvheQpDp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0drS+ZK6bDws4a34iPE+x1iJUfc0fzlp4nOpW5pEjB9YeGOtCVq4GlJTZVI2BIgx
         4uowkaiVLsSzWfaOl6+WgeBMRHJ7wYF/n2Zjz2gzRZyZGXP/omiKQ3S3l/oD/BvVpt
         tLByIeADQI4WlWbwU2/YZcyo03HF6Cz36EqVkuhVaUsYrIUZBoIJwlfwh7rXNtjPm4
         zQVwmFB/xOSLZcCSgL0vTHPnUsZHYwXONguVqU4b67uEmIdjP8OG86xNeaIdIzMYPk
         hQBUGmcM00PkzDkSLybIFsqNvVzgW/RQnY7xIAwPeItfdi8P2vcuYwI4JUgimTtyQy
         qlSwvdpjSWq6w==
Date:   Wed, 23 Aug 2023 16:14:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 4/6] dt-bindings: arm: fsl: Add TQ-Systems LS1088 based
 boards
Message-ID: <20230823-object-aftermost-9f3fa58d3f25@spud>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
 <20230823120952.317740-5-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dn18Pj8Eny3UV7la"
Content-Disposition: inline
In-Reply-To: <20230823120952.317740-5-gregor.herburger@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dn18Pj8Eny3UV7la
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:09:50PM +0200, Gregor Herburger wrote:
> TQMLS1088a uses a common board layout with TQMLS1043A/TQMLS1046A.
> MBLS10XXA is a starterkit baseboard usable for these SOMs.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 55e8279d834b..509ba52aa3cf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1418,6 +1418,13 @@ properties:
>                - fsl,ls1088a-rdb
>            - const: fsl,ls1088a
> =20
> +      - description: TQ-Systems LS1088A based Boards
> +        items:
> +          - enum:
> +              - tq,ls1088a-tqmls1088a-mbls10xxa
> +          - const: tq,ls1088a-tqmls1088a
> +          - const: fsl,ls1088a
> +
>        - description: LS2080A based Boards
>          items:
>            - enum:
> --=20
> 2.34.1
>=20

--dn18Pj8Eny3UV7la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYiQwAKCRB4tDGHoIJi
0ooNAQD9YxoEHj46GKVhPWSiULm4GGGL74Qtzwi37lf4RcOpoQEAqVC3mlVQhdj+
JXu1kS/Yj5wi/QOPl2CgJGN2F86ITwo=
=mwBi
-----END PGP SIGNATURE-----

--dn18Pj8Eny3UV7la--
