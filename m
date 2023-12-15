Return-Path: <linux-kernel+bounces-956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534081487B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DE3285EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D062E40B;
	Fri, 15 Dec 2023 12:52:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4292DF8F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ss8J54Mmpz1wnmx;
	Fri, 15 Dec 2023 20:52:21 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id EBC64140419;
	Fri, 15 Dec 2023 20:52:30 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 15 Dec 2023 20:52:30 +0800
Message-ID: <7a5e47ed-dfd0-3619-6591-b44e26b9237d@huawei.com>
Date: Fri, 15 Dec 2023 20:52:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] Fix some bugs in ubi_resize_volume() function
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20230406071331.1247429-1-wangzhaolong1@huawei.com>
 <9adbe147-95a6-a858-f65a-83028df4209d@huawei.com>
In-Reply-To: <9adbe147-95a6-a858-f65a-83028df4209d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Friendly ping.



> Please don't forget to discuss this issue.
> 
> V2
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=353394
> 
> Friendly ping.
> 
> Thanks
> Zhaolong
> 
>> This series of patches does two things:
>>    1. Rebase the patch commited by Guo Xuenan on the latest mainline.
>>    2. Fixed an issue where the number of PEBs is incorrectly displayed.
>>
>> Guo Xuenan (1):
>>    ubi: fix slab-out-of-bounds in ubi_eba_get_ldesc+0xfb/0x130
>>
>> ZhaoLong Wang (1):
>>    ubi: Correct the number of PEBs after a volume resize failure
>>
>>   drivers/mtd/ubi/vmt.c | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>>
> 


