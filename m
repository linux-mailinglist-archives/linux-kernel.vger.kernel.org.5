Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7697E8B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjKKQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:29:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7192D7C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:29:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C4C433C7;
        Sat, 11 Nov 2023 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699720191;
        bh=hDeok4VwtGBImKqmRhCT3wLseQRJ3N3dIiy/AHeJ2jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fw0uxGpyLZFw4H1OobtInNXkdaJKsmTa3oW1GHxOusZI+voU54E5nAOX7PiCvAWmQ
         0hWGkAzcaHokATBEZ8qM4IV2+zAlwyb+sWSwVbY4ZAhFbkvNv7KjAWIICJcPi7f5oF
         gmJNarWQpcxUurPoeAsNZjkLDinttnXnebAjaVXRSWK+l+ApxyWUzxIJ3Hp/raMuFk
         l40E/zSSHdg39zmQuooEFznADdSL5zwLZq5HLwWoBNxGfPrpaxJ4eTuGFT+bWN5Dme
         n3LWbbgGJGkmou2nMh5j5w0DWQY0EjAsm/WE8Jy+vghnWafjAuRFIP4pv7Eqp0dD+5
         Td0wQq4W8CDyw==
Date:   Sat, 11 Nov 2023 16:29:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: samsung,s6sy761: convert to DT schema
Message-ID: <20231111-mothball-diploma-c034c0622bc6@squawk>
References: <20231111143221.55452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TOjGpG9yBBBwqB/s"
Content-Disposition: inline
In-Reply-To: <20231111143221.55452-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TOjGpG9yBBBwqB/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 03:32:21PM +0100, Krzysztof Kozlowski wrote:
> Convert Samsung  S6SY761 touchscreen controller bindings to DT schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--TOjGpG9yBBBwqB/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU+r+QAKCRB4tDGHoIJi
0pVoAQDtJ7zs05y0VmoVNpU0At08PqscThaQzG3jxWGhVKIWoAD/U203WC0BIUDe
Ctz+H0qBWmNRkoteTxxc/5qYk1pNsAA=
=8GRI
-----END PGP SIGNATURE-----

--TOjGpG9yBBBwqB/s--
