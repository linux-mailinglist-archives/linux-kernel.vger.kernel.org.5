Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D57A0477
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjINMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjINMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:52:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1F81FD4;
        Thu, 14 Sep 2023 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694695975; x=1726231975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8s25WatzmU94RNlxbxB/Hw41unguyib9JCdA3p+ARYY=;
  b=e+QCkK0qasxmqpjuJlJLYTFVn8vQR7avDpJEQXyNio3yFjScgWuAkZ8D
   2opy748y7qW+jiN1RWUL2N9Nt1V74/DaifA3f6FH/Utzv+23nDwR5vKGJ
   UktKsYQL5VpEgigaZ0HdUoZJQeH1IWVCnWxfh/fhsutnpj8Ylhs5kGECE
   L8W+oqszHlKugjHI6ckoNvc8hgWrRjvUuaFzRREGs+Qofy8Nq8s8fhFoY
   iB0WW0pz/LvuUZOPYVFr45tvJVleTIQx8Uw6yPZI8zKOS2kYtz7L8bNN3
   RNuRKMzdK5wqPX+W/I7vCODjd00kkWPCfkrXx1fMeczFNVBS2FZnoWyaY
   w==;
X-CSE-ConnectionGUID: MHhbKamLRwmqzRdOP1rdaw==
X-CSE-MsgGUID: xoGOVLF1RpqFYHafGCOX1A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="4660688"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 05:52:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 05:52:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 05:52:50 -0700
Date:   Thu, 14 Sep 2023 13:52:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] riscv: Add BLAKE2s V implementation
Message-ID: <20230914-charting-detector-3d2b615393b9@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230912115728.172982-7-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lx6ML45DQfnbK0fy"
Content-Disposition: inline
In-Reply-To: <20230912115728.172982-7-bjorn@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Lx6ML45DQfnbK0fy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 01:57:28PM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> BLAKE2s is used in various places, most notably in Wireguard, and as
> of v5.17 in drivers/char/random.
>=20
> Add a BLAKE2s implementation using the V-extension. This is a
> translation of the x86-64 AVX512 variant
> (arch/x86/crypto/blake2s-core.S) to the RISC-V V-extension.
>=20
> The AVX512 variant requires registers >=3D 256b (ymm*), and hence this
> implementation requires a VLEN of >=3D256.
>=20
> The implementation passes the kernel BLAKE2s selftest, and has been
> tested on spike and qemu.
>=20
> Instruction-wise, the V-variant uses 60% less instructions than the
> generic, C-based, implementation.
>=20
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

>  arch/riscv/crypto/blake2s-v.S    | 164 +++++++++++++++++++++++++++++++


This file is currently being built for !RISCV_ISA_V, leading to build errors
for obvious reasons. Eg:
=2E./arch/riscv/crypto/blake2s-v.S:62:2: error: instruction requires the fo=
llowing: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zv=
e64x' (Vector Extensions for Embedded Processors)


--Lx6ML45DQfnbK0fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMCEgAKCRB4tDGHoIJi
0u8xAQCEJlgd/xtyR113nnnStiJaDMwGGembL9EYTsSNHf1FFAD/VsDT0C1/NjgQ
ECaj3824nVo5YO0goL1J6DWPwxWnKgE=
=zWgG
-----END PGP SIGNATURE-----

--Lx6ML45DQfnbK0fy--
