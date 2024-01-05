Return-Path: <linux-kernel+bounces-17373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348ED824C64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBB9284026
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22881C10;
	Fri,  5 Jan 2024 01:12:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642A1854;
	Fri,  5 Jan 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T5llb6168zsVD1;
	Fri,  5 Jan 2024 09:11:23 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 47DA718006F;
	Fri,  5 Jan 2024 09:12:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 09:12:00 +0800
Message-ID: <6126f6ae-e4af-49ce-8536-8e2cd2cfc8b2@huawei.com>
Date: Fri, 5 Jan 2024 09:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <lanhao@huawei.com>,
	<wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 net-next 0/4] There are some features for the HNS3
 ethernet driver
To: Jakub Kicinski <kuba@kernel.org>
References: <20231219013513.2589845-1-shaojijie@huawei.com>
 <7f561916-a7ad-4189-b3a7-dfe43f9daeaa@huawei.com>
 <20240104074843.29021784@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240104074843.29021784@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/1/4 23:48, Jakub Kicinski wrote:
> On Thu, 4 Jan 2024 19:17:35 +0800 Jijie Shao wrote:
>> Excuse me, This series has not been applied for a long time.
>>
>> Is there any problem with this series?
> It got marked as Changes Requested over the winter shutdown / break.
> I'm not exactly sure why, to be honest. Please repost.

Okay, I've reposted it.

Thank you


