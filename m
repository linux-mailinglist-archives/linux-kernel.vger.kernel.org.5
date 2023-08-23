Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77478785960
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjHWNbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjHWNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B01720;
        Wed, 23 Aug 2023 06:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A123662F4;
        Wed, 23 Aug 2023 13:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD46BC433C7;
        Wed, 23 Aug 2023 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692797376;
        bh=NFe09BLTwI6EXzfx6Y6VNCzXPE7zpcUy4rcY7EE0zr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCj+wBUt/EmZ6GHed1VrFjaZS9DehCo3T5PWHyIWqvgodHG1bOIrm+qPEnyUWXEAr
         FgRt+2lYfXgJ1AKEfXFoITnrr/Z9GoUUVWQhVXu4FLWS9L7p71Tl+6JnK9c5cuhn8R
         MydBvrMO1sAnNo+ZDOzU1slqaO0/Sb3gSn6/mFe+qiWZUs94NiXhyVXvf+xlGWmesq
         vsEkPTKLhaI3R6r4rVjVoJupi6Awv4iRbUKj0WaHHIYnYgZlDvV47dMGxpzjbykHsJ
         x8M4t6U1QhNo5Vhu386uzZp0hcFeMuqP6+2/WgmcF+2RcY+xoMrzGK2IlzGbV+eaJZ
         iUE6uqbS0mnZQ==
Date:   Wed, 23 Aug 2023 14:29:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: use capital "OR" for multiple licenses in
 SPDX
Message-ID: <20230823-alabaster-omission-a35a29198fd0@spud>
References: <20230823085238.113642-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwG12TuW3Ar4PyZi"
Content-Disposition: inline
In-Reply-To: <20230823085238.113642-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwG12TuW3Ar4PyZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:52:38AM +0200, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--zwG12TuW3Ar4PyZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYJuwAKCRB4tDGHoIJi
0gLyAQD/H6s2mLMFq0aJbyPKB3WgSjepxLVIu2NsGm8Vn5FfeQEAqpZfLXseCpH3
tYdgNMuExBww/q2bYbRydZH7E/cbXAk=
=in4T
-----END PGP SIGNATURE-----

--zwG12TuW3Ar4PyZi--
