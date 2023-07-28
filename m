Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E50766DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjG1NAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjG1NAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:00:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE130FB;
        Fri, 28 Jul 2023 06:00:03 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A36ED1C0A94; Fri, 28 Jul 2023 15:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1690549201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKS/b2M/HWHjyDnw5rB47P97LOiieqrljDHQRQUo3Vc=;
        b=kThL5cu+yg9D/jJWcF1BqCTJGP+BfiLz2GGX2S2gcOX115M2aPkEFwAfQspeFVZvdV5baj
        WJrP9JJC8wlL6Dtacy6LkUjON1IV/DMLvDwGYBvXJfn9RjnXG4xptzFfpDjAEewU4SVfGZ
        Z/p/vEISZrwIP3qN+NdWyeDQHUeWXIo=
Date:   Fri, 28 Jul 2023 15:00:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Lee Jones <lee@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Purdie <rpurdie@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] led: trig: timer: stop offloading on deactivation
Message-ID: <ZMO70XCBY3dqpdAY@duo.ucw.cz>
References: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w6eIOp2g1QdzPVPd"
Content-Disposition: inline
In-Reply-To: <728da6e11d34a39f717be07e246dcc4964b0fd51.1690542871.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6eIOp2g1QdzPVPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2023-07-28 13:30:58, Daniel Golle wrote:
> Stop hardware blinking when switching from 'timer' to another trigger.
>=20
> Fixes: 5ada28bf7675 ("led-class: always implement blinking")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

ACK.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--w6eIOp2g1QdzPVPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMO70QAKCRAw5/Bqldv6
8p5sAKCYGF57bp7vqaoc2ZKj4bEe+eClVwCcCKy6SM0lnrWHHWzdxlU9f1z1L1Q=
=r1Gt
-----END PGP SIGNATURE-----

--w6eIOp2g1QdzPVPd--
