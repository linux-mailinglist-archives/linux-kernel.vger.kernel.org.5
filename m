Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769979BA70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbjIKVIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjIKJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:38:36 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8BDEE;
        Mon, 11 Sep 2023 02:38:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B75581C0006; Mon, 11 Sep 2023 11:38:30 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:38:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 7/8] wifi: cfg80211: ocb: don't leave if not
 joined
Message-ID: <ZP7gFtW+U07CpC/K@duo.ucw.cz>
References: <20230908182127.3461199-1-sashal@kernel.org>
 <20230908182127.3461199-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4zZsMGIhynDkbXF0"
Content-Disposition: inline
In-Reply-To: <20230908182127.3461199-7-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zZsMGIhynDkbXF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> If there's no OCB state, don't ask the driver/mac80211 to
> leave, since that's just confusing. Since set/clear the
> chandef state, that's a simple check.

This is not queued for 5.10. Mistake?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4zZsMGIhynDkbXF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7gFgAKCRAw5/Bqldv6
8tPKAJ0ZLwIUgSYRZlbf8Uohwr5HVJ6hQACgwgVm1eyNnOoNGQRa72F8vHVKJWc=
=p2UP
-----END PGP SIGNATURE-----

--4zZsMGIhynDkbXF0--
