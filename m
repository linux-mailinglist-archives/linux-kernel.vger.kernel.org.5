Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F14752B07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjGMTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjGMTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516526AE;
        Thu, 13 Jul 2023 12:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54BB61B44;
        Thu, 13 Jul 2023 19:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DFCC433C7;
        Thu, 13 Jul 2023 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689276795;
        bh=swwCrASK4MsXFccBmWXa9izIHsAa/Uh0k81oEqyv7x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQw3MRSqqEIDFUADaHxiVnlxDr2krhWlvM8oWiEkQDnKzAAwBPKCCxBr7iYRQw8Mm
         82iu/YBqpa1SMZ7JhbxlzWsVCwt4oJyuk9pcKM0DzgOu2SiHKU4GuQAPHr59AghAZ7
         DCOFW5lzlox6yIvOSeW6qX58S7AM7H80jlA55EFoWoaQ7cHJ7185dtEV18NrN4KLBG
         vIAICPNnoj9iOf237MBK2Y2iwFGx00LTO6fLDe7YCa9kwseeakg2DduOL9P9Zd+qk6
         Dq0hosXDdqa7tIYEYmQeYqugdBes99Chen6PlbBHLVJBT9yvf1jQl8wa2GF6AtgZq2
         gcdxJjfkhnDyg==
Date:   Thu, 13 Jul 2023 20:33:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: crypto: add new compatible for
 stm32-hash
Message-ID: <20230713-scribble-unfounded-28ca40b49f57@spud>
References: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
 <20230713151518.1513949-2-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2NqPxhuuW44NJK8"
Content-Disposition: inline
In-Reply-To: <20230713151518.1513949-2-thomas.bourgoin@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r2NqPxhuuW44NJK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:15:12PM +0200, Thomas BOURGOIN wrote:
> From: Lionel Debieve <lionel.debieve@foss.st.com>
>=20
> Add a new compatible for stm32mp13 support.
>=20
> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--r2NqPxhuuW44NJK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBRdQAKCRB4tDGHoIJi
0gD7AQDZlMvw7qcfosAQRsO1dpFw+U1cXwLJ7wUdywXY6RAmRgEA60IxnVvAz1EF
9VZFqXqKuxCBhtIgHsS6UJUlasNIEAI=
=XSsY
-----END PGP SIGNATURE-----

--r2NqPxhuuW44NJK8--
