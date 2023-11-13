Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51C7EA41A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKMT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKMT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:58:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA491
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:58:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A820AC433C9;
        Mon, 13 Nov 2023 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699905491;
        bh=xoeYl7TuE4EF2D7ncM6qCuxVxFvqvn3WKO30B5QlGjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8Kp98Q/djwyG6tO7zVzDC1RVushteYHc30PJP1mfd1tgsPLnoxPDiP42QZTbodSK
         115H8VZp39qYLABPwaTicNtwFKQIeGRaUVOq6StnsmeRE7aRu+crUSL8+9Ryb5ODeP
         5PVCTpusM+Z+XgFNR9cR03HGszPIT7Rlty710gTn1l+1+c//rrfFPAyDojjucTUE/w
         KfyTfQrCHGSoPV8xcqxZuuuLU2k2Nx9TjZ4DlNSGf0lwBNpowUdkahlLLOz8dv6A7j
         Av+weaKLu5FGU1Us1IGCIee0BW/S/phHH3P7x/Aqsfp+ntUShfASPPecVM+3GGDYqf
         biRFJcgjINOkg==
Date:   Mon, 13 Nov 2023 19:58:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Message-ID: <20231113-putdown-handwrite-ddc4abe65266@squawk>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-1-ad1ee714835c@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jE6N+wTYJsLt+sDI"
Content-Disposition: inline
In-Reply-To: <20231113-j7200-usb-suspend-v1-1-ad1ee714835c@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jE6N+wTYJsLt+sDI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 03:26:56PM +0100, Th=E9o Lebrun wrote:
> On this platform, the controller is reset on resume. This makes it have
> a different behavior from other platforms.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Do=
cumentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 95ff9791baea..77e0c0499936 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - const: ti,j7200-usb
>        - const: ti,j721e-usb
>        - const: ti,am64-usb
>        - items:
>=20
> --=20
> 2.41.0
>=20

--jE6N+wTYJsLt+sDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVJ/ywAKCRB4tDGHoIJi
0hzZAPwJimQsKLDjP4mD+2DufjQwF5bVQRQVj2lSAAYJ7+YVTQD+IkP9LcRN/CWV
tjMAeeidQdu6hYYI1q9kM+RxFzT/2gs=
=YHV2
-----END PGP SIGNATURE-----

--jE6N+wTYJsLt+sDI--
