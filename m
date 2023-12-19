Return-Path: <linux-kernel+bounces-5392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF3818A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0671F2AB62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F420DE0;
	Tue, 19 Dec 2023 14:36:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607C20DEA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SvfPn6J2DzvSD7;
	Tue, 19 Dec 2023 22:35:57 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 68B5C140390;
	Tue, 19 Dec 2023 22:36:51 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 19 Dec 2023 22:36:50 +0800
Message-ID: <04b4c375-d890-9458-5d62-0a9ba74b8c68@huawei.com>
Date: Tue, 19 Dec 2023 22:36:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by ftl
 notifier
To: Richard Weinberger <richard@nod.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Artem Bityutskiy
	<Artem.Bityutskiy@nokia.com>, dpervushin <dpervushin@embeddedalley.com>,
	linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, chengzhihao1 <chengzhihao1@huawei.com>, yi
 zhang <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
 <20231027194026.1bc32dfe@xps-13>
 <174426702.13324.1698438610904.JavaMail.zimbra@nod.at>
 <20231029145033.0ad2682a@xps-13>
 <142222867.20038.1698593973984.JavaMail.zimbra@nod.at>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <142222867.20038.1698593973984.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Friendly ping...

I'd like to know what the current status of this patch is. Is there a 
need for further programme improvements?

Bast regards,
ZhaoLong Wang


> ----- Ursprüngliche Mail -----
>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> Ack. I'll queue this once the log fixed and your official Ack-by
>> received for mtd/next after -rc1 is out.
> 
> Acked-by: Richard Weinberger <richard@nod.at>
> 
> Thanks,
> //richard
> 


