Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EF75E2C9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGWPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE94EA;
        Sun, 23 Jul 2023 08:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF57760DCF;
        Sun, 23 Jul 2023 15:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE4C433C7;
        Sun, 23 Jul 2023 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690124790;
        bh=t/2HxDZUY/Jcvt3W77D7mqWzModYoPpij0GRvERZ60Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBPXAHDUa8m9VLl67KXTI0sMyXkvk4Ea7YxxJO6Utxn2P1i/ACiR2wcCtEcgJdTY8
         HoXeJ9ne4aXHeSu4Ti7fKikeSll6YVx0JihBQSXLP/lKjmvVFXN5jsndACttWl4Fel
         muCKUIcciE0F6jzsVWcT1PCYtOc7OuYjFDM4U4cV8xcax0hzLafaMdzVkUvH4BYbVX
         ZWeukjiV3Z+p4yRffIeuXpiEC1SAl8tnc64fBZup+DulcSaMn1iOXtl6YrBkke01+r
         AMq1pnIrTDhgcaIaR0ZLQANuOW1oAkx+l5tYaHoQKMiziPyJTCq2YXG2DKQuqw+fPU
         Sv9eTPWe+GUOA==
Date:   Sun, 23 Jul 2023 16:06:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-ID: <ZL1B8hIM5WB2cE1g@finisterre.sirena.org.uk>
References: <20230723122121.69908-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zk6frfpq665mmFPM"
Content-Disposition: inline
In-Reply-To: <20230723122121.69908-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zk6frfpq665mmFPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 23, 2023 at 02:21:21PM +0200, Krzysztof Kozlowski wrote:

> Convert the bindings for Dialog Semiconductor SLG51000 Voltage Regulator
> to DT schema.  Changes during conversion: do not require the supplies,
> because existing DTS does not provide all of them.

This is a bug in those DTs, any fix that's needed should be done there.

--Zk6frfpq665mmFPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS9QfIACgkQJNaLcl1U
h9DO5Af/RwNJNVSvnrTYgWFDNkAynu+oS/sZuEh6tqmIozemEGXqz4tekQVnqSuz
1o3DDLrY/vtXT2gG8+UUPZt3ynlQJpcjz6S/dn3OlTVxHq1Lm75knBif5EEIYbr5
lXKm9b5s85l9qAVwORwgNbSccIDPzC0ye6U2wgS414FM6wIC6y6QW7EqOKXGu1LB
Bhgy52E7Goei5+a8wlWiZxkTAuoSPY/CtExPzntOdhR8rDlcxUZ5sQ3ELMVaxW+d
373x6ozbnU0FWhD0eHng6f/qdJwzL5X4zT+dryrOrykIC2T6oV89i9Cc9ybV4eTH
szr0gWmFlo2/39zC6MfBmx2bIOgDlw==
=B3Yz
-----END PGP SIGNATURE-----

--Zk6frfpq665mmFPM--
