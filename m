Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5D773E75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjHHQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjHHQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CB12532;
        Tue,  8 Aug 2023 08:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E5462529;
        Tue,  8 Aug 2023 12:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA43C433C8;
        Tue,  8 Aug 2023 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691496690;
        bh=96VTB/JKve/lcwcYA/LVnZ1+6F4oYEZrmgfcvmfSTM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGRUeMhvgx8j7ItBIo8IDG4iysdY+5QTLi8NJackenmM6S0mnqJu5JtIThopDGbS0
         r601kiz6J//C6Zi8CsMcMnJCbEavL+yZ5PBI9K4+xg15YJGdJavbEuCNXaYLZ7GdDX
         TBlUksujh06CbwXRUkCowZ1SQyOeMlYHh+SAdeQ3baLFpAsSAn9jw7kf5EpIHvPIME
         CBVgZxbLbKA36f+/wAn5DgbaSO5NL8oNQyz0RJ+XS0zuCK27qLKnv+JFAqJb2j8aOg
         F52ZqLau9HBXQH76LcOoZh/e8s/tL/8N8wEouLdPicbQ6toqSuOP/NauDtkoEvqR8d
         KZxwvJP8bsRqQ==
Date:   Tue, 8 Aug 2023 13:11:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, lists@kaiser.cx,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/3] dt-bindings: rng: meson: add meson-rng-s4
 compatible
Message-ID: <20230808-diabetes-ultimate-f3f4afc53d6d@spud>
References: <20230807130611.63914-1-avromanov@sberdevices.ru>
 <20230807130611.63914-3-avromanov@sberdevices.ru>
 <20230808-calcium-smasher-5f6c410fb226@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Io72FXexd1hCxZL"
Content-Disposition: inline
In-Reply-To: <20230808-calcium-smasher-5f6c410fb226@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Io72FXexd1hCxZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 01:09:45PM +0100, Conor Dooley wrote:
> On Mon, Aug 07, 2023 at 04:06:10PM +0300, Alexey Romanov wrote:
> > Now the driver has a separate algo for S4 SoC.
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Actually, one comment, please, for bindings, write commit messages that
relate to the hardware rather than drivers. The bindings describe the
hardware, after all.

--0Io72FXexd1hCxZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIw6wAKCRB4tDGHoIJi
0ufhAQDEwiUsmmmJ5vqZLwTZzcnnxminVSw73imTDPpTMWNkXwEAmLS4+h8XAIUR
6XGM49WckQHg/4mRuvhymrjQWwbtgAQ=
=X56w
-----END PGP SIGNATURE-----

--0Io72FXexd1hCxZL--
