Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359737BAE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJEWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:03:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E1695;
        Thu,  5 Oct 2023 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696543373;
        bh=9gVRYt6M+0BDHf+TyxYGa3vfMLe3BEc9+4rK8pNQ6PU=;
        h=Date:From:To:Cc:Subject:From;
        b=d2M+mCgYrHK6j/stgHwOLWvKtC/SPcizlh8eEcjdWug2V2PCmM3hq+HsMaPcYOGRs
         saaPkhHS9qJYElzvYQ9gmwerT3yzV2ueJDZnXQid/vRvNYdG0Gh1AUHkfL8B5xPBX4
         jBneEpwd6e5McOvhD50NWZwbyO3e3r0VR6jKwR5X4NR9oFAdlH8yfCR8YH4fuBpuEh
         ZyeJxVCc169qk9cLNDhsPLwnswYrh8pmg1pdZgWzC3BWcqWDPAj1snBhgIHJIZh4DS
         xq/zKQBb/6BoecZlt0AjRIIVoKmsiAD2CacJvYfx9wllVeE4I8rMR+IMr55c+MVZyS
         0I8a4oc8nfj/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1lt52n0jz4xF5;
        Fri,  6 Oct 2023 09:02:53 +1100 (AEDT)
Date:   Fri, 6 Oct 2023 09:02:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231006090116.03e9e6e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m.h3XXB8uLr50WxlIvUZ1Xy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m.h3XXB8uLr50WxlIvUZ1Xy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0ef9e5c1af4c ("Bluetooth: ISO: Fix handling of listen for unicast")
  190b32220f99 ("Bluetooth: btusb: add shutdown function for QCA6174")
  2eb5e4369bc4 ("Bluetooth: Avoid redundant authentication")
  8ee19a4f17bc ("Bluetooth: hci_core: Fix build warnings")
  9f0fcb5aa550 ("Bluetooth: Fix hci_link_tx_to RCU lock usage")
  b78e04e5f353 ("Bluetooth: Delete unused hci_req_prepare_suspend() declara=
tion")
  c0c64dc267e4 ("Bluetooth: hci_codec: Fix leaking content of local_codecs")
  da10fc7a9dc3 ("Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPL=
ICATE_FILTER")

--=20
Cheers,
Stephen Rothwell

--Sig_/m.h3XXB8uLr50WxlIvUZ1Xy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUfMnsACgkQAVBC80lX
0GztpQf/YVIhjAQePWXZp6SYkgoQ1zeZ8oKyYvV4oZTtgOvzBKco0qeLoSZ6fO0q
o+ToOIjah9wb/buhGnMoWNxgVIiNKS58dvMrMnd+YKngQH5xmH4eHJkpksddMk8b
nF4iOqcUgko2Ymc4Wm0eaqDEzPc+W4p+zWiWDgcyor0PoVZH8jh5JOUozIAlIqTx
g/hUWTT6O9DfG87mp46RBcvdpbBGrEWe2NLCWttH8KTwpvEjSw7oynq+pBLBdD+c
Q7Mdq2RN/Y7b75jpLnmxv6naDLOXaqdTgHsjvsyzgI4OMYs/FOH2pSndUTKG4bFY
zpFIelgRR7fino8/hTfRSQFzcLJ8DA==
=cEsB
-----END PGP SIGNATURE-----

--Sig_/m.h3XXB8uLr50WxlIvUZ1Xy--
