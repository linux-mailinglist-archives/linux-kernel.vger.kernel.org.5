Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D041975E5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 01:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGWXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 19:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGWXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 19:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A4E78;
        Sun, 23 Jul 2023 16:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE03260E9C;
        Sun, 23 Jul 2023 23:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197BFC433C7;
        Sun, 23 Jul 2023 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690154403;
        bh=g8SzQXFzpEBeTHxOxGlzKqVUPbZUuS6W4t99oZqHAxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OViqbWr5eRhdTDonKw3okEYaqpSzDRH78ixWzUh65LtIZ8WwvcOIYNhWbaZ01bS1Z
         xoOLXbRPSMcGQUzfi2EaKs+nPrm0QN2wmnZXs7BGvAY/d+zhEJuKBBiP5vJE6wGMBY
         pZcpGJd+NREdjqOeCI/OlgdryqLwC/LSdbH4v42cVETAlAwhnd1H33hI8ewvakDjW3
         /57GkMzVET9oJsAwIc6BqBUX6A/0Y8o//hYf5bEpb1dS3fxovIKge1h60fWjEahkgU
         AfjD9tuVze7nsiJZl9pXcfn9GMjigqSdsdAAKs7pBAtsHJGi1dfjkm8QPCUHbOR1bd
         wmxt+PmrKJYCw==
Date:   Mon, 24 Jul 2023 00:19:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the riscv-dt tree
Message-ID: <20230724-enclosure-imprint-e502e7414ce6@spud>
References: <20230724084817.0ed6cbf4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RKXUebwcOE38mN55"
Content-Disposition: inline
In-Reply-To: <20230724084817.0ed6cbf4@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RKXUebwcOE38mN55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 08:48:17AM +1000, Stephen Rothwell wrote:

> In commit
>=20
>   8e421af310dc ("riscv: dts: starfive: remove undocumented phy properties=
")
>=20
> Fixes tag
>=20
>   Fixes: b15a73c358d1 ("riscv: dts: starfive: visionfive2: Add configurat=
ion of gmac and phy")
>=20
> has these problem(s):
>=20
>   - Subject does not match target commit subject
>=20
> Thus
>=20
> Fixes: b15a73c358d1 ("riscv: dts: starfive: visionfive 2: Add configurati=
on of gmac and phy")

Hopefully the commit will go away entirely when I get sent a real fix
for b15a73c358d1, but Fixes: tag duly fixed nonetheless. Thanks.

--RKXUebwcOE38mN55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL21nwAKCRB4tDGHoIJi
0ur6AP9VNtdU7MLD+wO9g1rB+u1gC7K16cpoPz81B2E1abNyhAEAtLbRsylC+8Hr
1S4axwhPniUJiYpXcfygGoTgZ6v4tgU=
=stOX
-----END PGP SIGNATURE-----

--RKXUebwcOE38mN55--
