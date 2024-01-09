Return-Path: <linux-kernel+bounces-20541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE408828069
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CB9B22BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5B1F601;
	Tue,  9 Jan 2024 08:19:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F913ACF;
	Tue,  9 Jan 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T8P1r43p0z29kGR;
	Tue,  9 Jan 2024 16:17:52 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BEBD1A0190;
	Tue,  9 Jan 2024 16:19:23 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:19:22 +0800
Message-ID: <866421af-16df-4911-8367-16523516b81e@huawei.com>
Date: Tue, 9 Jan 2024 16:19:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
	<lanhao@huawei.com>, <wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 net-next 1/4] net: hns3: add command queue trace for
 hns3
To: Jiri Pirko <jiri@resnulli.us>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <20240105010119.2619873-2-shaojijie@huawei.com> <ZZfRU3QyRIUUUbRi@nanopsycho>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZZfRU3QyRIUUUbRi@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/1/5 17:52, Jiri Pirko wrote:
> Fri, Jan 05, 2024 at 02:01:16AM CET, shaojijie@huawei.com wrote:
>> From: Hao Lan <lanhao@huawei.com>
>>
>> Currently, the hns3 driver does not have the trace
>> of the command queue. As a result, it is difficult to
>> locate the communication between the driver and firmware.
>> Therefore, the trace function of the command queue is
>> added in this test case to facilitate the locating of
>> communication problems between the driver and firmware.
> Use imperative mood in the patch desctiption so it is clear what is the
> intention of the patch:
> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>
Thanks, This patch desctiption will be rewritten in imperative mood in the next version.


