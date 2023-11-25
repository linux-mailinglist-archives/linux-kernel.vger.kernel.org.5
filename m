Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436A37F8A12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjKYLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:06:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB010D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:06:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A55C433C7;
        Sat, 25 Nov 2023 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700910378;
        bh=a10BKOzNP25vy7u3Wr900/nhqUYn6t0HQHvCMFsPHXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzQAqc91AzXTfJr0YMNQk4Fb8ANi3UGp7ws1OpgA134zeMmi16feg/71FpWu/RRad
         hgEimPRXrCBFQPja2QUhaktDDe0g3JTP7Lo6sH9/6GXqTybrAoNZWQgTPqocAWw2fR
         xKpaN6KhvfkenJnRasNXc+kpv4jHsOpPhVY1FVzjEJd1tKA3A/K2P7enxMj4c18BuT
         tP1yhNA8lq5FHA/nmG1RTwfrAROJVllv6hM6Zy7Y+WDjCqFF2YaROv+/jgV6bjtTmH
         4JDccMs4Puqv94kUHM+nK/wfz90JM/BkkbRmxra8goAAA6NCb6to4+fU9GVktRb6RR
         yv5TIhyGpq7aQ==
Date:   Sat, 25 Nov 2023 11:06:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luka Panio <lukapanio@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v10 1/2] Add a compatible for Xiaomi Pad 6.
Message-ID: <20231125-scientist-autograph-a574e56ea955@spud>
References: <20231124212732.731419-1-lukapanio@gmail.com>
 <2023112529-fetch-unwritten-bdbd@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZAE8VA0RYnei4ICF"
Content-Disposition: inline
In-Reply-To: <2023112529-fetch-unwritten-bdbd@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZAE8VA0RYnei4ICF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 06:53:05AM +0000, Greg KH wrote:
> On Fri, Nov 24, 2023 at 10:27:31PM +0100, Luka Panio wrote:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Luka Panio <lukapanio@gmail.com>
> >=20
> > ---
> > v2:
> > Update commit message
>=20
> What commit message?  I know I can't take patches without any changelog
> text, maybe other maintainers are more loose?

It had one when I acked it.

--ZAE8VA0RYnei4ICF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWHVJQAKCRB4tDGHoIJi
0u6wAQDJyRyc1NwXIbDW0Y1VdQakWopuCXfjrBNh84wm0Zyt7AD/QNDxBjigVIUH
AoGUgSjTd+6ukjv5UhZUnzuMhVXs3gs=
=xDZq
-----END PGP SIGNATURE-----

--ZAE8VA0RYnei4ICF--
