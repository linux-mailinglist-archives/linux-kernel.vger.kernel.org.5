Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC475DC54
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGVMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGVMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B861B2;
        Sat, 22 Jul 2023 05:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA0A60AC2;
        Sat, 22 Jul 2023 12:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855CFC433C7;
        Sat, 22 Jul 2023 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690027231;
        bh=3aXluOeHEQMyItJ/v2l7mH04udA2/MJByvhDdbra3VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCGL5MIEnYK/Q+LxtrZ/qsyM4pz4Wujq37xIri7r+PnlkSwo2RRmNpY0T/SwzR4Ze
         80+OoFGGBI2gtlFiFNWRrErleRBf0OTewqhYa7KPOlJMAyNRfjyD0Y2t8Z2pfYDjmZ
         Q7WdD/Kut68WzRCdagPzYRPhv3RVkybPZVbu2ukktoe2ygCtyvCfvBqXD3TYraXivO
         I6mIWAXVc5ucuJuEe5E6PAnCgkTtuDMerE69I7Lcs4AkV2xyn02EdHJmk4ZpqmXy5c
         hfF4yAB4rQ+yQcoAYuYOjrvPHf4p+MRB+RMspyFYAem+3qFmw/DX0IT9K73CLQjBMI
         QZsvVFXsg/pZg==
Date:   Sat, 22 Jul 2023 13:00:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: dt-bindings: samsung,fimc: correct unit
 addresses in DTS example
Message-ID: <20230722-upstroke-vastness-6d8221298a0b@spud>
References: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
 <20230722115441.139628-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YJECmpCRkK1kwFD2"
Content-Disposition: inline
In-Reply-To: <20230722115441.139628-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YJECmpCRkK1kwFD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 01:54:40PM +0200, Krzysztof Kozlowski wrote:
> The camera node's ranges property and unit addresses of its children
> were not correct.  If camera is @11800000, then its fimc child is @0.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--YJECmpCRkK1kwFD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvE2wAKCRB4tDGHoIJi
0uFZAQCgPYDHFVe+NeMLnFWbsOlNJQCQCDGD3o2KpaRWTacoIAEA7R5O3ItL9YS5
l7yPCbSxhbknZSs0/vLabFRgazvVaAY=
=GDU6
-----END PGP SIGNATURE-----

--YJECmpCRkK1kwFD2--
