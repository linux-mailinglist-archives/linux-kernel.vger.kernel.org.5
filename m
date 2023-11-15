Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA737ED741
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjKOWb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjKOWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:31:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7A1A1;
        Wed, 15 Nov 2023 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700087475;
        bh=1zXDjYGnN7LZWDoh5L3z7YvK5tDr4zX5nA46mugKako=;
        h=Date:From:To:Cc:Subject:From;
        b=j5xCb2XF7S32O1vvBdrwbhe6OwYTpZs5pHvV/xwgNbNN3My+J78rao2eMMAbDgwOk
         IyHSvXXdkOra0AqY+d7HBKF72wGEQM7TY6SpD7BkIeWdgtWJ6CO+viZJeog6x+opa6
         TlHPBAEnkuazBB5jAnuYPJV7u+1Wo6qbxgI2iyOLOK8kFUryDPSb12tcjmiYOhBIPa
         iSeCnrw87mID16D0XlDyTQkwyyksSpwA2WKgU3x1a9ygDFGJJmHO9VeLPv7GWtu1V0
         stIZoVx95rJVv6SYyM+SzlDQt7w53ADW2vGXC6VrgPRvIpvOKRDAOwT495xa4ljUrZ
         ALuYPdd86SbDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVyYv2R4Qz4wd0;
        Thu, 16 Nov 2023 09:31:15 +1100 (AEDT)
Date:   Thu, 16 Nov 2023 09:31:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20231116093113.3b643de3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ccW5VGvm4zWXZi_Ay5ZHTgl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ccW5VGvm4zWXZi_Ay5ZHTgl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  6bd83f99448a ("btrfs: do not abort transaction if there is already an exi=
sting qgroup")
  c229bca90cc2 ("btrfs: tree-checker: add type and sequence check for inlin=
e backrefs")

These are commits

  8049ba5d0a28 ("btrfs: do not abort transaction if there is already an exi=
sting qgroup")
  1645c283a87c ("btrfs: tree-checker: add type and sequence check for inlin=
e backrefs")

in the btrfs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ccW5VGvm4zWXZi_Ay5ZHTgl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVVRrEACgkQAVBC80lX
0GymHAf1FLpzdtMwGiDOSlZNVYwZZMUSqxda0Mkh/D8o5QH4zhVn5u96HDaIwUXS
qhUE9/x0VRtawBRpJ2zejCNjtW+dNrKVcISGouQ6g18CfvenCoKtA4kOFeolnF0A
3ikPNL6ZCDneHv4+sCVe9uIt0pxmW5Ren6PT2uKool+4x/PHHRjjWDcLNBSwpXZX
GuF/99ymh0EGReoilP3jIyclJuiro3nP9j38xyd9U+h+C+pUMFk7hIYRhOSk1Xbm
WJXizhCjcdToCbaUgG3EbTnxcqHrmHRB3hzD/XXQUO/DcFeRWK4YDJurQuD7+Ziw
zNhXHPwDy1nrbtnLSBqgHbjWsYFI
=hhMj
-----END PGP SIGNATURE-----

--Sig_/ccW5VGvm4zWXZi_Ay5ZHTgl--
