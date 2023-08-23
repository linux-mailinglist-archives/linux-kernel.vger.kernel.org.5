Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5181785BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjHWPOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjHWPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0CE101;
        Wed, 23 Aug 2023 08:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EF6A6535D;
        Wed, 23 Aug 2023 15:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D356C433C7;
        Wed, 23 Aug 2023 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803638;
        bh=kNFrTQhI01h19gYOwtJD/GeHDhHsvbsDC366A4mng78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/Q0e7ggjVi1dgCJnjI4M6W1K0uVdSEpz26+75bi29cxyWjTWNDFJJqFiQJA8vAWO
         vDifMqTI2EQ3TYcA0mLmh1yOVhYqehlq6L88UxgHwnOPp7E0OEZWXvC7+b1lfb9gtF
         peRSdcPtJfl65CfiN4sB6zwwtmvp42qZakUq1plfWX1QP0gl5yCtvHisANQNZUFKp6
         BOK38di3x0rV8WwXtgLvN6bh76/ZX3WyMgxzKPZNPJUlK64KfpFjm5EIN3RkqXmv3u
         p4eT5AYXgmGKRoBc3ZVpJ0CQ18qNFDfJysBlKMLObD3SFtJnrh/vfTQQDmFRKqJpO0
         n2TuSWB2v7aFQ==
Date:   Wed, 23 Aug 2023 16:13:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 2/6] dt-bindings: arm: fsl: Add TQ-Systems
 LS1043A/LS1046A based boards
Message-ID: <20230823-negotiate-pyromania-1185ac037695@spud>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
 <20230823120952.317740-3-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0wiGOiHK2OaEQY0M"
Content-Disposition: inline
In-Reply-To: <20230823120952.317740-3-gregor.herburger@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0wiGOiHK2OaEQY0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:09:48PM +0200, Gregor Herburger wrote:
> TQMLS1043A and TQMLS1046A use the LS1043A LS1046A SOC on a common
> layout.
> MBLS10XXA is a starterkit baseboard usable for both SOMs.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 9450b2c8a678..55e8279d834b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1389,6 +1389,13 @@ properties:
>                - fsl,ls1043a-qds
>            - const: fsl,ls1043a
> =20
> +      - description: TQ-Systems LS1043A based Boards
> +        items:
> +          - enum:
> +              - tq,ls1043a-tqmls1043a-mbls10xxa
> +          - const: tq,ls1043a-tqmls1043a
> +          - const: fsl,ls1043a
> +
>        - description: LS1046A based Boards
>          items:
>            - enum:
> @@ -1397,6 +1404,13 @@ properties:
>                - fsl,ls1046a-rdb
>            - const: fsl,ls1046a
> =20
> +      - description: TQ-Systems LS1046A based Boards
> +        items:
> +          - enum:
> +              - tq,ls1046a-tqmls1046a-mbls10xxa
> +          - const: tq,ls1046a-tqmls1046a
> +          - const: fsl,ls1046a
> +
>        - description: LS1088A based Boards
>          items:
>            - enum:
> --=20
> 2.34.1
>=20

--0wiGOiHK2OaEQY0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYiMQAKCRB4tDGHoIJi
0lDPAP4xEPIQe7SYG7idcSMesMhkCpYcqDXyfz+OZAo9y36gMQEA1/xripnLlq7v
MkEQQAe9S0oZBDagIidd1+kwUIkBrwo=
=Gq/w
-----END PGP SIGNATURE-----

--0wiGOiHK2OaEQY0M--
