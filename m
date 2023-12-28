Return-Path: <linux-kernel+bounces-12693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAF81F8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E68E1C21389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C075882E;
	Thu, 28 Dec 2023 13:54:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B44D517;
	Thu, 28 Dec 2023 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b6838a.dsl.pool.telekom.hu [::ffff:81.182.131.138])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007203F.00000000658D7E1B.0014B1D4; Thu, 28 Dec 2023 14:54:35 +0100
Message-ID: <95023a6158e1359c18797d7ed10a6914cf781f84.camel@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for
 different laptops
From: Gergo Koteles <soyer@irl.hu>
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
  "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
  "13916275206@139.com" <13916275206@139.com>,
  "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "Gupta, Peeyush" <peeyush@ti.com>, "Navada
        	Kanyana, Mukund" <navada@ti.com>
Date: Thu, 28 Dec 2023 14:54:34 +0100
In-Reply-To: <4c924d6a31b54bdba36ce8f71f143fb5@ti.com>
References: <20231223141242.676-1-shenghao-ding@ti.com>
	 <313b19531261e5b94870043be7bdd4666176f562.camel@irl.hu>
	 <4c924d6a31b54bdba36ce8f71f143fb5@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Thu, 2023-12-28 at 07:29 +0000, Ding, Shenghao wrote:
> > On Sat, 2023-12-23 at 22:12 +0800, Shenghao Ding wrote:
> > >=20
> > > +Licence: Allegedly GPLv2+, but no source visible. Marked:
> > > +	 Copyright (C) 2023 Texas Instruments
> > > +
> > > +Found in hex form in kernel source.
> >=20
> > Is this true? Isn't this a new driver?
> Maybe following expression will be more clear
> Firmware will be found in hex form in the system.

And what about the Licence?

I would like to add TAS2XXX3870.bin that I found in my computer's
windows sound driver as Source/ThirdParty/TI/TAS2563Firmware.bin .

Could you please add it, or will TI give permission to redistribute
these files?

The windows driver (innoextract compatible):
https://download.lenovo.com/consumer/mobiles/h5yd037fbfyy7kd0.exe
The RCA file I created:
https://github.com/soyersoyer/tas2563rca/raw/main/INT8866RCA2.bin


> >=20
> > > \ No newline at end of file
> > > diff --git a/ti/tas2781/TAS2XXX387D.bin b/ti/tas2781/TAS2XXX387D.bin
> > > new file mode 100644 index
> > >=20

Regards,
Gergo


