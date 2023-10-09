Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB17BD475
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjJIHhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjJIHha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:37:30 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9394;
        Mon,  9 Oct 2023 00:37:28 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AEADC1C006C; Mon,  9 Oct 2023 09:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1696837046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VROa/yOdjUP7j141oZYlPLZTrHtS+uByc1BoliKMXok=;
        b=CWwL/DhF3ni/dRFy6yM4Y7s/7ymLPl7f8uYhDFxojWGrLzDc2eoDC6k52HlcKgOF0F/LEw
        vcj/R4GzCJ3Ztfkl8+FNkAKvlAm3MT4rWK9uU5ogJQP/agcxYxa5CPp7GIkSUuhv8I4hyj
        8accRU4q3E4tzuWZY/imFW1s0Kz96BE=
Date:   Mon, 9 Oct 2023 09:37:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        sre@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 01/12] pwr-mlxbf: extend Kconfig to include
 gpio-mlxbf3 dependency
Message-ID: <ZSOttlayEEJL+my1@duo.ucw.cz>
References: <20231008004929.3767992-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sR/u3r9Tclf6Wud4"
Content-Disposition: inline
In-Reply-To: <20231008004929.3767992-1-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sR/u3r9Tclf6Wud4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> From: David Thompson <davthompson@nvidia.com>
>=20
> [ Upstream commit 82f07f1acf417b81e793145c167dd5e156024de4 ]
>=20
> The BlueField power handling driver (pwr-mlxbf.c) provides
> functionality for both BlueField-2 and BlueField-3 based
> platforms.  This driver also depends on the SoC-specific
> BlueField GPIO driver, whether gpio-mlxbf2 or gpio-mlxbf3.
> This patch extends the Kconfig definition to include the
> dependency on the gpio-mlxbf3 driver, if applicable.

There's no GPIO_MLXBF3 in 6.1, please drop.

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--sR/u3r9Tclf6Wud4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSOttgAKCRAw5/Bqldv6
8q/GAJ9t3+xf3Momf4efdOWblR5rGzmbqgCeLtszZMdQCGfWFkOdqZQJ167aLWA=
=YIfg
-----END PGP SIGNATURE-----

--sR/u3r9Tclf6Wud4--
