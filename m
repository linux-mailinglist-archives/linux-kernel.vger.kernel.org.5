Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2817C469A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjJKA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbjJKA1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:27:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691ED2709;
        Tue, 10 Oct 2023 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696983849;
        bh=Mablkf8EaNjLpPPBrAZCh/HqRyuNanseKoTJEbDjXQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RhQCuZmr5pTuVpU8K1hVbId6XyW0aU0y4VwQC8vALSwpHBaHoqkGaa1rFpXYEXcQO
         wYSvYRPKFtEGuvjNkvj1cUdIF4jWNIqOzLIbdBTOKvGDHcru3DwQRZZMZTfGzd43uV
         T9HPHrYHFywLPO+JQ8GKyt3BPwcvBTjN+jDiqSenikfLTDnxkXNf/rlRWWrz8j0Zi/
         CFtlyXgZm/RakleX8gl8cyqpcWSmVES8g3NXVVmxkYTdWaFCkB3PvbkutQ3bI9klBe
         bqbqHXLGi93o9W/Ah2cL+H2paylaQA3XVDYN6k/FfaqchW+TZHqFNRkMVFjdx+GGwi
         eGb0A23ETuy1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4tmn3VpNz4xYR;
        Wed, 11 Oct 2023 11:24:09 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 11:24:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231011112408.3198553d@canb.auug.org.au>
In-Reply-To: <20231011083754.45a9ed53@canb.auug.org.au>
References: <20231009104840.1bdadc80@canb.auug.org.au>
        <20231009-bauch-gedanken-e02e35804e03@brauner>
        <20231011083754.45a9ed53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ecmSwi50C5cpoi7gt+qpF6W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ecmSwi50C5cpoi7gt+qpF6W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 11 Oct 2023 08:37:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 9 Oct 2023 18:15:53 +0200 Christian Brauner <brauner@kernel.org> =
wrote:
> > =20
> > > I have dropped the vfs-brauner tree for today as there is no way I can
> > > sort them out in a reasonable time.  Please sort this out between
> > > yourselves.   =20
> >=20
> > I'll fix that up! =20
>=20
> The btrfs tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git#for-next)
> has moved again.  I don't know (yet) if this will cause conflicts
> again, but there is a good chance that it will.

Yeah, I got those conflicts again, so dropped your tree again.

--=20
Cheers,
Stephen Rothwell

--Sig_/ecmSwi50C5cpoi7gt+qpF6W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUl6ygACgkQAVBC80lX
0GxrxQf+JfApwoJ+ab81MazfZuL4WZXzL/MG+QYPjemdd8AfaqGTMzqPHdx5BIF7
H7zHkBPiKzUV3xCd4+/LUJ+qjWTSPNdnVFvBvVpw7fMhn4JFkDBHXkJ9kzQ7RVNJ
OMGA6wxW+LjR92lOO3SEGQeNfZAQ9XYgsOHoZCkckl3F5xX0QtAMdWMdN8AgDXDb
1wuS5R+zio8qw16tS4DC+1Kor49P8mHKqIr3wd6VYRxf5k+neGAAG1iBHMVBWEmE
T+M3tAR6PbNoX3XEJu7mhJhlXsT5RaD+ciEcedSuMWu6y3p2tv9MjoLQ/+Ff83Ku
MSqtmOvRGitxyel/w6n8ABNtbMlW6A==
=qTxv
-----END PGP SIGNATURE-----

--Sig_/ecmSwi50C5cpoi7gt+qpF6W--
