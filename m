Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7D765438
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjG0MmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjG0MmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186E1AD;
        Thu, 27 Jul 2023 05:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D1161E69;
        Thu, 27 Jul 2023 12:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF25C433C7;
        Thu, 27 Jul 2023 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690461721;
        bh=u76QON9r9bqHQ8nuI6q4HVmG6VX0hdNyeh59Sx1wr9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T48lB8G1pEzkUGQHFBZGtLaIIjo9XgTcXZF0bPrxRFivavKfsq58vH9OHZKBz/lHQ
         vjZ2J3qYN/MchjALTPUBGlVRMYJ/mCpOEeKY7SxAl/04Rv4GgVBxgkBBuQjJGn7XCA
         w4pIBj+M7rmKZNp439+C6UrYgPFszoD22rmKAnuTwl2LvNPUDGou2ksDtexLKPNzB3
         d3T3Ud+R3mVWt4331tDu62TIbgXvAr9LGoacETCl5DENCDpSH15DYeseKXwO3GKx9q
         PslRYl8A50BmNbNtJPC24cGoGpA8n/NxbJ/uWOUEYKb7zs5Od0kVVMVdKzWsLTMUd+
         jS9oB7HTMMwCQ==
Date:   Thu, 27 Jul 2023 13:41:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2] dt-bindings: irqchip: renesas,irqc: Add r8a779f0
 support
Message-ID: <20230727-untapped-viewable-d29792ae0a3e@spud>
References: <9467a1c67d5d240211f88336973fa968d39cc860.1690446928.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/40/emGKgvUjgPt/"
Content-Disposition: inline
In-Reply-To: <9467a1c67d5d240211f88336973fa968d39cc860.1690446928.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/40/emGKgvUjgPt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 10:36:23AM +0200, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INT-EX) in the Renesas R-Car S4-8 (R8A779F0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> v2:
>   - Add Reviewed-by,
>   - Widen audience after testing.
> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renes=
as,irqc.yaml
> index 95033cb514fbd8f6..b417341fc8ae049b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
=2Eyaml
> @@ -37,6 +37,7 @@ properties:
>            - renesas,intc-ex-r8a77990    # R-Car E3
>            - renesas,intc-ex-r8a77995    # R-Car D3
>            - renesas,intc-ex-r8a779a0    # R-Car V3U
> +          - renesas,intc-ex-r8a779f0    # R-Car S4-8
>            - renesas,intc-ex-r8a779g0    # R-Car V4H
>        - const: renesas,irqc
> =20
> --=20
> 2.34.1
>=20

--/40/emGKgvUjgPt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMJmFAAKCRB4tDGHoIJi
0uLLAQCjxeJyznGkJjjbzEmlstT88bUg7DPy+6tVk7EtqbXRQgD/ZE3xA8w1PHBh
qCSV5ebOcN9m/kHGrzGUpXVt/tcnLQQ=
=QGI6
-----END PGP SIGNATURE-----

--/40/emGKgvUjgPt/--
