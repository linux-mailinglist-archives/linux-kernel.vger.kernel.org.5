Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26F78A551
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjH1Flb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjH1Fk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:40:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4F115;
        Sun, 27 Aug 2023 22:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693201254;
        bh=G9UV5wckH8VHKU7MNBAoL9GfMYZgLKj+fBgSXynMfzA=;
        h=Date:From:To:Cc:Subject:From;
        b=BqwthwOGOowh0PgeHpsT+0NjRAP4+v4Ks891U3OIo9bZbxPkot+xXTFZM4YdpbzWH
         vlme3aAYIBF2hXxo8IIDmf7PubCYG0NxsczoUOgRvw5cUjlBZK+xhCJRVAuHAydIH0
         SGG6cYo0BfBScpV9imjEUkdz17JpF5i1RTeyv9yi03Wj63IdcaubjVqkonkWW6JEQ7
         WLrwt6eHAiJwsliyth9g5D/7iDnFzy6OhLp1iOi/GRSwPgcppoJv2H3dpzm7xv7qLh
         eCO5QujkyNxH5R3bKodTpHwSwXt1z6OLD4mHBXNohIhpJLl/+kl4DZTLFvkpGf7t6n
         yC7y+JoStcMRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYztZ1tmCz4wbP;
        Mon, 28 Aug 2023 15:40:54 +1000 (AEST)
Date:   Mon, 28 Aug 2023 15:40:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20230828154052.661f17e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bhWkHvFtJL5dloTfizHUefo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bhWkHvFtJL5dloTfizHUefo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  74de20d838d7 ("virtio_ring: fix avail_wrap_counter in virtqueue_add_packe=
d")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/bhWkHvFtJL5dloTfizHUefo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTsM2QACgkQAVBC80lX
0GxD4wf9ExY9NPYb1CxUIUOJhBbcNIRsEyYCMg65tvYlz8yANSR8xVgtq3lLAjaX
rzc4AZpSIRuOSMgkBjnQwsGd4c4LYFo/KfvQbYt02X6ypASPz6RfKTmQh153zzL9
VGig7UCj0Hq9d6L/28WmswqHHVfT/5nJoED5j1me+Hyj9jfXwNGVVfdcnmRsBD1K
0HIlo8nrXkYdipiQxNSD2h3xZJ+tevVdy6LOkkjltVQ+qeNqCRdUnrnBbi5U131d
74MD31Yk2fqbLuT5f+ibDwNu8CGRUuNNayXjpTeW1jTy/M0WROUBWME6XL6yoP/X
G72WJrpyTlsbdQI4SMGAaDQj0UZ5cQ==
=cHvN
-----END PGP SIGNATURE-----

--Sig_/bhWkHvFtJL5dloTfizHUefo--
