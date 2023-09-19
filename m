Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17087A5A09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjISGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjISGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89240100;
        Mon, 18 Sep 2023 23:37:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFBBC433C7;
        Tue, 19 Sep 2023 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695105445;
        bh=UDYumHKPlmcyCLhfdVia1htA+iJ4cgkrKSyPRLPHfrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxzoyAqEa5DZswD9+uFFntb7JNdvPcgOJXDH7Z3e3V2Rgi1kg9OOgSltjjTMGGDmO
         2MB5z5COqXwfpRHG0gSepxV89d2Y+EYCbHGfrsmMceoWp/FUBRWDHJx305DEdL0uGS
         Lq+zBOJIz9YykKe738bo7o+wzHGWPU5z4nhMsAZA6m6ErxQP+If2y1JRnKS4oazqVk
         2FxrjTzuF4do1xpMMg9edK0fkIJc7DXkcAS83dArr7y9iWbfNCoCfYPViQpK/Shtue
         F0bmFMPQQ1FLPV+e8woX2TlEL0r/wHa3seK8Ccnu1UEsoVBpT4cx6ZCREao06X4xrZ
         3ElH+etWX6SxQ==
Date:   Tue, 19 Sep 2023 08:37:21 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Message-ID: <ZQlBoYARkOBbk6TQ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org
References: <20230916091125.3221-1-wsa@kernel.org>
 <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
 <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
 <ZQhOGY+tr25CDuI3@shikoro>
 <19db0278-b11d-49f3-819b-cbc998769832@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MxqMt97sE1YYoKnr"
Content-Disposition: inline
In-Reply-To: <19db0278-b11d-49f3-819b-cbc998769832@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MxqMt97sE1YYoKnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

> arch/arm/configs/pxa_defconfig:CONFIG_MTD_AR7_PARTS=m

Thanks, I removed this line as well.

> Other than that, LGTM and thanks for doing that clean up.

Cool, thanks for the review!

Happy hacking,

   Wolfram


--MxqMt97sE1YYoKnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUJQZ0ACgkQFA3kzBSg
KbYVEA/8CsioS2Lk02C/5WfGfw0udn2xWu/xGXBndxCsobxCNoBpkaHSkErFD76m
YRkFo9TQ1j6FrjTd5CHxSBFCM1wq0THwZE6vYkHHmIM6N+plDppDmuvVFyRL1xE7
XqrSpFaPQO2+qBzLUBX/LueP9WDTc53ZQNTgEzVfIne+9HNVni04dp1VubTBRpaf
5L/tVGBFAz/+QL9KWP1O+TQXOiIAYdUYTPqVUOWe1AQ79uE83iz+27caQ0AsNMtu
We+x1se1VWzo4wHmn5ARs4Ze3vaXe/NQYdwT0BfsLslWsmJ9g8HRqA8CPv1E9B/5
k7TL3Clyo3DI3LDYeyLGiWWwN+WZfm9Lx6hULwe3G7JarUJ8tkcydipSUtD3WFj/
o+YSUn6/RpmBTsxnNAxvbwAn4hoHt7zIfcdAaqxqngVgHNdt0ps1CT9fgwC2QCZc
DNFikwzJP4h4ahnEx5lDOZYZcagGM7sX+3xf94nJqrj1I0TN+xd0be3IXY6d/4DK
Qv+kL8FPgGLohN/GGxkxmJ0+rzgVIT0hFf1nWmgNFLcKDdeRl1qSPINHmZKZncSn
RVF5CShK/NpTeyHa7086fpY4eUPhJC+qxpkIKa8MxxG8WjpuspbbEKkW/8tJwEKN
FbHA4DiudK63rJUPMi2tjdoEE44LJ0yMNcmjR4jyVE0zBe3Pdrs=
=tGSp
-----END PGP SIGNATURE-----

--MxqMt97sE1YYoKnr--
