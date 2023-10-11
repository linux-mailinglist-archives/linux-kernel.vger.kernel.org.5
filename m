Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687D7C4927
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjJKFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:20:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B178E;
        Tue, 10 Oct 2023 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697001652;
        bh=7k18X6aVgS6bvOHWior48KEKOezPSnoJLZ4yDed1Oek=;
        h=Date:From:To:Cc:Subject:From;
        b=LwHQ6Z29q2+8pHOMqWbMIsI4vBFa6K6m0ck0rX+xBsYAStnXHRpaNrQqwf3nVdrtx
         +6wjoUrLddqy4TMKnZeL0F2D7rlnio6yyIBSVIkagpVcbEa2dDp27tVrSLgcpGOe+Z
         f9MFnEgkEn9Axnyqsf1c8aiIBJZsteQ2pZEA81kKJADoyKITYhvmYhafnrPPH694Dz
         8NN1kDfPhQvlh7t/EvWGGDuV5ds1CfYeB5BQoNii9esC3TB4Pm4SEOUJ/RZBgSRRY5
         pk5erQXvA2ixJKaoRrlLahfdSycsPtGSDZY8vo8QZs8gxQBgaiY8XLh0A0v0Y+u3aP
         LEvhVGt4iwVQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S51M65VHqz4xVy;
        Wed, 11 Oct 2023 16:20:50 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 16:20:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Joel Granados <j.granados@samsung.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sysctl tree
Message-ID: <20231011162050.773ebb15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Y6wLfPmPciujS_3=i/kFYD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Y6wLfPmPciujS_3=i/kFYD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the block tree as a different commit
(but the same patch):

  80f3c6cfab37 ("cdrom: Remove now superfluous sentinel element from ctl_ta=
ble array")

This is commit

  114b0ff62a65 ("cdrom: Remove now superfluous sentinel element from ctl_ta=
ble array")

in the block tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5Y6wLfPmPciujS_3=i/kFYD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUmMLIACgkQAVBC80lX
0GxkuAf9EJ0sAe37tWom/sDiuj294JvsaBWSZ/LSwW+AVuIfZ1nEYKtFUZNR/fyt
XuU3MYkrB+08hHfBZisGpbF/ZZEEBzdEFYgFyV+vQt9hFq/zbc5vTMbSLyuRjE6G
4gXve6S5dRzw7OVxavLC62SijgahbPmQ/dcB6cYSkrmzWRMV3yWDPqA030ionK9c
5FHdeRoLw2G2XPUgdSsqzcpI8722WxZj+nz4Yj6eWdCKFsZKz7M4/oGKc25AW0ZL
wwey59/X6iAIBeM2HqTuW1hOPqXEEu7h0BrTEWfRcEgvV/FgqZURkBgMnjmz7EVv
WK87B8AyS2fXLIUf4dVqid/wwQmDLw==
=46YV
-----END PGP SIGNATURE-----

--Sig_/5Y6wLfPmPciujS_3=i/kFYD--
