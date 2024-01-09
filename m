Return-Path: <linux-kernel+bounces-20543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E07828070
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA91C258CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66722063;
	Tue,  9 Jan 2024 08:20:14 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4D134C3;
	Tue,  9 Jan 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T8P4432Ypz1vs8K;
	Tue,  9 Jan 2024 16:19:48 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id F15F01404F1;
	Tue,  9 Jan 2024 16:20:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:20:03 +0800
Message-ID: <d133f3d5-3b92-4e9d-9b05-038306b2f981@huawei.com>
Date: Tue, 9 Jan 2024 16:20:03 +0800
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
Subject: Re: [PATCH V4 net-next 0/4] There are some features for the HNS3
 ethernet driver
To: Jiri Pirko <jiri@resnulli.us>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <ZZfQ4XRlqde31qgN@nanopsycho>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZZfQ4XRlqde31qgN@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/1/5 17:50, Jiri Pirko wrote:
> Fri, Jan 05, 2024 at 02:01:15AM CET, shaojijie@huawei.com wrote:
>> There are some features for the HNS3 ethernet driver
> This is quite odd patchset cover letter subject and description. You
> should try to be more specific in the subject and more descriptive
> here in the description.
>
>
Yes, there really should be a more detailed description here.
Thank you for reminding us.


