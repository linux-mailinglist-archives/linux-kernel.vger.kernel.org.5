Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0727DE952
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjKBAaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBAaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:30:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF89DB;
        Wed,  1 Nov 2023 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698884994;
        bh=P2Q8D09La9f7vsdPBAHh1puRIjrljwbw2c0LbxTp7jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LPQfn1RpRLe14/rTr0LbknH1uyV2oP3up/HScoRG1pTIhlA9u0yDJ4xUzm5wwf+mT
         RqfJokTLetH++LJPNx+zR1O2QLQHnTl82IwzniqZPoBc85SLyVcTg3hOuyEVzkYbl+
         8BxsXuJ4oLy0RjzlSQPf48tRg35u6iKe57rjFDlu7pNRkwqz5l4iUvbR0dJRSkiEgC
         /Z0R9Gcn91dgTQAGc6DRNbITIxBowwd7y2IerarO0y//ScDl9gCFHbbZoOrhq80Lhn
         18Msb3BwnLK12knP20tjDq/7DaWbVVdlcmFEPuY0yiLjpXNE7P5ddgVld1QcUe+bHf
         ERQGzbShrVdpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLPsD2XZDz4xVK;
        Thu,  2 Nov 2023 11:29:51 +1100 (AEDT)
Date:   Thu, 2 Nov 2023 11:29:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Greg KH <greg@kroah.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wentong Wu <wentong.wu@intel.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the usb
 tree
Message-ID: <20231102112950.4706f887@canb.auug.org.au>
In-Reply-To: <20231016134159.11d8f849@canb.auug.org.au>
References: <20231016134159.11d8f849@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JIf8eFlvsk4.2uZ7M9Njdu9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JIf8eFlvsk4.2uZ7M9Njdu9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 16 Oct 2023 13:41:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>=20
>   drivers/gpio/gpio-ljca.c
>=20
> between commit:
>=20
>   1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
>=20
> from the usb tree and commit:
>=20
>   da2ad5fe2292 ("gpio: ljca: Convert to platform remove callback returnin=
g void")
>=20
> from the gpio-brgl tree.

This is now a conflict between the usb tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/JIf8eFlvsk4.2uZ7M9Njdu9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVC7X4ACgkQAVBC80lX
0GwICgf/STdIjNFb9Z8WrRKSviBY3j3skfpl4swVJ1p8UY8g5QY2UHiyy+wPRl6Z
rFhjMTjPXvJg73Tgbz23OfUXk2sfeAgSv8fMGXP0gyoO+BlKYSyT/DILDfpcdc6C
2VX5DSxh2u6NXHtWPLhFHjPHqKEswM8CRId64CP/sX6bK/RRYP/6LoP3s5ZfHXCz
LuMpn/1iIakS+LSubjrraM42ClOiWDqMru5gp5s4TfDpJdXu6yYvqDKH6wTXcP72
LicrGLOBLdBwHWWJ9aot0xf23dKJiPyBgRMfdLnA0OIBJrJqhhW2TDT1hdxHXfd6
Mp3DKX11TJsRznZ1UJ3rhz3FS8pXJQ==
=he8V
-----END PGP SIGNATURE-----

--Sig_/JIf8eFlvsk4.2uZ7M9Njdu9--
