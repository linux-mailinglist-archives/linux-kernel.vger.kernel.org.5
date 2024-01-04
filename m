Return-Path: <linux-kernel+bounces-17274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9E824AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43271C2290B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064C2C86A;
	Thu,  4 Jan 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BF/kKbgI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB52C851;
	Thu,  4 Jan 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704406181;
	bh=nMwM4tabfgvUmj/yESFJVCo5ldndFofaIIe+kUJVT/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BF/kKbgIenjtl6Ye8bLyw/8sAiTdyFENfv7XZWc2/oVwuWBycGkg7uoA0P8yDAT3L
	 fILAlRdePVhcXdBCKHW74MEBKcmdM7OdS6OXi0c5CwWGeJzMqzwoD/XEsyMycrqOZW
	 T9g3/MEDp0P72wgo82JxzGeBcxMVilIKN31MqonwYe5aAdHfQ4L5RhjdssDXNQNxaS
	 zdOX4iMCg11bE6A+RPGT5LBxX020Bz7GWVAKebHHqhjoH39hQy1HQSgcdUefKMoM4v
	 jDBgUso3FK4mXzpEZP1bBzkQ8TdiQT0tcdIgG2akCe0Jq6jKixon340LU71fpVQ+Ec
	 7Z6F2CgCheUFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5gjx1FdGz4x7V;
	Fri,  5 Jan 2024 09:09:40 +1100 (AEDT)
Date: Fri, 5 Jan 2024 09:09:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <20240105090939.704a5fed@canb.auug.org.au>
In-Reply-To: <659729ee7673a_8dc682941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102023218.3cd3e4ea@canb.auug.org.au>
	<20240105085306.60979082@canb.auug.org.au>
	<659729ee7673a_8dc682941d@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=I/oHD6_vaDW2nyyXF=K0L9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=I/oHD6_vaDW2nyyXF=K0L9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 4 Jan 2024 13:58:06 -0800 Dan Williams <dan.j.williams@intel.com> w=
rote:
>
> Yes, will do that promptly. I am trying to figure out how this happend.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/=I/oHD6_vaDW2nyyXF=K0L9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXLKMACgkQAVBC80lX
0GxxFAgAjsM6Nzo9hjB5/eLl+ylk89hnVuR+aGcTS7s4oDkeaAUEeMOP1Ojbe7XA
blpHuCE4Lci2a5N83jcs0zpEV7ahyHnwDAswU7OxThUeuQp8F5tNRV6ZhuOddR+l
mbryBMlRql1VINHO5SiwVIK8iD1iI7JC5JFF6OdyM5uS/HuSnE76gWJTucITknxX
fyTDEytCKV8RWOupfbwyel6XNPwxZKjK+TOwmZTUhpML20p+NCRaSsPfvtpD7zSb
HTUlFrWm2oEAgZkcO8ge+itjsnn+qGK++CN6gKE5v9PTx9YZ6tkzU+a4xjfUvk0Y
bB31RPeyQGFIH0BqzSCeVad/lBcHaQ==
=nKt9
-----END PGP SIGNATURE-----

--Sig_/=I/oHD6_vaDW2nyyXF=K0L9--

