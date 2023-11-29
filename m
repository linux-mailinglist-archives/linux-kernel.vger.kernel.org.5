Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F207FE12A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjK2UgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjK2UgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:36:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E991;
        Wed, 29 Nov 2023 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701290187;
        bh=NhZyqBfGDl+4nlBdapDkZwm/1AcFv7QX5+SPyMHd8yA=;
        h=Date:From:To:Cc:Subject:From;
        b=oaA1Ycs7vIWI7SfPVf4r73Xd0Y8bD+TDEOeL3sVy/ZyELkOKtiaZlhZdrdk5WaNf/
         HzgtVuY/zdgbbX7fyYRgEGLVFfJznfcgcffoDIl4pIN5bpyx7aZ9RxjLZx6S2/bPTO
         odLIW2kxg/gmrWRI2dOVSJkSXbYabA+5bz/hNOZlyz2k/CF7fDwhHDitX3lIZRxupm
         Jerske8t1balnouuK0TGSkAefMbpOKw6CW1lKcd8YxQgU3NHZ+vRFkq6XDTGTXIKxK
         0vIpGSo0WZrz8Xt6X1XiLxhgHbmTPll2xvIKrI6lUeKplYFGB5hglpzxBI15qulpuF
         YE8hPr9IMWcFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SgWLz4NXzz4xVy;
        Thu, 30 Nov 2023 07:36:25 +1100 (AEDT)
Date:   Thu, 30 Nov 2023 07:36:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the device-mapper
 tree
Message-ID: <20231130073621.618993bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/388/19bedhyw5RMCTLURHPB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/388/19bedhyw5RMCTLURHPB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d354a93645f0 ("dm-flakey: start allocating with MAX_ORDER")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/388/19bedhyw5RMCTLURHPB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVnoMUACgkQAVBC80lX
0Gz6Cwf/X6/x6Zi4gTnQ2w9q13O8b+0IOdjX95IePdX/F8MJ9uHF234vLNTcgFnd
Vo0RMrx1W7PEW63f05wSdhckrCuVCCdwqq3RD7OsqLkyk5y2YFiddWqjubOju13b
B3pzuu4WZteDbJb7nORMiTkxTpSe7L695rUx6Ibk4KHqWv0C0Cw62VLcBed3UDJM
I4x3OkMG3XYKtXa0kwTX9Qx/nEGcmRSaR7e331AWzAUG/NEUSkr9hGEomrIY3R9W
WBes8k7bb81IzPXbB0nr5GUKLkULEU4JnBzSWJFDjlmqEK6znrLEMJ/h15uYWtwM
bEBnH1befD61aRnwZi8Y8Jh5DdQPIQ==
=nEE6
-----END PGP SIGNATURE-----

--Sig_/388/19bedhyw5RMCTLURHPB--
