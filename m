Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663BC7E8C50
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjKKTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKTXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:23:02 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B62C4;
        Sat, 11 Nov 2023 11:22:59 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 12E621C0050; Sat, 11 Nov 2023 20:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699730578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8a7ot37x18JT+gqBEyQGuBYUUHo0Mfh3R3rUO53ekrE=;
        b=W1SXl5yfiiI6QN+D3QxXiEBITIBl4rQVW02b61AygAYWOlX+FTwGPdbtYW2gEAgSf7rSpl
        zPSuzKX7UUojUSqUrDi/SA0C2sH1WDD3FZoaO9SU7IPBarD2+zJ9MGuz5qt5gzByqo6V0+
        0aiqDhEnkZgK8ekM9KIdubOxOW8MMxM=
Date:   Sat, 11 Nov 2023 20:22:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <ZU/O63BglhcWj0dc@duo.ucw.cz>
References: <20231106164134.114668-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="m6I9gBvMJJo5CjCg"
Content-Disposition: inline
In-Reply-To: <20231106164134.114668-1-anshulusr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m6I9gBvMJJo5CjCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Adds bindings for the Adafruit Seesaw Gamepad.
>=20
> The gamepad functions as an i2c device with the default address of 0x50
> and has an IRQ pin that can be enabled in the driver to allow for a rising
> edge trigger on each button press or joystick movement.
>=20
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw

> +    +-----------------------------+
> +    |   ___                       |
> +    |  /   \               (X)    |
> +    | |  S  |  __   __  (Y)   (A) |
> +    |  \___/  |ST| |SE|    (B)    |
> +    |                             |
> +    +-----------------------------+
> +
> +  S -> 10-bit percision bidirectional analog joystick

"preci..."

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--m6I9gBvMJJo5CjCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/UhgAKCRAw5/Bqldv6
8mhEAJ9GdnQClWwau1Z0EtpL/YDx+ogIUgCfVO/WtWIivrvHfY40X2utkhCCPXM=
=dW2+
-----END PGP SIGNATURE-----

--m6I9gBvMJJo5CjCg--
