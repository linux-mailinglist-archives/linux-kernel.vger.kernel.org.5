Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF2790772
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352013AbjIBKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352022AbjIBKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B59172E;
        Sat,  2 Sep 2023 03:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3206660C77;
        Sat,  2 Sep 2023 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E6C433C7;
        Sat,  2 Sep 2023 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693651842;
        bh=O3YmJo8FcapnhpQ93VprrOEBLBb9phS36hAcskcOmoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khN1kr2gOCIsvMFP2mxg2IHEPDDT6fvKBX+Rm6uDNLl9azTrewe35pRdgoFsWjCUN
         ZJJbP9cwlemhFGdDCU/SCd+ZEzsTKHp24JXYj2IfMYF6p8nLPS9quaeOMixKap1vF3
         7nlmw0W/RSNWKZWxDr3JbG0Venlvzn5SgpCntUlLNq+I6rQriVDEa6HZgjtw+phvES
         2s2UXoRxY3aOo7BCKULrTbkuT5hXy8uQuEX5Rq0lJ6YEpNatAmjfknkysPDcdSCUzG
         HPData92iKjfS4qn7IES7TWw3XHWNqu2lOCyn5Va/PeJeRtv9qp3i01O+CDSt669Ax
         rsD8refe/o8dw==
Date:   Sat, 2 Sep 2023 11:50:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: media: remove nokia,n900-ir as
 pwm-ir-tx is compatible
Message-ID: <20230902-gender-sandstone-7da75af72f4f@spud>
References: <cover.1693577725.git.sean@mess.org>
 <25e8f2626d15199a1bf727fee375b5b149004c8e.1693577725.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2FKLhAY1Fc7AvUtp"
Content-Disposition: inline
In-Reply-To: <25e8f2626d15199a1bf727fee375b5b149004c8e.1693577725.git.sean@mess.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FKLhAY1Fc7AvUtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 03:18:55PM +0100, Sean Young wrote:
> The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
> can be removed.
>=20
> Signed-off-by: Sean Young <sean@mess.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/leds/irled/pwm-ir-tx.yaml        |  5 ++++-
>  .../devicetree/bindings/media/nokia,n900-ir   | 20 -------------------
>  2 files changed, 4 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir
>=20
> diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml =
b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> index f2a6fa140f38..7526e3149f72 100644
> --- a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> +++ b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
> @@ -15,7 +15,10 @@ description:
> =20
>  properties:
>    compatible:
> -    const: pwm-ir-tx
> +    oneOf:
> +      - const: pwm-ir-tx
> +      - const: nokia,n900-ir
> +        deprecated: true
> =20
>    pwms:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/media/nokia,n900-ir b/Docu=
mentation/devicetree/bindings/media/nokia,n900-ir
> deleted file mode 100644
> index 13a18ce37dd1..000000000000
> --- a/Documentation/devicetree/bindings/media/nokia,n900-ir
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
> -
> -Required properties:
> -	- compatible: should be "nokia,n900-ir".
> -	- pwms: specifies PWM used for IR signal transmission.
> -
> -Example node:
> -
> -	pwm9: dmtimer-pwm@9 {
> -		compatible =3D "ti,omap-dmtimer-pwm";
> -		ti,timers =3D <&timer9>;
> -		ti,clock-source =3D <0x00>; /* timer_sys_ck */
> -		#pwm-cells =3D <3>;
> -	};
> -
> -	ir: n900-ir {
> -		compatible =3D "nokia,n900-ir";
> -
> -		pwms =3D <&pwm9 0 26316 0>; /* 38000 Hz */
> -	};
> --=20
> 2.42.0
>=20

--2FKLhAY1Fc7AvUtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPMTfQAKCRB4tDGHoIJi
0p0/AP9ZzLB/zSJoS6xD2RkcZoRzaH8n6vM+cyacmCaUjNkrPQD/XKBiYxaVvTl7
8g2/2pBmv90wG05kDRzPPMjKwq4B6ws=
=DKqi
-----END PGP SIGNATURE-----

--2FKLhAY1Fc7AvUtp--
