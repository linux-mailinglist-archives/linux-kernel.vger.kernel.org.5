Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F07ED27C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbjKOUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjKOUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:40:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903119AC;
        Wed, 15 Nov 2023 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700080792;
        bh=S1DRmiOFH4gdx6jD7U1d7I9+SbzQKbwT9ONQwhw7An0=;
        h=Date:From:To:Cc:Subject:From;
        b=JNRWg1S/N9vPo3dVXpr5w54RfxnTeDhwA1PwBMgL2bIXqTXmqPY1SbhASBohc0JLl
         6fzTuLWp/grLEH96hTP1jOn9ICvvpLpRDe8FEG43gFZDm5IxsGGu792oMvH8vJUHud
         YWBh0i5AMsvPMeeqWD9WfkZl6BJLu/9ajUtLHHX6dHwWKMmXQAiEW6JuliE5YvkhyY
         gR+X5Jgo/Njg3r2Y2R9HyATFVZjRopOyP8ZtoJquJv9q6i9ZH1XBmXJAZppa/tNmT9
         7yCBq1Z/2i9QDMW2Il7si0vv8bcznErrBmrgKjG4b4QpqEe23J37I0slk8xvXvBZZJ
         g/fdhcy2Uefag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVw5N0Q67z4wd0;
        Thu, 16 Nov 2023 07:39:52 +1100 (AEDT)
Date:   Thu, 16 Nov 2023 07:39:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: contacts for the gfs2 tree
Message-ID: <20231116073950.02c0610f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7Ota_2r3cnc_63MSW71WcWp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Ota_2r3cnc_63MSW71WcWp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed commit

  2e6ef8aaba6b ("Remove myself as maintainer of GFS2")

Currently I have

Steven Whitehouse <swhiteho@redhat.com>
Bob Peterson <rpeterso@redhat.com>

listed as the only contacts for the gfs2 tree.

Should I change that to

Andreas Gruenbacher <agruenba@redhat.com>

or keep Steven (even though he is not listed in MAINTAINERS)?  And should
I add the mailing list as well?

--=20
Cheers,
Stephen Rothwell

--Sig_/7Ota_2r3cnc_63MSW71WcWp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVVLJYACgkQAVBC80lX
0Gw4twf/bMgmWLCS5rUJj0ztqu+Km33BzhOGz1LrcjSHGORFZ70hT/+cVU4PKRVA
+6VvxLYK52Qp4sNK6Y8R6XYINdHTWfvEt53nmVj1513OjBqdURd3LSxGwsIBQ66s
PssNTNwJVptn3mf+wvrlxwGHRFMxPpSCLe7E4w/Gb8B5gtdv2c/UsS0H3YJ1zboA
cNxc6I/cV7E8byWQcBXMZzkydHnJftg1UVHEK+Xvz1iEz52vfTdjTY4ZDMFm1sdy
vS5wJWLgAQkg+EN5GGAE8xA8JUK6AZF338kWE/iomX8xdpzPi9PtyjbTHCwHW7Il
k7q7Yk6cJtO9fXbRj1Qpie/wi2SQuA==
=CRUS
-----END PGP SIGNATURE-----

--Sig_/7Ota_2r3cnc_63MSW71WcWp--
