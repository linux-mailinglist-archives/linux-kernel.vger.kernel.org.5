Return-Path: <linux-kernel+bounces-17463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F6D824D91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA3928694E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125E63BF;
	Fri,  5 Jan 2024 04:04:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AEE6127
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: by smtp.gentoo.org (Postfix, from userid 559)
	id 0623D3430AE; Fri,  5 Jan 2024 04:04:10 +0000 (UTC)
Date: Thu, 4 Jan 2024 23:04:09 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Richard Palethorpe <io@richiejp.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	Wanlong Gao <wanlong.gao@easystack.cn>,
	Wanlong Gao <wanlong.gao@gmail.com>,
	Jan Stancek <jstancek@redhat.com>,
	Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
	Li Wang <liwang@redhat.com>, Yang Xu <xuyang2018.jy@fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Subject: Re: [PATCH 1/1] MAINTAINERS: Update LTP maintainers
Message-ID: <ZZd_ucdyTrk5EPYv@vapier>
References: <20240104154953.1193634-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ltlYhuj8kbqrfqEj"
Content-Disposition: inline
In-Reply-To: <20240104154953.1193634-1-pvorel@suse.cz>


--ltlYhuj8kbqrfqEj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

can't really argue with your logic.  you've been doing so well i don't feel
the need to contribute that much anymore.  and it doesn't help that my job
no longer involves LTP ;).
-mike

--ltlYhuj8kbqrfqEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAmWXf7kACgkQQWM7n+g3
9YG82g/+PkIAolK6M/B1xGaxfCzJytphGvuEWnMJEA6EC6WmIx/UOBDUH76E4ArJ
3EipmBca/2e4qx6Y3q76yAgLKnAoM2LUwX6qtHLzHjsg3QMLQZjkAh//nDMIOG/D
SRa/3FlulPD1ZHcDgbvB6gdMvHzdHcZztPRJ3T5ZD5bhwcWrBJY+JSRFXI4mghWm
ZMRBe/zihTHQvTSJckJASVr99VlIaDSpMmpI1PlXnnz23XkV39qsPVAFuGBdPpwa
paPDi6NGVxDYFntwCEjto90+MpRmNFWXasxENVk72t06qst0icZGgdAPkeQSkWPK
123H0JtMuf2yZzRRp0qAj35Nq3OmPGL6umHUEY+CmcBxTaTVf9ccamfBtfJ7HCLF
ce4Qa4Y36VQvfx2xQf4DfB1iWBYOkd447UKMi06InZERIg9pT/JNvIzfsmRFjjLF
AxUTFQ/F83ncYyep00IXu8OPjm1GMhulvAHFFSfy6AUflgWa3sAb7zklEnDEmFfx
8UZqnm/kb0bSvkTg2eMuwr/7NMnPmx7q2P3IWQqVLofR86n2t5mbACq0GcXR4o+w
et8rjFs0PVeFLVELICoDi3hgElWODCuLFD3MvdxxtBMbqFMYiyuHBTJytcVhvSYm
zFp6fqibpXCJap+OI2bap3jWFFG5/sxLT7ohBRu+L1jtbwyj58g=
=XKWI
-----END PGP SIGNATURE-----

--ltlYhuj8kbqrfqEj--

