Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4D7DAB55
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjJ2HPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJ2HPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:15:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903C103
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:15:44 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C459A1C0070; Sun, 29 Oct 2023 08:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1698563742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHNsN7kdXf3he6aH97H69VuD01SSwZUqepp/AZtvVu0=;
        b=k2WKPssDcxGwf2Xui+voNyeWMFK9f2fo6XWiKzEVFTMjKrU9WghKR03GWpC9oH9pVAFJ5T
        4Xoiz9cSFOtXH7JS2P8TWyTCdQI1R6JyiLd+Cu/6H+Scgs7ZW3k+qmPoyZhghn5QxQd25h
        U24LZfwfaU772OxzjTwj99dm3BROkYI=
Date:   Sun, 29 Oct 2023 08:15:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gnss: tell what GNSS means
Message-ID: <ZT4GnZUUVy0Ri5rS@duo.ucw.cz>
References: <20230925054346.18065-1-rdunlap@infradead.org>
 <ZS1K5AoZnS-3H-c3@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V01C0rPXzEZtMUI/"
Content-Disposition: inline
In-Reply-To: <ZS1K5AoZnS-3H-c3@hovoldconsulting.com>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V01C0rPXzEZtMUI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2023-10-16 16:38:28, Johan Hovold wrote:
> On Sun, Sep 24, 2023 at 10:43:46PM -0700, Randy Dunlap wrote:
> > Tell users what GNSS means in the Kconfig prompt.
> =20
> >  menuconfig GNSS
> > -	tristate "GNSS receiver support"
> > +	tristate "GNSS (Global Navigation Satellite System) receiver support"
>=20
> No, I don't like the way this clutters menuconfig. The above would make
> this one of the longest entries and for very little gain.

Yeah, because everyone knows what GNSS means.

Except that most people know GNSS as GPS. You misnamed the subsystem,
so it now needs explanation :-(.
								Pavel


--V01C0rPXzEZtMUI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZT4GnQAKCRAw5/Bqldv6
8vs6AJ94Iz6zUQbGOTHPj8X8wHmAysCXfwCeJuLZTpDtvWrcpa7k7Z5+djM+q0Q=
=asuu
-----END PGP SIGNATURE-----

--V01C0rPXzEZtMUI/--
