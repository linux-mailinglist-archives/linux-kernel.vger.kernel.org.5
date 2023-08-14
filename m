Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC177C3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjHNXBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjHNXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:01:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E6E5F;
        Mon, 14 Aug 2023 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692054061;
        bh=D32KTbuuxpTgwqZGodKa+ZldmafF21L6DlezEmSQ8ac=;
        h=Date:From:To:Cc:Subject:From;
        b=nezdmNU5fBlTtHufK1aF6WhbhJ38u17herU3nbK0hZAR2YatU/FAGw7+qHHqD/tZ9
         vmTpm4Ej8RM2b1YrM/TUIjIxIBklyPm+f61jwEzNnQtwZ9PSIVR3KFny6Q7ZTgJa4T
         k94vdwt73Ro7ORLTWwfPJmEC2ZIY+JD9U/hWw94EQR5KeGPh4uMeWva3gwqUf7zT1A
         nSQArrbuHaJYA8j+QlflbQsl6Dk5tglfrmytokI/8DqVz7RIu9TTJ6t25Ursn7Kgef
         IaBwgPN1BFPcsfbA1E91le6ximlv9jxXhH5OyaEZJK1KzqPSHFCF/pKDwIQCddf5nc
         LNUFe8gKYq/+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqd82Z6jz4wZt;
        Tue, 15 Aug 2023 09:01:00 +1000 (AEST)
Date:   Tue, 15 Aug 2023 09:00:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20230815090059.4a82b7b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Be0Dl10bpq+2JaGTUlyQJE0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Be0Dl10bpq+2JaGTUlyQJE0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2545a2c02ba1 ("media: ipu3-cio2: allow ipu_bridge to be a module again")

is missing a Signed-off-by from its author.

The author email in the commit metadata is "stuttered".

--=20
Cheers,
Stephen Rothwell

--Sig_/Be0Dl10bpq+2JaGTUlyQJE0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTasisACgkQAVBC80lX
0GyrUQf+PJup2DsZ6GEDDHROzqtA/PeBR0s/w8Jngfib55GbFRll4nldE3XyYLgP
k8C18Zu9RqHJZHyA/i45AfnTwkEUOX0zNSo0CzE1DLkjf6APsyfdDKUcWb3F7AXA
Ayw21AEbLvAqeSfvG4QaBYMkfMiTebzRZ16P0ql7JSWIPUJcCbYwLUEsu7JMqiPL
A7bqJtHxCS5zU8MXIOa7QCL6GXRs19x172RUnKx832/zhC7xXjwPt2ziO+7eZSdr
PHrnCtYRoEUogFsAutkfP+g/vB4wpTlbGgU5PFxubFyg4XSHj69SV7I3jpS8uv4m
NzLnFvlRX/W6DQRAwelTuI8yanM+iQ==
=mzx1
-----END PGP SIGNATURE-----

--Sig_/Be0Dl10bpq+2JaGTUlyQJE0--
