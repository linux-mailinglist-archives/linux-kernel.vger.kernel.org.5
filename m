Return-Path: <linux-kernel+bounces-78346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3C861240
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F521F2371A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C27E777;
	Fri, 23 Feb 2024 13:08:09 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C957AE45;
	Fri, 23 Feb 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693689; cv=none; b=O75Hsftwp+AQaD41nT7MPOO2IM+od/CFpIv1YgXgmarRmfp5A2uN62XqZvZHqhKqsNFPEvRyjeA/Dqea2b6Ex40GU49lu9nfAzRLWMC2v0sxpzBxkF5MY31rRfPeXKtOKiimSfn39BRgZsDhhQdCg1SeZToY4vwprYXbo12R5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693689; c=relaxed/simple;
	bh=tIXnVaFeGALspjxd8jt9xEb3ObztRHp0qb0k+ytZks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tU6Hgs02DR3Do1f4YVk+3i1AO26Xu3YOnLI8mPnW6BynVpneta9a+Kfavch60OMRgd4fETyXavrb+r2yRYOEL1kbDeoktVnJ/WKs0tSbRJtpO9gNwEI7GRY4RWUMujb8SyMUUKdzEMAaJZslKrGHLKZl9JtUtrz/icmLn4WnO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from [IPV6:2a04:ee41:3:b28f:cd3c:2a37:29cd:4172] (unknown [IPv6:2a04:ee41:3:b28f:cd3c:2a37:29cd:4172])
	by mail.someserver.de (Postfix) with ESMTPSA id 29129A21F5;
	Fri, 23 Feb 2024 14:07:54 +0100 (CET)
Message-ID: <474ee63a-3283-4688-9616-0147c2078516@christina-quast.de>
Date: Fri, 23 Feb 2024 14:07:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/19] hid-ft260: Fixes for serial driver patch v4
Content-Language: en-US
To: Jiri Kosina <jikos@kernel.org>,
 Michael Zaidman <michael.zaidman@gmail.com>
Cc: daniel.beer@igorinstitute.com, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-serial@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, johan@kernel.org, gregkh@linuxfoundation.org,
 equinox@diac24.net
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
 <nycvar.YFH.7.76.2402131120070.21798@cbobk.fhfr.pm>
From: Christina Quast <chrysh@christina-quast.de>
In-Reply-To: <nycvar.YFH.7.76.2402131120070.21798@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jiri!

I send Patch v5, feel free to have a look!

Best regards,

Christina

On 2/13/24 11:20, Jiri Kosina wrote:
> On Sat, 10 Feb 2024, Michael Zaidman wrote:
>
>> Modifications on top of "[PATCH v4 RESEND] hid-ft260: Add serial driver"
>> https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/
>>
>> They are mostly the fixes to the original v4 patch and should be melded into
>> the v5 patch rather than upstreamed as separate patches.
> Agreed; I am not acting upon this series now then, and will wait for v5
> with these folded in.
>
> Thanks,
>

