Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12E7BD168
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbjJIAQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJIAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:16:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C96C5;
        Sun,  8 Oct 2023 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696810570;
        bh=LVPV392yZ1mS2pMrewV+VdD2NyrtDs2/D3tqWfPkcyw=;
        h=Date:From:To:Cc:Subject:From;
        b=iT4mPA2LYCgfOpIJLW0rN8HrCINE8ICTp7OUHcpsMIP4i5mbz9vhTdc/NvFPiqYNq
         EXNgafCFS67MAx5sahxIJ5pxoi4hzBH8ppNOtfcTOWkVQchbl99i6fdii0LeGOx9HP
         W6urYv24QORvcQdMVamgajr3XQbh0jVb8FJ39OiVLep1O3NMfWmj3wPE31uSeEeuXx
         YM7FrUkDJqixxsKKQvN8dOprKFkIqSBcpDQ+/T5SXf5hI+/nWSxjsTfiKgK+P6SFtO
         E2Lo3ZdjXNWaUEztQDvSrbDxqzy7DDvT4m1DJ8tZ7e3cV81KtBYrW4SFDt1vM8OOr7
         LOboXMiDwITpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3fhV5qn8z4xVR;
        Mon,  9 Oct 2023 11:16:10 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 11:16:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the m68knommu tree
Message-ID: <20231009111609.13ac1edb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mQmxQ+61tjGzT6VBVfINEGk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mQmxQ+61tjGzT6VBVfINEGk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the m68k tree as a different commit
(but the same patch):

  af580d01acc3 ("m68k: use kernel's generic libgcc functions")

The is commit

  a0938a8e2fb3 ("m68k: Use kernel's generic libgcc functions")

in the m68k tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/mQmxQ+61tjGzT6VBVfINEGk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjRkkACgkQAVBC80lX
0Gx75Qf+Ihxmjf1PTuJBzqhFjC17Z+xJF4ugs4fjO1bi7OaKdBZzuAZex4Ahe37d
uOJ4ryDN5u0RrEGRjsOPOX8c/McQ35chtZd0BWnYxNZLSoc6CqU8bkZ4bhqLszXD
9HUYZCPzBD9UkZ3JtAZLZKgH7elyIodjXDsZPc/G0zuidUydM4fjlDECuk0o7NXw
ENRBkx7uNBFB/jLsxeWxXqIDXU602dEi7kUeavI5RJ1M248yXgN+WPyLhqYzfwi3
P2WBY/N5pIJUSuDj+vY8L6sJHrQBvjbij17deIirtvfCMwhtkpSQ710qh6VmQ4Kr
WAAa4RsvgJHIeA9OsiR5JxbuinBLQw==
=1uOb
-----END PGP SIGNATURE-----

--Sig_/mQmxQ+61tjGzT6VBVfINEGk--
