Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA27B231A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjI1RBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1RBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:01:01 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F2B193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:00:57 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9DEDC1C002E; Thu, 28 Sep 2023 19:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1695920455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrW/r7rpi8+3aJKbme/FUpZFUo9L0b90LEPhZ+57dg8=;
        b=OzVsBKz8DJwFDidnWpWKBNrNgWOzPFRs18BhJAxj54TWraFMs3jhvs3utxcz1X5uBC4iYB
        Xz7FlCp5RIl6OYSBkHGDfX8qIlAqLiLMpaTRA4Q8CmD180cDoHuv6jv07JDsddzhRp4bDo
        cGo/xkICeksrLIeVp4+u6k1J7m7Voe8=
Date:   Thu, 28 Sep 2023 19:00:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Re: My brand new vivo V25 Pro 5G Android mobile phone is running on
 Linux kernel 4.19.191+
Message-ID: <ZRWxR+pWP3kKeRM4@duo.ucw.cz>
References: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cHQiMYPHBBi8nju5"
Content-Disposition: inline
In-Reply-To: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cHQiMYPHBBi8nju5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Subject: My brand new vivo V25 Pro 5G Android mobile phone is running on =
Linux kernel 4.19.191+
>=20
> Good day from Singapore,
>=20
> I have just bought vivo V25 Pro 5G (12 GB + 256 GB) Starlight Black Andro=
id Mobile Phone for SGD$600 on 15 Sep 2023 Friday.
>=20
> My brand new vivo V25 Pro 5G Android mobile phone is running on
> Linux kernel 4.19.191+.

And what do you expect?

If you want to run recent mainline kernel, best option is a
PinePhone. See

https://wiki.postmarketos.org/wiki/Devices

for other options.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--cHQiMYPHBBi8nju5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZRWxRwAKCRAw5/Bqldv6
8rJHAJ4leOwpMBd1cpEW5IN2pecFslpJOQCfRV6EYn2FLgU2kEGqBXrwGx9VeP8=
=v/6S
-----END PGP SIGNATURE-----

--cHQiMYPHBBi8nju5--
