Return-Path: <linux-kernel+bounces-26904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D514982E7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DBAB20B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30085789A;
	Tue, 16 Jan 2024 01:15:04 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB12136E;
	Tue, 16 Jan 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TDWJH5D5Gz1wnBy;
	Tue, 16 Jan 2024 09:14:39 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 328711400DA;
	Tue, 16 Jan 2024 09:14:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 09:14:57 +0800
Message-ID: <f431fa49-ebdd-4116-95d6-001b1c714109@huawei.com>
Date: Tue, 16 Jan 2024 09:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 0/3] minor improvements for x86 mce processing
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Tong Tiangen <tongtiangen@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Guohanjun <guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <e453b190-d387-4b74-bb2c-fbbd2a5c488d@huawei.com>
 <20240115133354.GFZaU0Qk2lYmMSkwM9@fat_crate.local>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240115133354.GFZaU0Qk2lYmMSkwM9@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/15 21:33, Borislav Petkov wrote:
> On Mon, Jan 15, 2024 at 09:25:57PM +0800, Kefeng Wang wrote:
>> could you give us some comments about it, many thanks.
> 
> Since we have a (suspended¹) merge window currently:
> 
> From: Documentation/process/maintainer-tip.rst
> 
> Merge window
> ^^^^^^^^^^^^
> 
> Please do not expect large patch series to be handled during the merge
> window or even during the week before.  Such patches should be submitted in
> mergeable state *at* *least* a week before the merge window opens.
> Exceptions are made for bug fixes and *sometimes* for small standalone
> drivers for new hardware or minimally invasive patches for hardware
> enablement.
> 
> During the merge window, the maintainers instead focus on following the
> upstream changes, fixing merge window fallout, collecting bug fixes, and
> allowing themselves a breath. Please respect that.
> 
> The release candidate -rc1 is the starting point for new patches to be
> applied which are targeted for the next merge window.

Oh, sure, we could resend after -rc1, thanks.
> 
> ¹ https://lore.kernel.org/r/CAHk-=wjMWpmXtKeiN__vnNO4TcttZR-8dVvd_oBq%2BhjeSsWUwg@mail.gmail.com
> 

Hope everything is OK!

