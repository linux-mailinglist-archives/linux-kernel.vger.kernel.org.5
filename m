Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA0752AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjGMTbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGMTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CB2722;
        Thu, 13 Jul 2023 12:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033CE61B43;
        Thu, 13 Jul 2023 19:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E57C433C9;
        Thu, 13 Jul 2023 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689276666;
        bh=NF5yZAAgooAQlnpwD7HEyp3sC7TthSVdoNdpc3rPOiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1uN6jphzQUuckMjqodwu+gqtdc0TWbHHyq740yYaIxSfLoqR1dc9ogCfXu4r87kx
         fHt/ScYPHTFFR7V2shfMjmM+o2f8RAtdkXfpPfL+R2dZB9gzuxL4eXzSvUt2ozMNxQ
         4/1oaVc8M5FeVYRKrq8ug3QOrwWLTZgoN2jJBlm8VA8uu9Avf+B3q6WPUfgZ9ImtKC
         QGguBS//dXBJb+/LtcfBwYNE+5tJiEPVBCnmgETlU4WVUaOVq1fESiAyUchhWGk8B5
         gj099Q1VyoXpOGS4VM94dfjkAqBxY1hbnMai3BtFJ3EFLePULgqIa7Hp5a2507g0YN
         mfdU2/YVcsVjw==
Date:   Thu, 13 Jul 2023 20:31:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: memory-controllers: reference TI GPMC
 peripheral properties
Message-ID: <20230713-vertebrae-declared-f83a0f836ecd@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="53x7rfT98yyxKzvW"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--53x7rfT98yyxKzvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:47PM +0200, Krzysztof Kozlowski wrote:
> Reference the Texas Instruments GPMC Bus Child Nodes schema with
> peripheral properties, in common Memory Controller bus
> Peripheral-specific schema, to allow properly validate devices like
> davicom,dm9000.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--53x7rfT98yyxKzvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBQ9QAKCRB4tDGHoIJi
0gdhAQC3JA+5u3kXmUp6gSJWwfdXB5C8Ex2NP56NKa9NVyb0ogD+O6TXWOm7QWAV
n6sAQvE2F6swQzSBBJ90FkLmBAhYPgo=
=DBJn
-----END PGP SIGNATURE-----

--53x7rfT98yyxKzvW--
