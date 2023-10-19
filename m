Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED247D03E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbjJSVYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjJSVX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:23:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E8D4B;
        Thu, 19 Oct 2023 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697750603;
        bh=ThHMQ0rpFFKR7xRxucPenUiupvOFrWJ6GPDHDX8IC38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ht0QGRGXaKoGfbDrXXWoHVbBqxkDRDCNUIDQeZhQlBbvQ+2pHzIKcFuTZZIiSXQzR
         cPTgZLnpABjmj27UHVo4QqRpGy+Bt8H7ZCkGkUb8NwagTWsocAuQt3DAGbNp+imJ52
         NUmBnk5IOKlOfkuaSNIaw2ZUjoui4rmsItp9azXsDXSuqMp0E9WgLd5Jxtm499Ox2u
         OdI8Ed+H0S+eSNqOanlg6R7oxGGz6MisSHmwo1iQL46ikSeUKPjqcX3RQUl87py4Ic
         2KJ1+zkIX+3ixTlJMp0c4eXPjw5Ib3na8paPFVF4Eiobvr25246HO9W1k7ZSOj2Tk8
         D/PyHsHGFiyxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBLL33hRSz4xf2;
        Fri, 20 Oct 2023 08:23:23 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 08:23:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231020082321.46af78d6@canb.auug.org.au>
In-Reply-To: <20231018141446.19fa9b25@canb.auug.org.au>
References: <20231018141446.19fa9b25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SexF1HL7vrnBD05oWP4r42Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SexF1HL7vrnBD05oWP4r42Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 18 Oct 2023 14:14:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The following commits are also in the net tree as different
> commits (but the same patches):
>=20
>   0ebb3699b15d ("Bluetooth: vhci: Fix race when opening vhci device")
>   19cb846d0b71 ("Bluetooth: hci_event: Fix using memcmp when comparing ke=
ys")
>   27eb5c50277f ("Bluetooth: hci_event: Ignore NULL link key")
>   354eeee644a0 ("Bluetooth: Fix a refcnt underflow problem for hci_conn")
>   4025ddca4aa6 ("Bluetooth: ISO: Fix invalid context error")
>   47d973dff74e ("Bluetooth: hci_sock: fix slab oob read in create_monitor=
_event")
>   505fc3b0f198 ("Bluetooth: btrtl: Ignore error return for hci_devcd_regi=
ster()")
>   58250a6dc86d ("Bluetooth: Reject connection with the device which has s=
ame BD_ADDR")
>   81a220a6c891 ("Bluetooth: hci_event: Fix coding style")
>   a86e2622de15 ("Bluetooth: avoid memcmp() out of bounds warning")
>   bbb24b6a681b ("Bluetooth: hci_sock: Correctly bounds check and pad HCI_=
MON_NEW_INDEX name")

These patches are now in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/SexF1HL7vrnBD05oWP4r42Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUxnkkACgkQAVBC80lX
0GzfjAgAigBlbI6QrnF41Pxf6hsCk4uBgHMo09lBRi/8dUVSaQflapgk/zdtIlg9
VOnHCUE60ZSa4g/yP1rrM0z3jwiN1SFqgGL66SUbSUdCtR1Q0zbhduXc/MVclpI7
5ZA+/2lNQ7br/0y837ZOENvJCWlxd9NlLfXwIkukBnfjumVBFPX/9NpzOS3ENlsT
1nKrsZgB+tBVw+dGUFhY/iVK/zkJdI1CL5bzYLKBSFuzwXRh4hEY+m00oovvSaqP
d40B24hTkuLlKHpFZcCtwJLxp55TewZa5iknZ8jUv++LCKDTTHlTwuLSShQdLVnL
ZQ9e7mwEL6/GAyKvTPtAnJ7Sm9SymQ==
=cFeY
-----END PGP SIGNATURE-----

--Sig_/SexF1HL7vrnBD05oWP4r42Y--
