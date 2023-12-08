Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6124780A28B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjLHLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjLHLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:48:14 -0500
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A7171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:48:18 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri,  8 Dec 2023 12:48:14 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id E5B0A806A5;
        Fri,  8 Dec 2023 12:48:13 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id D707A180C63; Fri,  8 Dec 2023 12:48:13 +0100 (CET)
Date:   Fri, 8 Dec 2023 12:48:11 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable
Message-ID: <ZXMCfVw7kwvfGn/i@buildd.core.avm.de>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BSFSRSoXpjCiBLZV"
Content-Disposition: inline
In-Reply-To: <20231202035511.487946-2-sjg@chromium.org>
X-purgate-ID: 149429::1702036094-2FFDDD82-4CAFAB7C/0/0
X-purgate-type: clean
X-purgate-size: 1914
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BSFSRSoXpjCiBLZV
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 8 Dec 2023 12:48:11 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Tom Rini <trini@konsulko.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable

On Fri, Dec 01, 2023 at 08:54:41PM -0700, Simon Glass wrote:
> Add a new variable containing a list of possible targets. Mark them as
> phony. This matches the approach taken for arch/arm
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--BSFSRSoXpjCiBLZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmVzAnsACgkQiMa8nIia
bbjzLhAAnGc5zZlSZDcS57dXbgC5jj4DDIk3UsSib8BJO/mrvy5NV1kot35nOlCv
ITg7qaxJZGZhBIP730+qieDixLLAWCB9ybHnjmqMkmm9GYsPHSpAjTpuWzeyNBxu
Fu7k3nHjFMOlYM8isC51bifmy3M0+7oogWGYj/JtmKnQDAHnOzGwQxeJJvgAHkUw
RP8RGHngI/BGjMuyuofQ8zNba3k3RSJQREBwZ/Onu8FaYof77PJ4/0YF+hPaGHQS
gJpJ7QdhKu24JAkBbhIBSrIWULOvyQUfWhUdjC3HuidoMxfbDEYoG3SICcRaKo9e
wFbTUk+y5WUXCloKR4whRnsnqNeFxbPUwi4z+lgxLRfHc5QAEDD+KsBJdEV2Q/Rz
aFN+ASSGU5JIKJJXe58kk3neOG0EOk5z39Xw+6AJudjCgDnRa7cCTbtRwNVwgb+w
3T+xxMari2SfksRCJ1eSDw/VziqRSvKBw3Sbltfq6wdGMdZnnPZFafu7TQZmPH23
Q6eowZ2qNTZpL7Dd9cHiWMQribKTTynpaB1k5gE5iV6cN9oMMAEktvxJC+MzPMU5
1aKJWtlGc7mMPnvRCvVrHraeRWv18P2IT4Y23IGkTkIDUWKpgdTO8blwygmj+SU9
plEST8o2VyQWcjfok8MCEdFGNDEA1Q8rsmImUImYHIR25cedLsY=
=Xmw+
-----END PGP SIGNATURE-----

--BSFSRSoXpjCiBLZV--
