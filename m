Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFF7630A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjGZI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGZI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:58:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B416191;
        Wed, 26 Jul 2023 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690361500; x=1721897500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b849BiVNxFGwobNm6VSbnznl9V2OQQo2IkdXuTzxITA=;
  b=zzoFWsdXmJS6G4jtldjsfjGK58D9B5/4oXAA7eOwMkpJdXmH1gpDtMe2
   Auo7RFMB8WA7rr2VLphdVs0CBzHh9VvkaN+sCo+eNz2nMayy3AJ6QK6vp
   SHb6Qo/kYJj1nLD/ylPDce6eLl/TYUoay/g0Q4P+xhK24QPbn0Z5YJLaB
   AC9MX/ZaZamIVL4B/+lQATt/WsiprzNjus7gLyxES7NFu1gSmMAeGJd7u
   viLXT2ZwOdUd9AzlNPeN7sp+/lpxyBewutQY1xdrIwPtyt3gw0hmGByik
   0Aw9I+VP6G1YW8lSNkE4mQ5WU/2DucHn6JUlMXHfiM/uOJ4QNYxcZ4Sts
   w==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="237843909"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 01:51:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 01:51:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Jul 2023 01:51:37 -0700
Date:   Wed, 26 Jul 2023 09:51:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mm-commits@vger.kernel.org>, <surenb@google.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
Subject: Re: +
 mm-drop-per-vma-lock-when-returning-vm_fault_retry-or-vm_fault_completed-fix.patch
 added to mm-unstable branch
Message-ID: <20230726-navy-eatery-76a68523906b@wendy>
References: <20230725173416.EFD4EC433C9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NCZVmOj36oQD+Pc"
Content-Disposition: inline
In-Reply-To: <20230725173416.EFD4EC433C9@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8NCZVmOj36oQD+Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 10:34:16AM -0700, Andrew Morton wrote:
>=20
> The patch titled
>      Subject: mm-drop-per-vma-lock-when-returning-vm_fault_retry-or-vm_fa=
ult_completed-fix
> has been added to the -mm mm-unstable branch.  Its filename is
>      mm-drop-per-vma-lock-when-returning-vm_fault_retry-or-vm_fault_compl=
eted-fix.patch
>=20
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree=
/patches/mm-drop-per-vma-lock-when-returning-vm_fault_retry-or-vm_fault_com=
pleted-fix.patch
>=20
> This patch will later appear in the mm-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>=20
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>=20
> *** Remember to use Documentation/process/submit-checklist.rst when testi=
ng your code ***
>=20
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>=20
> ------------------------------------------------------
> From: Matthew Wilcox <willy@infradead.org>
> Subject: mm-drop-per-vma-lock-when-returning-vm_fault_retry-or-vm_fault_c=
ompleted-fix
> Date: Tue, 25 Jul 2023 15:31:17 +0100
>=20
> fix riscv
>=20
> Link: https://lkml.kernel.org/r/CAJuCfpE6GWEx1rPBmNpUfoD5o-gNFz9-UFywzCE2=
PbEGBiVz7g@mail.gmail.com
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
>   Closes: https://lkml.kernel.org/r/20230725-anaconda-that-ac3f79880af1@w=
endy
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Things look good in today's next with this fix. Thanks.

--8NCZVmOj36oQD+Pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDedgAKCRB4tDGHoIJi
0olXAP9bZhMw1QS/0UAlmrKBlSydfVncap53pvewJZAmqv1+sAEAjqxmQw40XWvX
aCrwvJimhalYmV7xjqL1SfeP1tkZew0=
=+Cpn
-----END PGP SIGNATURE-----

--8NCZVmOj36oQD+Pc--
