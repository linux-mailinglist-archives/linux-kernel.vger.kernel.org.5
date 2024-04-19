Return-Path: <linux-kernel+bounces-151324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905548AACED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9541C21267
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3167E78F;
	Fri, 19 Apr 2024 10:36:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C523D55B;
	Fri, 19 Apr 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522998; cv=none; b=U3cmIw64f4HnTpxPVlh8cqgb9aDKzg/3CGjE1GLDvceES+Sd2doud9CCpALnnU57RMb337Yy5K0W0sJgHjaaKACk4nLB3MNuLUeKTTFx3DoT8f+zLcXDgQ48shhHX03m2vuM2GELtSvcMd9X2464F2E9elFSaJRlnqaLZgWBGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522998; c=relaxed/simple;
	bh=YwuYrJiDpMf0xpFrF+ROIqaQPvA8R9O7wX9L8vXB5qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgO86g1tIKmZsddBcAqm8UKja9J8UMPoY/0MTpf5RotdGdakdcAGhblUBNTPqOXtdIwZezlXVdbE8km5LHzAZ/f1vikrBH8JfazG1ilSYvnntLV6Q1W9f5cZvv7ek9FrzxxqKPn0Y7I469RvXL+xeOzGxjxLHvPR+wE5qXtwP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxJ+gxSSJmGcIpAA--.8776S3;
	Fri, 19 Apr 2024 18:36:33 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx1xEvSSJmEyKAAA--.36198S3;
	Fri, 19 Apr 2024 18:36:31 +0800 (CST)
Message-ID: <b5d65679-a789-4cf9-b4ba-0db3c0886688@loongson.cn>
Date: Fri, 19 Apr 2024 18:36:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: add process/cve Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240419020114.3391933-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240419020114.3391933-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx1xEvSSJmEyKAAA--.36198S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrury7JrW5WF47Jw45WrW5CFX_yoWfWFb_A3
	97JayqkrZ7tF1xtFW8Cr43JrW8ZF4xuw1DtFn0ka98GayI9FWDWa4Uuwn3urn0vFWSvFW5
	Cr97uryfXFnI9osvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8O18PUUUUU==


在 2024/4/19 10:01, Dongliang Mu 写道:
> Translate process/cve.rst into Chinese and add it to
> Documentation/translations/zh_CN directory.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1 -> v2: add a newline at then end of cve.rst.
>   .../translations/zh_CN/process/cve.rst        | 89 +++++++++++++++++++
>   .../translations/zh_CN/process/index.rst      |  1 +
>   2 files changed, 90 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/process/cve.rst
>
When I apply your patch, git output:

Applying: docs/zh_CN: add process/cve Chinese translation
git/rebase-apply/patch:32: trailing whitespace.
所有分配给Linux内核的CVE列表都可以在linux-cve邮件列表的存档中找到，如
warning: 1 line adds whitespace errors.

checkpatch.pl also outputs associated noise.


Thanks,

Yanteng


