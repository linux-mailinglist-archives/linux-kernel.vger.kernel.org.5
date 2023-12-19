Return-Path: <linux-kernel+bounces-5022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C69818572
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F6287711
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149C14ABB;
	Tue, 19 Dec 2023 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cctn1laj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69614F68;
	Tue, 19 Dec 2023 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8N7yci3+9+00ctBeBhes4f3Q4XVQnQMFp6bL/Qb9l4k=;
	t=1702982482; x=1704192082; b=cctn1lajPsfqpOXdT1FtrOQJPVXY5FN/f/lkTjXJYSAHKsO
	an1nopay5HGP8F5nwaL+ANtxWqzn25fBBUw8x5xIs29FqOblp8Gx+gguHeL1XVi2WD5F4l2H6wEE7
	CuvzdwIRKmDAhBtbrmPxm+dQGVZAeAJtxUepyZrKn2WHQpL586sXU7TDOksRa7YxmZGSfCOClnLPS
	6BGtJbHZ407MKzlVq8PjXqvIrKEJeANZA+SvVRLv96Ksbv3/1U3hyhTvuJ+HzP008WipirESp3c0J
	8tQgAoQc2/ToVFpPZSU+6ES5MqB98AKFJoOcwpLUQMQSlfVm0gEiX5NHkhZSk1OA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFXXL-0000000HZLo-3DpF;
	Tue, 19 Dec 2023 11:41:20 +0100
Message-ID: <29c3122ca8e4d72c07942d09dca7a0fbd0138024.camel@sipsolutions.net>
Subject: Re: MAINTAINERS: wifi: brcm80211: remove non-existing
 SHA-cyfmac-dev-list@infineon.com
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo
	 <kvalo@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
 linux-wireless@vger.kernel.org,  brcm80211-dev-list.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 19 Dec 2023 11:41:18 +0100
In-Reply-To: <18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
	 <170295913267.640718.8284035097366475252.kvalo@kernel.org>
	 <18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-19 at 10:01 +0100, Arend Van Spriel wrote:
> >=20
> > > When sending an email to SHA-cyfmac-dev-list@infineon.com, the server
> > > responds '550 #5.1.0 Address rejected.'
>=20
> Is the claim here true? In another thread I replied all including this li=
st=20
> and I am not getting a bounce message.

I also got the bounce, FWIW. And Lukas is using gmail ... if you're not
accepting mail from gmail I'm not sure you get to call it "email" in the
21st century, for (better or) worse...

johannes


