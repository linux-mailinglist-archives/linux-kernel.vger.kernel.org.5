Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA577CD39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjHONQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjHONPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D631987;
        Tue, 15 Aug 2023 06:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDFE64B6F;
        Tue, 15 Aug 2023 13:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60FEC433C8;
        Tue, 15 Aug 2023 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692105352;
        bh=6FTVwttGp7chwo11oWnhEZ9wZckkKOHug2miCE397ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbI0HlXQewxzvJ6YTJQuikwBHTi36gjuGbWFdSTFVusa8Ef6yDdYddu+OBeo69n0A
         ACq0jUo9Ql6ZDSYQL3DTFKZHW3+6hfz5PMv7KiR7Nmlm0PGWIYBIMEITJshC08f9Up
         zYWn9LTS5LdGdzcDVZfKYCNnlPQNZr9WmSGfJU+AD09U6QI9SkWNGdRJoImUmthQxX
         hkLC0zEmjdp1+GR3hlErUaAaSmDp5nrS0oBljKRzG6G/KzLrDSkQkDxnFt79+szoLu
         cVz/rq2K/PFOIwEHH+pAbi72ziZdkfvEohKcRkfJ745cs6cf06NdEk9LlCE0HKsp7B
         a29yV1t20pyZg==
Date:   Tue, 15 Aug 2023 14:15:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/2] riscv: Add BeagleV Ahead board support
Message-ID: <20230815-aroma-graveyard-f1fcc61e5030@spud>
References: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gZHHsx5XRZBY8TJZ"
Content-Disposition: inline
In-Reply-To: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gZHHsx5XRZBY8TJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Fri, Aug 11, 2023 at 05:47:15PM -0700, Drew Fustini wrote:
> The BeagleV Ahead single board computer [1] features the T-Head TH1520
> SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
> minimal device tree file to support booting to a basic shell [3].

Am I supposed to take this, or will you? I still don't know where I
stand with any of this and will default to assuming things are for me
to take in the absence of clarity.

Thanks,
Conor.

>=20
> Changes since v2:
> - Drop the MAINTAINERS patch as it is not important and I want this
>   patch series to make it into the next PR
> - Add Conor's R-b
>=20
> Changes since v1:
> - Add dual license to dts file as Conor noted this is typical
> - Reorder new entry in thead.yaml to maintain alphabetical order per
>   suggestion by Krzysztof
> - Add A-b's and R-b's from v1
>=20
> [1] https://beagleboard.org/beaglev-ahead
> [2] https://lore.kernel.org/linux-riscv/20230617161529.2092-1-jszhang@ker=
nel.org/
> [3] https://gist.github.com/pdp7/91b98f5b8a632802e669d8c359f4f498
>=20
> To: Jisheng Zhang <jszhang@kernel.org>
> To: Guo Ren <guoren@kernel.org>
> To: Fu Wei <wefu@redhat.com>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Paul Walmsley <paul.walmsley@sifive.com>
> To: Palmer Dabbelt <palmer@dabbelt.com>
> To: Albert Ou <aou@eecs.berkeley.edu>
> To: Conor Dooley <conor@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Robert Nelson <robertcnelson@beagleboard.org>
> Cc: Jason Kridner <jkridner@beagleboard.org>
>=20
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Drew Fustini (2):
>       dt-bindings: riscv: Add BeagleV Ahead board compatibles
>       riscv: dts: thead: add BeagleV Ahead board device tree
>=20
>  Documentation/devicetree/bindings/riscv/thead.yaml |  4 ++
>  arch/riscv/boot/dts/thead/Makefile                 |  2 +-
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++=
++++++
>  3 files changed, 66 insertions(+), 1 deletion(-)
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230811-ahead-dt-v3-1d7e85fce20f
>=20
> Best regards,
> --=20
> Drew Fustini <dfustini@baylibre.com>
>=20

--gZHHsx5XRZBY8TJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNt6ggAKCRB4tDGHoIJi
0iJzAQDJ+f5M3D8HQ7Py0wvo08R6+GUN8qw1shNg6Qg89SJ+2AD/UK4zthaeE8OO
XrUhvFuiqFQV6Lk40KCdbMc+d3ZQNQg=
=JfDz
-----END PGP SIGNATURE-----

--gZHHsx5XRZBY8TJZ--
