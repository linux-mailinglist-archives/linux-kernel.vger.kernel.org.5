Return-Path: <linux-kernel+bounces-16019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF43823711
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602E71C24667
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F61DA2B;
	Wed,  3 Jan 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="j7f4ijon"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224051DA21;
	Wed,  3 Jan 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 60D068E3;
	Wed,  3 Jan 2024 21:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 60D068E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704317017; bh=hPBXGJx4KuTZLUTGOfnBh0rwbPYSu4hMMIs+rC1U6VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j7f4ijon3vUOPX8Vq7odfdXXtHSDkSpTqhoFLU1pcmAFPjHtBBzKGwYnjB38ItBQ6
	 9xwYENT4cb7o0J2VZYGaicPbsvTOz6kxiGz8W9okyaoB9pAntU8RuwLaHKW/IXHJEC
	 b+pQTqrsa3HptnE7RxJH49D33+wknbeCxY1PErYfSsl6+DuWhZh54MQiPY8OujCQ1a
	 SKUzr8LEX6n3CXQ070/k0F5nf0gy3BbPeNbb6va44J0Xtv256eqIhrddE4cqcMTHgC
	 q1+2GjZI0la5fgX9eMREETeh/ine8IAVZQ/45k4NgabnJLjJrlacZPcAFHfpgkjezb
	 5eiBJ2mfxAqzw==
From: Jonathan Corbet <corbet@lwn.net>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 "JiaLong.Yang" <jialong.yang@shingroup.cn>, Zenghui Yu
 <zenghui.yu@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
In-Reply-To: <20231221055832.4374-1-jialong.yang@shingroup.cn>
References: <20231221055832.4374-1-jialong.yang@shingroup.cn>
Date: Wed, 03 Jan 2024 14:23:36 -0700
Message-ID: <874jfu861z.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"JiaLong.Yang" <jialong.yang@shingroup.cn> writes:

> We know the macro DEBUG will make pr_debug() save the formatted
> string into final binary. But the translation in chinese gives a
> opposite meaning.
>
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> link: https://lore.kernel.org/lkml/a9cbebd8-dd6e-d81c-471f-f40dcc7196ea@linux.dev/
> Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
> link: https://lore.kernel.org/lkml/340cbb78-3e68-4584-8e11-313f7f86fd34@loongson.cn/
> Acked-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>
> V2: add commit info.
> Maybe now I have known about the process of patch.
> Sorry for wasting time of yours.

Applied, thanks.

jon

