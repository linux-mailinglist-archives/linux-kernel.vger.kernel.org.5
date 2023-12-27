Return-Path: <linux-kernel+bounces-11991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831781EE96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA31C218FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CA446B5;
	Wed, 27 Dec 2023 11:40:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDC446AB;
	Wed, 27 Dec 2023 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b681e3.dsl.pool.telekom.hu [::ffff:81.182.129.227])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071CB4.00000000658C0D40.001494F8; Wed, 27 Dec 2023 12:40:48 +0100
Message-ID: <313b19531261e5b94870043be7bdd4666176f562.camel@irl.hu>
Subject: Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for different laptops
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, linux-firmware@kernel.org
Cc: kevin-lu@ti.com, baojun.xu@ti.com, 13916275206@139.com,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  peeyush@ti.com, navada@ti.com
Date: Wed, 27 Dec 2023 12:40:47 +0100
In-Reply-To: <20231223141242.676-1-shenghao-ding@ti.com>
References: <20231223141242.676-1-shenghao-ding@ti.com>
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

On Sat, 2023-12-23 at 22:12 +0800, Shenghao Ding wrote:
>=20
> +Licence: Allegedly GPLv2+, but no source visible. Marked:
> +	 Copyright (C) 2023 Texas Instruments
> +
> +Found in hex form in kernel source.

Is this true? Isn't this a new driver?

> \ No newline at end of file
> diff --git a/ti/tas2781/TAS2XXX387D.bin b/ti/tas2781/TAS2XXX387D.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..3ce40ae9d715727092bffe1e1=
8a6a7e50ea41eed
> GIT binary patch
> literal 64504

Regards,
Gergo


