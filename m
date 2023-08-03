Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED876EE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjHCPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjHCPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A42D2690;
        Thu,  3 Aug 2023 08:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398D361E08;
        Thu,  3 Aug 2023 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E8BC433C7;
        Thu,  3 Aug 2023 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691077475;
        bh=En5QyA0lJzgjWSas3jJGqLFEUHvjMDKFwxiBOjVfUzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxmT78PTQB2GgjCs0bpIDgOjTT3sa7NzBO2zRRNOohAxCMzBn0CzfDCQG5g2+jva3
         IMhI8Q1FWIUWk0OKed2ZMs2mGhbepFwd4Ds3UghI/wLSzsQS9ipz6Sd9VyZ/nYYeRy
         2TxDsNXDbmejP6muNUbWO883x0JMkQ5GJdfbhBjkMgXOve24ZSw/tfbE1qfOQ0fANS
         2UTnjrisj++zXPKXLKTqBa0+REeiZx4w0clhhgiwkjOxjgrJLTHbd7k97fD0OKkO4e
         blr1Mngy7cM36IH0o48GRJaaK5ZwaJ8bMi25YsylnLNOoElza5LxRpT+AQ+CIXWrY8
         cbO9AjN+NrMfA==
Date:   Thu, 3 Aug 2023 16:44:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm: add bindings for ASUS
 RT-AC3100
Message-ID: <20230803-cycle-overshot-7be95c4a7214@spud>
References: <20230803071454.5902-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kZ8/qCnWcN91TUyq"
Content-Disposition: inline
In-Reply-To: <20230803071454.5902-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kZ8/qCnWcN91TUyq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:14:53AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> Add ASUS RT-AC3100 under BCM47094 based boards.
>=20
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml =
b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
> index 5c3ac97e8728..4cc4e6754681 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
> @@ -66,6 +66,7 @@ properties:
>        - description: BCM47094 based boards
>          items:
>            - enum:
> +              - asus,rt-ac3100
>                - asus,rt-ac88u
>                - dlink,dir-885l
>                - dlink,dir-890l
> --=20
> 2.39.2
>=20

--kZ8/qCnWcN91TUyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvLXAAKCRB4tDGHoIJi
0iTgAP9RSWTNb+xS+YaFd2K7zA09TomDiuCu3NUsHPF7iog49gEAluPjktjQUjrD
aPHIMR9ep1B2ehNZ8SnMiTlhfxyhrwM=
=rSWW
-----END PGP SIGNATURE-----

--kZ8/qCnWcN91TUyq--
