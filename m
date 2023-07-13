Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A159752AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjGMTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGMTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA52D69;
        Thu, 13 Jul 2023 12:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C31D61B24;
        Thu, 13 Jul 2023 19:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30829C433C7;
        Thu, 13 Jul 2023 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689276641;
        bh=yHyleVf55ms5OcbTmxlWVK0NQdIvDY066IjRVG6q0Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdigQ6RU6vfvQNsqmZxPwN25ZmnXh80xsn+RuEvGOr/DbpVvcv6y2nR4cdAuxwkM1
         UzWKhWr4Pp98kcxtFf2TJxiLKi7hTXXKsubITcfk4fYT4wscvT0DlmE2jzJ3+a7ZpN
         UOp/Nmk7CDi699x8IIDjbxjrN9Z11JTEOLGcdzLQtTyNdxAHJ0epfw4a3G6e2d39lc
         0EiyUbA22YSCNuLVbbboo/VTbVCuyZyPpqQqBQxyEyeueQKMtBK9FHW3SMymyjlqEM
         B5CiKpEcicOPSEXhHNkzcz9UZw2ojvuTZZC30/6Aroi/28UP9O7e2n/RApHg9SRCHG
         IdtEzW4ceSjVg==
Date:   Thu, 13 Jul 2023 20:30:36 +0100
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
Subject: Re: [PATCH 3/3] dt-bindings: net: davicom,dm9000: convert to DT
 schema
Message-ID: <20230713-putdown-submersed-ec2306a7e484@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KOCyIo0M2eMeOzL3"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KOCyIo0M2eMeOzL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:48PM +0200, Krzysztof Kozlowski wrote:
> Convert the Davicom DM9000 Fast Ethernet Controller bindings to DT
> schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Seems like a faithful conversion to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KOCyIo0M2eMeOzL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBQ3AAKCRB4tDGHoIJi
0vhaAP0QNEgWAMAo3BUKQl5mNSLdydSpPdJ6kTA1v6E2KB2DgAEApWcE5EffscXW
ZWE1qQYgjo8yAE4+7qq2Jy49AcDfqgM=
=mOdJ
-----END PGP SIGNATURE-----

--KOCyIo0M2eMeOzL3--
