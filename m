Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA38A79B0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349588AbjIKVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjIKJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:34:36 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9F102;
        Mon, 11 Sep 2023 02:34:31 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8E7011C0004; Mon, 11 Sep 2023 11:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1694424869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2CmE2JFSM8pAEVIOYEIsnqeIcBwCEYRUHv7PaOGlB4=;
        b=edJ1zp76U5wD6Q4OyM/G9pSdkKyfTo2iXuI0x6Uq3iU0mKY8o7jiHUY4LoJpMIfw0ydTIY
        RkrTrHA4MLe16oiFyzcUohGn/K7zhlY7h/xI3bgu0y/wHpKr3yuS8nrP5adzHwrGLU78g2
        X4BtTRciLKaK4j2WIxE9NfBuHIJhxJg=
Date:   Mon, 11 Sep 2023 11:34:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 7/8] ACPI: video: Add backlight=native DMI
 quirk for Apple iMac12,1 and iMac12,2
Message-ID: <ZP7fJSHUNzyIg9e1@duo.ucw.cz>
References: <20230908180320.3458596-1-sashal@kernel.org>
 <20230908180320.3458596-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oq9hWx+adZyAT5mA"
Content-Disposition: inline
In-Reply-To: <20230908180320.3458596-7-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oq9hWx+adZyAT5mA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Hans de Goede <hdegoede@redhat.com>
>=20
> [ Upstream commit 8cf04bb321f036dd2e523e993897e0789bd5265c ]
>=20
> Linux defaults to picking the non-working ACPI video backlight interface
> on the Apple iMac12,1 and iMac12,2.
>=20
> Add a DMI quirk to pick the working native radeon_bl0 interface instead.

This is queued for 5.10 and 6.4, but not 6.1. Mistake?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--oq9hWx+adZyAT5mA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7fJQAKCRAw5/Bqldv6
8hiHAJ4gwyyP6F8iIJbrMxsv5MbR89B5QgCeOyUen33R1CoLCbgzrb42fJyaaWQ=
=B/vn
-----END PGP SIGNATURE-----

--oq9hWx+adZyAT5mA--
