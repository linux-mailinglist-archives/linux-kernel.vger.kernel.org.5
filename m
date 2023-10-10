Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E617C42B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjJJViD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjJJViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:38:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C1B9;
        Tue, 10 Oct 2023 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696973875;
        bh=/CBepwp4t81AuUT2xgJn+DMM7RYvmtf3m+pCUeUgpMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Flmk1m3rokSqAh5C73jZgeJyK3K3NoVJzbnflquV+EHa0YPh6fuCXN0RQUwrMzfNL
         Tdp8yYuKYqqP9BggN1fswtk8xeDz/J9wKnmx56webqwBdDxYsveCD3OFFl5SZpCEwE
         WCaH3S4GGhsu2QhD2GD3RUd5m1XU5fx4SLNqm1DMKKigUujKFpQzkfngqJjmE77maf
         3ICNF9/Cbi+28eagBtiCLQ+sc+0tm5668FtRgv5po5BqRylTHhMG8db4RdAZtrsXqz
         wrpjrx/tdHnGDTGYtlc8S6gExx1z4xWBcLIuqQdACABKRo5x46VqRwhwU4zQBkoDrS
         LOaZihPHatokw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4q4z04LCz4xRj;
        Wed, 11 Oct 2023 08:37:54 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 08:37:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231011083754.45a9ed53@canb.auug.org.au>
In-Reply-To: <20231009-bauch-gedanken-e02e35804e03@brauner>
References: <20231009104840.1bdadc80@canb.auug.org.au>
        <20231009-bauch-gedanken-e02e35804e03@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Yc6w3gTZ88fQAT6iwutLYj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Yc6w3gTZ88fQAT6iwutLYj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 9 Oct 2023 18:15:53 +0200 Christian Brauner <brauner@kernel.org> wr=
ote:
>
> > I have dropped the vfs-brauner tree for today as there is no way I can
> > sort them out in a reasonable time.  Please sort this out between
> > yourselves. =20
>=20
> I'll fix that up!

The btrfs tree
(git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#for-next)
has moved again.  I don't know (yet) if this will cause conflicts
again, but there is a good chance that it will.

--=20
Cheers,
Stephen Rothwell

--Sig_/5Yc6w3gTZ88fQAT6iwutLYj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUlxDIACgkQAVBC80lX
0Gwa7Qf/T2JoRWEiSI1qXgUAK00erCGIRTxta2N3UtCM4ZrgoPk9SkE0uV7zXy8L
GMjxSDXH/P0D3oV9TaXiNUyKSeWIipcAdubuNJpzth4iVJ16HKi6M+XPg2CJmpZI
Nparc/VmvOKARcnSajeMFKbpjrj7lpjE6d7wemQfEorDZTCUcCSQ9Yv3F9OMbrKc
qDgtrHJFZiWCvR8crQqyEPWJ5T4j4lf1k2NQdhvhQrZ8Nh/EvZ8lryMMXMZ2e33r
vHobOdNjm+t06RJQSijplffe7FEUbe2CLcZsWMDnGc37VfmHh4gL0h21hA1m76Jc
nhD4zQHfdPW0IZO3A/0FdGFl7IL4lA==
=rsA6
-----END PGP SIGNATURE-----

--Sig_/5Yc6w3gTZ88fQAT6iwutLYj--
