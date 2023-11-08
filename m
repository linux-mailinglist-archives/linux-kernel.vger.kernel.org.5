Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918137E6032
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjKHVvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHVvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:51:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41212582;
        Wed,  8 Nov 2023 13:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699480256;
        bh=YZotS2RObRaQMg5BcxQg/GPTBx3Z2wkmAINfVY91OQE=;
        h=Date:From:To:Cc:Subject:From;
        b=C7PMTCIgmVE7dujvUZNRc1MklScW0nydkFG9tKPOHXlbM79DeIi28mEi6XphN43Rm
         6QgGOcDU9oosNbXGQ9N0eq/E69ew09rjes/mojNdHTBG+4Dc96zwUGga3gPu0IBDU8
         lXmiOLwoPy/agzKjq07wo6ZRPQC91315gCSDOkItImhXOGbF4mayfCbiAiAAErcq86
         POS5bgEEud3EuY0xPAJz2YMhztw5wOoIKbck0uQzMYj79RiR/Xc5mQ/oZdiaImtOf2
         cVG1cWxi75aKzSCPmFuEyH8IE5YKAQ+hJZLR1zfW2Nmfi1QwF/OR/ewrYEX2IDZyBY
         ru1saPJ1/ZJnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SQf0c3wGrz4xWX;
        Thu,  9 Nov 2023 08:50:56 +1100 (AEDT)
Date:   Thu, 9 Nov 2023 08:50:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the memblock tree
Message-ID: <20231109085024.3de5b700@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_AcH0U+uSPXJx/uHAYQyYnf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_AcH0U+uSPXJx/uHAYQyYnf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  0f5e4adb608c ("memblock: report failures when memblock_can_resize is not =
set")

This is commit

  e96c6b8f212a ("memblock: report failures when memblock_can_resize is not =
set")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_AcH0U+uSPXJx/uHAYQyYnf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVMAqAACgkQAVBC80lX
0Gwc+wf/VjhtPQ2v4DShLecWNckH6AAu5kghtuKzp2luOlVgULq+XML7W/4G9DQn
i2qTfCvLiHk60yON03tjCxBuohg6YS57YXNpFqToKetsw6s66T3nWPlrt5WwDq0I
J4jX4SKXSMJO7JAGBEu6cPTr8vR9Nw213LyWP09dsgjMQ0r9OI3KpNkEaSg37jtp
UsTogQ+fqwoMAYOA2nBFCMCbVgehV0XsH1o/wR17RXXyVLA0AQkQ/dw5fYaI3QfK
S6YHL2QK9dy3BOzT4kXlxgR1RAuy5NBAFXO0Foz9nqXqrxxiCL9okBY9wmYRMaH+
AC3St9RZLgZLAkE56uJ6fgQBPVompA==
=7k7r
-----END PGP SIGNATURE-----

--Sig_/_AcH0U+uSPXJx/uHAYQyYnf--
