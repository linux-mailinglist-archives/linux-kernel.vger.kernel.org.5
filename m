Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC727A9D09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjIUT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIUT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24044A5D69;
        Thu, 21 Sep 2023 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695268569;
        bh=aSkp4Fw8HQ6q3NIZmUicIwuJ6VX+w+9CVVhVevKPHUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXq5ZvYKnxPEYcMGlyfZavaNlN03FlMGCf3AXU9KNcX8brB+mRrytbsDf2OBR2sY+
         RPDx7LiSlR2K8bvVuOFFzQdv/9YEJhyCZFmwTt3VZ0+bZwsieQuRyczMRiin+3ROb/
         5+DdMAbAnNVxjIdZFy925dvBc7ytu+OadGV2ZW3v9pxHZnhuPFiz87vZTiK2LEgp7j
         FAacWbMfZVDoVJMLzHk6XQAY3yQrEIzJuv64LvZ8ihaPKChKrs+oyzCWOUKsl4w3Og
         3Bj1X4+skedZ7kyFLl63nFOk3qhz1oBDQl3ekBu9lAi8Kq3wuQ58Gfa4+wNzukmJxo
         SZZmbUjxICASA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrhQc4DSkz4x3F;
        Thu, 21 Sep 2023 13:56:08 +1000 (AEST)
Date:   Thu, 21 Sep 2023 13:56:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with the
 asm-generic tree
Message-ID: <20230921135607.7c197457@canb.auug.org.au>
In-Reply-To: <ZQuyP8GsIP+gSB4U@bombadil.infradead.org>
References: <20230921115034.5461f62f@canb.auug.org.au>
        <ZQuyP8GsIP+gSB4U@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AdtZsNj2mUAVXM+g_MXFjNB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AdtZsNj2mUAVXM+g_MXFjNB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Wed, 20 Sep 2023 20:02:23 -0700 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Lol, good bye IA64! Glad I got merge conflict to say goodbye.

:-)

--=20
Cheers,
Stephen Rothwell

--Sig_/AdtZsNj2mUAVXM+g_MXFjNB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULvtcACgkQAVBC80lX
0GzacAgAir4iveyMm6dSbNiKqKcidjjBcN6ISSe2ITQ6h96Airfmn2NzrXiQdLOI
JiDUDauddvz4zO1A2bgDsg5h3KafvKKNS6mjYgH0zv2FnoMLO45RDwcxu/tyosI/
d/3qlx5LrZ4x4VIsTWcsYieVy6m4tztJWwgz899s12qgw7OAnVKos6rPNrYDq82j
W+Dt7vmDFWW/sgN/FUKsgemChXA4TG3YhMwP71RyZIa2oqWsyYoUZjgPylv89T4r
zuGsKr1pz6gO5bpgg8HWTL7LbK5bIBTCDnXZ4opX5J/jRxJ7AR5l0j4QDxhZjTwD
f6f3znGPds8FnPW1QKlLg56ItzVKQA==
=bgIU
-----END PGP SIGNATURE-----

--Sig_/AdtZsNj2mUAVXM+g_MXFjNB--
