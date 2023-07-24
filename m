Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA575ECBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGXHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGXHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:47:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514EBE66
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690184819; x=1721720819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WzzWzxRZEWi4NlHzgReqT/THYQBX4Y5rgyq6qdtTy3M=;
  b=0wlUqKrHBO4OvqMCSSpmz1gc+ptk61Kk2EU8Gg+VISA5KbOAVuMbiRJ1
   iAyJ65qF/L6mnmtRSa11sZN5z+D1GTQayJvO7vIakn1DdkIYCtYeggLu8
   AnKE5KkJWUAn5LkUzuDJgNMUde4hIRf4DhD0Nv8KVDQMvJGrI3LwY1ZZ2
   D5JVbVtpjX7KI+iQPxbfckB1uL3qTmWVdjczoinlbkShMzh66NtJ3A7cB
   Q4q3vgpDcVanVc/8EOB6hQWPHI725DrJhQZ4VcOSKbm0yOUcR1dqOn105
   /BODuTld8XH9S+EG02p8DiQ2qwsED+15TF/tdhplDb4evIZb9x9RROoqx
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="224719718"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 00:46:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 00:46:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 00:46:56 -0700
Date:   Mon, 24 Jul 2023 08:46:23 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yuan Tan <tanyuan@tinylab.org>
CC:     <palmer@dabbelt.com>, <vincent.chen@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <falcon@tinylab.org>
Subject: Re: [PATCH] riscv: alternatives: fix a typo in comment
Message-ID: <20230724-stegosaur-outtakes-0ea4ff740080@wendy>
References: <20230723165155.4896-1-tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IsUXUH9IpPy2edZ3"
Content-Disposition: inline
In-Reply-To: <20230723165155.4896-1-tanyuan@tinylab.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IsUXUH9IpPy2edZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 12:51:55AM +0800, Yuan Tan wrote:
> In the usage of ALTERNATIVE, "always" is misspelled as "alwyas".
>=20
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--IsUXUH9IpPy2edZ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL4sTgAKCRB4tDGHoIJi
0kgRAP4q71Pyz7QgJzZHSva3JyBY/cP8KT+YthQI9nYwQdnHYQD9HLanh7VBwu5R
nXz3sjGRiJ508KlDmgmMthP3mIsBVQs=
=XsAI
-----END PGP SIGNATURE-----

--IsUXUH9IpPy2edZ3--
