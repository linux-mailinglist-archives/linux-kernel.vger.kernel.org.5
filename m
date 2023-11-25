Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843E47F8A50
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjKYLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjKYLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:45:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584C10F0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:46:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94713C433C9;
        Sat, 25 Nov 2023 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700912764;
        bh=oR2hnb3Bl7ZQBHF7pVNVNr9cSvQhx/EmQ5RXPSn1AV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA2oAxevVVzBwx3RZB+eHCPV6AU3wc0KpHP+/3ea1rvlMCmh5nZJYmi/iwitnbUFp
         is/DUnoUG8ps3ZSmb6wIZAzh+JRKRIkNQ9HY5+C1r8llcK/zy14F/PrIwKqX8Cb3Pl
         MufYaPC7v77pkDRMQM/CckTjVMdzHJiC219nJHk5UITsHjGo2JO96rTXD25sgR5Iz9
         +IdE26URAC05uOcIr49cGi+M0oXBgbkmOrr2yiFU5Waqyx5vvV7cT0tkX3xHUxSE9L
         c4AZ2tMdDBOV6IyEJK8w5bTg5yNlfbYQwQPqFlPkfiXR+7gtFqlSv/v7DILCokC1vL
         6VnIzvTdWwh0g==
Date:   Sat, 25 Nov 2023 11:46:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: mfd: ti,twl: Document
 system-power-controller
Message-ID: <20231125-ramrod-turbine-084ac36a7916@spud>
References: <20231125092938.16535-1-andreas@kemnade.info>
 <20231125092938.16535-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BHb+UNfFvgB7JgAZ"
Content-Disposition: inline
In-Reply-To: <20231125092938.16535-2-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BHb+UNfFvgB7JgAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 10:29:33AM +0100, Andreas Kemnade wrote:
> Add system-power-controller property because these chips
> can power off the device.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BHb+UNfFvgB7JgAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWHeeAAKCRB4tDGHoIJi
0u0cAQC7MOQrodkISngJv/6KoriZmS4apiDChQBzyageiRRAAAD8DrOxoF3Qllj8
+Dd0oMKVoims9s51dkpBqxbXE/1UpQQ=
=AWYU
-----END PGP SIGNATURE-----

--BHb+UNfFvgB7JgAZ--
