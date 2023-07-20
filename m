Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4FB75A436
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGTCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTCAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:00:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1382123;
        Wed, 19 Jul 2023 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689818428;
        bh=f0tiyHG5LkPEEi4G2iZHxPMbGPIeVi4G8CsSBrw9ILE=;
        h=Date:From:To:Cc:Subject:From;
        b=nwmgCoeIiW4YASgXzb/NOeHKJ8tCdjLjVVyetB7v916+FYmIPoAhTNbFvyHrtFGzW
         ti+MTqD4EAJnt7lW1swQp6vSe4qW+/Ngb9JqqyQHlJ/ceyDvtqxmp+7ZIpUkNb0qqk
         TjcDx+I1uBaSegVh6jrt58LQ6W0I4b6RDp9jgnLfb3J/LlBlXs+JFre9VQ1uaaf+xu
         EuyWCPgSEfdDHJy+7s5kUHB8ly1ciO06CKEtVo/xerTaCNFyhTrMkkNdGTlKjKhvsR
         JJANvgDAqsCX+87rojywpPu/mzCAEb1nwm0bB8gFp0FhXfqX2Br443srfsRCZnr2MQ
         Ga2wkFLRTPxxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5wrD4f5Tz4wZt;
        Thu, 20 Jul 2023 12:00:28 +1000 (AEST)
Date:   Thu, 20 Jul 2023 12:00:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the clk tree
Message-ID: <20230720120026.544ab3f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z2BCFkOxO=T5DXWLZaoT0AB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z2BCFkOxO=T5DXWLZaoT0AB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree tree as a different commit
(but the same patch):

  e7dd44f4f316 ("clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_=
IOMEM")

This is commit

  a53259d47b6f ("clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_=
IOMEM")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z2BCFkOxO=T5DXWLZaoT0AB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4lToACgkQAVBC80lX
0GxqdQf4ifvyyLtyJtAo+Nl1t8hiyfK68Wmus9xnqs6Tb7MNniowzSO/K/lEuSI8
q+jUISJqAEX1RjJWo3IYaldAWn/6OlQ9Ty1QrBjACrDcyDGTS00jjfHQeEwLV8hh
hcI8/yWEFf38smrD3NeZNyRpVoy/MIO6SBPJJag0dGCbi1/20CmYu9N51fI3xDSN
N1T8WSYK83JzvWSFuvaaZJR6uo34yUBqw6l1+fOTU/Tawif54+CQa8x05L6wipX0
YkNJmfaLugkuLmgIBPbXiGOTY/53+UqyWjdrw+Za1X/JzgHkDfn/AD7Mjslv37+H
mXagYq2JV20Omg0KtkKgOgWtnJgW
=w0M+
-----END PGP SIGNATURE-----

--Sig_/Z2BCFkOxO=T5DXWLZaoT0AB--
